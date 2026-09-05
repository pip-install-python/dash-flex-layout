#!/usr/bin/env python3
"""Smoke battery for a 2plot satellite — CI container and production alike.

One script, two seats, the SAME named checks either way, so a failure in CI
and a failure against production read identically:

    CI container   python scripts/network_smoke.py --base-url http://localhost:8550
    Production     python scripts/network_smoke.py --base-url https://flexlayout.2plot.dev

Stdlib-only on purpose: CI runs it from the host against the booted container
with a bare `python3`, before anything is pip-installed.

This is a TEMPLATE FILE. Every satellite forked from this repo copies it
verbatim and changes only the block marked "per-site" below — the expected
H1, the port, the paths that must 404. Everything else is the network
standard; if a check here is wrong, it is wrong on twenty hosts.

What a satellite is to the network is what the battery proves: that it states
its identity, that its agent-facing document surfaces are real, that it runs
the intended dash-improve-my-llms artifact, and that no owner-only surface
leaks. A satellite holds no key material of its own, so unlike the hub's copy of
this script there is no key to mint — but since the gate-wave pass this host
does expose `/api/agent-key`, which turns a browser's Clerk session into a
portable `?key=` for copied llms.txt URLs. It must answer 204 to anyone
without a session, which is checked below; the other half of the chain is
that this host's llms.txt points *back* at the hub that holds the authority.

Every UA this script sends carries the internal-traffic token (the analytics
point of truth — https://2plot.ai/docs/satellite-analytics, "Internal
traffic"): a battery must never register as a visitor or a "bot" in any
network ledger. Even the deliberately crawler-shaped probe appends the token
— the target still exercises its bot path, but its analytics know the caller
is machinery.

Exit code: 1 if any check fails, else 0.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import ssl
import sys
import time
import urllib.error
import urllib.request

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

TIMEOUT = 30
try:
    from lib.constants import PROBE_UA_SUFFIX as _INTERNAL_UA
except Exception:  # running outside a repo checkout — keep the token intact
    _INTERNAL_UA = "2plot-internal/probe"
# Item 17 (2026-08-30): the bare internal token, with no browser engine
# token, landed on the CRAWLER lane at dimll >=2.8 (a User-Agent with no
# `Mozilla/...AppleWebKit/...` engine token is crawler-lane by default —
# item 12's contract) — every default-UA check in this battery was quietly
# reading the prerendered crawler document instead of the browser one. Same
# fix scripts/smoke_live.py's BROWSER_UA already had: a real Chrome token
# FIRST, the internal token AFTER it (INTERNAL_UA_TOKEN is a substring
# match, so appending it costs nothing — the tracker still drops the hit).
BROWSER_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 "
    + _INTERNAL_UA + " network-smoke"
)
UA = BROWSER_UA
CRAWLER_UA = "Mozilla/5.0 (compatible; Googlebot/2.1) " + _INTERNAL_UA

# The body dash-improve-my-llms serves when a page has no prose registered.
# Matched in full, deliberately: this app's own <noscript> block legitimately
# says "requires JavaScript", and a substring check on that phrase reports a
# perfectly healthy host as broken. (It did, the first time this ran.)
STUB_MARKER = "This page contains interactive content that requires JavaScript"

# ---------------------------------------------------------------- per-site --
# The three values a fork changes. Everything below this block is the network
# standard and is copied verbatim.

# This app's one identity (lib/constants.SITE_BRAND). tests/test_site_identity
# asserts every local surface carries it; this pins the DEPLOYED artifact to
# it, which is the half no unit test can reach.
SITE_H1 = "# flexlayout-dash — resizable panel layouts for Dash"

# The container port. Matches the Dockerfile's EXPOSE and CMD.
DEFAULT_BASE_URL = "http://localhost:8055"

# Owner-only surfaces that must 404 their llms.txt to an anonymous reader.
# Both entries are real pages on this host: pages/control_board.py and
# pages/traffic.py each call mark_hidden("/admin/..."), which keeps the page
# out of /sitemap.xml, out of the MCP resource set, out of the prerender,
# and 404s crawler requests — this is the outside proof the call is still
# there. Pinned against dash.page_registry by
# tests/test_nav_contract.py::test_battery_hidden_paths_match_the_registry
# (item 18, note 74) so a page added, renamed or deleted moves this tuple in
# the SAME change — this list drifted once already (the pre-item-16 canary
# entries below named paths that were never real pages, while the actual
# /admin/traffic page this fork added went unlisted).
HIDDEN_DOC_PATHS = (
    "/admin/control-board/llms.txt",
    "/admin/traffic/llms.txt",
)

# The hub one level up the chain. A satellite's llms.txt must name it — that
# is what lets an agent walk from any leaf to the network root.
HUB_URL = "https://2plot.dev"

# ---------------------------------------------------------------------------

PASS, FAIL, WARN, SKIP = "pass", "FAIL", "warn", "skip"
_RESULTS: list[tuple[str, str, str]] = []  # (name, verdict, detail)


class SmokeSkip(Exception):
    """This check does not apply to this host.

    A SKIP is a VERDICT, never a pass (note 88): a check that swept nothing
    and a check that found nothing produce the same green otherwise, and the
    one that swept nothing is the one nobody notices.
    """


class SmokeFailure(Exception):
    pass


def _ssl_context() -> ssl.SSLContext:
    """Verify certificates via certifi when it is importable.

    The same fix scripts/smoke_live.py carries, arriving here for the same
    reason and one round later (SYNC-1.6.22-1.6.29 §B addendum): macOS
    Python ships without OS trust-store integration, so a bare urllib https
    fetch dies with CERTIFICATE_VERIFY_FAILED — and `fetch` below RAISES
    after its retries, so the battery reports a perfectly healthy host as
    down, from a Mac only. CI and CD never see it (Linux verifies fine),
    which is exactly what let the smoke_live half of this defect survive as
    long as it did.

    `try`/`except ImportError`, not a hard import: this script's contract is
    stdlib-only — "runs anywhere without an install step", and ci.yml calls
    it with a bare `python3` against the container before anything is
    pip-installed. Verification stays ON either way; certifi only supplies
    the CA bundle.
    """
    try:
        import certifi

        return ssl.create_default_context(cafile=certifi.where())
    except ImportError:
        return ssl.create_default_context()


SSL_CONTEXT = _ssl_context()


class _Headers(dict):
    """Lower-cased response headers that remember repeats.

    ``dict`` semantics are unchanged (last value wins on ``h["link"]``) so
    every existing caller keeps working; ``get_all()`` returns every value a
    name arrived with, which is what a multi-valued `Link` needs.
    """

    def __init__(self, message):
        self._all: dict = {}
        for key, value in message.items():
            self._all.setdefault(key.lower(), []).append(value)
        super().__init__({k: v[-1] for k, v in self._all.items()})

    def get_all(self, name: str) -> list:
        return list(self._all.get(name.lower(), []))


def fetch(url: str, ua: str = UA, method: str = "GET",
          body: bytes | None = None, headers: dict | None = None,
          timeout: int = TIMEOUT, retries: int = 3):
    """(status, headers, text) — HTTP errors are results, not exceptions;
    network errors raise AFTER retries.

    Response headers come back lower-cased: gunicorn sends `content-type`,
    proxies often re-case it — callers must not care. (A CI-only failure in
    the network root's battery was exactly that difference.)

    They also come back as a ``_Headers`` mapping that KEEPS REPEATED NAMES
    (1.6.44 item 5). A plain ``{k: v for k, v in r.headers.items()}`` keeps
    only the LAST value of a repeated header, which silently drops half of a
    multi-valued `Link`; and `get_all()` alone is necessary but not
    sufficient, because a comma-FOLDED single value is equally legal and is
    what this host serves over HTTP/2. Callers that want every value use
    ``headers.get_all(name)``; ``headers[name]`` keeps its old meaning.
    """
    last_exc: Exception | None = None
    for attempt in range(retries):
        if attempt:
            time.sleep(2 * attempt)
        req = urllib.request.Request(url, data=body, method=method)
        req.add_header("User-Agent", ua)
        for k, v in (headers or {}).items():
            req.add_header(k, v)
        try:
            with urllib.request.urlopen(
                    req, timeout=timeout, context=SSL_CONTEXT) as r:
                return (r.status, _Headers(r.headers),
                        r.read().decode("utf-8", "replace"))
        except urllib.error.HTTPError as e:
            return (e.code, _Headers(e.headers),
                    e.read().decode("utf-8", "replace"))
        except Exception as exc:  # timeout, reset, truncated read, …
            last_exc = exc
    raise last_exc


def record(name: str, verdict: str, detail: str = "") -> None:
    _RESULTS.append((name, verdict, detail))
    print(f"[{verdict:>4}] {name}" + (f" — {detail}" if detail else ""), flush=True)
    if verdict == WARN and os.getenv("GITHUB_ACTIONS"):
        print(f"::warning title=network-smoke {name}::{detail}", flush=True)


def check(name: str, fn) -> None:
    try:
        fn()
        record(name, PASS)
    except SmokeSkip as exc:
        record(name, SKIP, str(exc))
    except SmokeFailure as exc:
        record(name, FAIL, str(exc))
    except Exception as exc:  # network/parse error → still a failure
        record(name, FAIL, f"{type(exc).__name__}: {exc}")


def expect(cond: bool, msg: str) -> None:
    if not cond:
        raise SmokeFailure(msg)


def skip(msg: str) -> None:
    """This check does not apply to this host. Never a pass."""
    raise SmokeSkip(msg)


def declared_python_minor():
    """The fleet Python this checkout declares: the Dockerfile's FROM minor.

    None when there is nothing to hold the host against — no Dockerfile
    beside this script (the script run outside a checkout) — or when the
    SEAT itself is off-contract: `SMOKE_PYTHON_DECLARED=ignore` is for a
    seat whose interpreter is deliberately not the fleet Python, and
    tests/test_network_smoke.py's in-process seat patches this to None for
    the same reason. The seats that leave it armed are exactly the ones
    whose interpreter is a deploy artifact: ci.yml's docker job against the
    container it just built, and cd.yml's verify job against production.

    On THIS fork ci.yml's site-tests job also runs the battery, against an
    app it booted on the runner's own interpreter — armed on purpose, since
    tests/test_python_version.py holds that job's setup-python to this same
    minor. If those two ever part, this check is where it surfaces.
    """
    if os.environ.get("SMOKE_PYTHON_DECLARED") == "ignore":
        return None
    dockerfile = os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
        "Dockerfile")
    try:
        with open(dockerfile, encoding="utf-8") as fh:
            for line in fh:
                m = re.match(r"FROM\s+python:(\d+\.\d+)", line)
                if m:
                    return m.group(1)
    except OSError:
        pass
    return None


# ------------------------------------------------------------- the battery --

def satellite_checks(base: str) -> None:
    get = lambda path, **kw: fetch(base + path, **kw)  # noqa: E731

    def healthz_ok():
        status, _, text = get("/healthz")
        expect(status == 200, f"/healthz {status}")
        expect(json.loads(text).get("ok") is True, f"unexpected body {text[:120]!r}")

    def python_matches_declared():
        # WHICH interpreter serves, versus the one this repo declares. Three
        # Pythons coexisted for months on the template (image 3.11.8, matrix
        # 3.12, render.yaml 3.12.0) because nothing on the wire could
        # contradict any of them — /healthz's `python` field is the
        # observability, and this check is the teeth: the served minor must
        # equal the Dockerfile's FROM minor. Field ABSENCE is a failure in
        # its own right, never a skip: an image that reached the fleet
        # Python through dependabot alone passes a `grep ^FROM` and fails
        # here (emojimart, 2026-08-26).
        status, _, text = get("/healthz")
        expect(status == 200, f"/healthz {status}")
        served = json.loads(text).get("python") or ""
        expect(bool(served), "/healthz carries no `python` field — the "
               "serving interpreter is invisible (a pre-item-5 build?)")
        declared = declared_python_minor()
        if declared is None:
            return
        served_minor = ".".join(served.split(".")[:2])
        expect(served_minor == declared,
               f"host serves Python {served}, repo declares {declared} — "
               "a stale image, or a platform runtime nobody aligned")

    def llms_txt_identity():
        # The check this whole standard exists for. The H1 is what an agent
        # fetching /llms.txt cold reads as the name of this site, and a
        # pre-2.3.4 artifact publishes `app.title` (or a bare "Dash") there
        # with nothing else looking wrong.
        status, headers, text = get("/llms.txt")
        expect(status == 200, f"/llms.txt {status}")
        ct = headers.get("content-type", "")
        expect(ct.startswith("text/markdown"), f"content-type {ct!r}")
        first = text.splitlines()[0] if text else ""
        expect(first == SITE_H1, f"H1 {first!r} — identity regression?")
        expect("## Pages" in text, "page index section missing")
        expect("## Network" in text, "cross-host directory missing")

    def llms_txt_names_the_hub():
        _status, _, text = get("/llms.txt")
        expect(HUB_URL in text, f"the directory does not name {HUB_URL}")

    def page_llms_nav():
        status, _, text = get("/basic/llms.txt")
        expect(status == 200, f"/basic/llms.txt {status}")
        expect("/llms.txt" in text, "llms_nav header missing — page doc is a dead end")

    def hidden_pages_404():
        for path in HIDDEN_DOC_PATHS:
            status, _, _ = get(path)
            expect(status == 404, f"{path} {status} (owner surface leaked)")

    def agent_key_closed_to_anonymous():
        # 204, not 200-with-empty-body and not 401: the browser JS in
        # assets/llms_copy.js treats anything but 200 as "no key" and copies
        # the plain URL, so a 204 is the quiet, correct answer for a visitor
        # with no session. A 200 carrying a key here would mean this host is
        # minting authority for anonymous callers — the one failure on this
        # surface that matters, and it is invisible from the browser.
        status, headers, text = get("/api/agent-key")
        expect(status == 204, f"/api/agent-key {status} for an anonymous caller")
        expect(not text.strip(), "/api/agent-key returned a body to an anonymous caller")
        cache = (headers.get("cache-control") or "").lower()
        if cache:
            expect("no-store" in cache,
                   f"/api/agent-key Cache-Control={cache!r} — a key response must never be cached")

    def robots_artifact_fingerprint():
        # pip metadata is invisible from outside, so the robots.txt crawler
        # split is how a live host is proven to run the intended package:
        # 2.3.2 allowed OAI-SearchBot; 2.3.3 moved ClaudeBot (the training
        # crawler) to Disallow while allowing Claude-User / Claude-SearchBot.
        # Item 15 (2026-08-29, DEFAULT ALLOW) flips block_ai_training off:
        # ClaudeBot no longer gets its own stanza — it falls under
        # `User-agent: *` with everything else, so the fingerprint is "no
        # Disallow anywhere", not a per-agent Disallow line.
        status, _, text = get("/robots.txt")
        expect(status == 200, f"/robots.txt {status}")
        lines = [ln.strip() for ln in text.splitlines()]

        def rule(agent):
            marker = f"User-agent: {agent}"
            expect(marker in lines, f"{marker} stanza missing")
            return lines[lines.index(marker) + 1]

        for agent, expected, since in (
            ("OAI-SearchBot", "Allow: /", "2.3.2"),
            ("Claude-User", "Allow: /", "2.3.3"),
            ("Claude-SearchBot", "Allow: /", "2.3.3"),
        ):
            got = rule(agent)
            expect(got == expected,
                   f"{agent} -> {got!r}, expected {expected!r}: pre-{since} artifact")
        expect("Disallow: /" not in lines,
               "a blanket 'Disallow: /' line survived the item 15 flip — a "
               "vendor class is still blocked ('Disallow: /admin/' is unrelated)")
        expect("User-agent: ClaudeBot" not in text,
               "ClaudeBot still has its own stanza — pre-item-15 artifact")
        expect(any(ln.startswith("Sitemap:") for ln in lines), "Sitemap line missing")

    def sitemap_absolute_and_on_this_host():
        status, _, text = get("/sitemap.xml")
        expect(status == 200, f"/sitemap.xml {status}")
        expect("<loc>https://" in text or "<loc>http://" in text,
               "no absolute <loc> URLs")
        for path in HIDDEN_DOC_PATHS:
            leaked = path.rsplit("/llms.txt", 1)[0]
            expect(leaked not in text, f"hidden path {leaked} leaked into sitemap")

    def crawler_gets_prose():
        # The prerender. A crawler that receives the JavaScript stub indexes
        # nothing, and the page looks perfect in a browser the whole time.
        status, _, text = get("/", ua=CRAWLER_UA)
        expect(status == 200, f"/ {status}")
        expect("<title>" in text, "crawler HTML has no <title>")
        expect(STUB_MARKER not in text,
               "the home page served the JavaScript stub to a crawler")
        expect('rel="canonical"' in text, "no canonical tag for a crawler")

    def agents_and_browsers_get_different_types():
        # One URL, two audiences, and a `Vary` that stops a CDN mixing them.
        status, md_headers, md = get("/basic/llms.txt")
        expect(status == 200, f"/basic/llms.txt {status}")
        expect(md_headers.get("content-type", "").startswith("text/markdown"),
               f"agents got {md_headers.get('content-type')!r}")
        expect("<!DOCTYPE html>" not in md, "viewer chrome reached an agent")

        _status, html_headers, html = get(
            "/basic/llms.txt",
            headers={"Accept": "text/html,application/xhtml+xml,*/*;q=0.8"})
        expect("text/html" in html_headers.get("content-type", ""),
               f"browsers got {html_headers.get('content-type')!r}")
        expect("mk-wordmark" in html, "the network wordmark is missing")

        for label, headers in (("markdown", md_headers), ("html", html_headers)):
            expect("accept" in headers.get("vary", "").lower(),
                   f"no Vary: Accept on the {label} variant — a shared cache "
                   "may serve it to everyone")

    def head_get_parity_three_uas():
        """HEAD answers wherever GET does, in every lane.

        `/healthz` alone with one UA is not the test: the prerender middleware
        answers a crawler-UA `HEAD /` before routing, so that one path can
        return 200 on a host whose every other route 405s. Probe paths that
        are NOT `/`, with all three UAs.

        This fork has no HeadAsGetMiddleware to lean on (DIVERGENCES 21):
        Flask answers HEAD by running the GET view and discarding the body,
        so this check is what says that is still true after a deploy.
        """
        paths = ("/healthz", "/llms.txt", "/robots.txt", "/sitemap.xml", "/")
        agents = (("browser", BROWSER_UA), ("crawler", CRAWLER_UA),
                  ("engine", "curl/8 " + _INTERNAL_UA))
        mismatches = []
        pairs = 0
        for path in paths:
            for lane, ua in agents:
                get_status, _, _ = get(path, ua=ua)
                head_status, _, _ = get(path, ua=ua, method="HEAD")
                pairs += 1
                if head_status != get_status:
                    mismatches.append(
                        f"{lane} {path}: HEAD {head_status} vs GET {get_status}"
                        + (" (no HEAD rule for this GET route)"
                           if head_status == 405 else ""))
        expect(pairs == len(paths) * len(agents),
               f"compared {pairs} pairs, expected {len(paths) * len(agents)}")
        expect(not mismatches, "; ".join(mismatches))

    def api_llms_rows_present():
        """A host that declares API_PACKAGES serves a non-empty /api index.

        SKIPPED, never passed, where API_PACKAGES is empty. This fork
        declares one package, so the skip branch is not this host's state —
        which is exactly why the mutation is pinned in
        tests/test_network_smoke.py rather than trusted here.
        """
        try:
            from lib.constants import API_PACKAGES
        except Exception:
            skip("no checkout beside this script — API_PACKAGES unreadable")
        if not API_PACKAGES:
            skip("API_PACKAGES is empty on this host — nothing to index")
        status, _, text = get("/api/llms.txt")
        expect(status == 200, f"/api/llms.txt {status} while API_PACKAGES "
                              f"declares {len(API_PACKAGES)} package(s)")
        rows = [ln for ln in text.splitlines() if ln.strip().startswith("- ")]
        expect(len(rows) > 0,
               f"/api/llms.txt lists 0 entries for {list(API_PACKAGES)}")

    def discovery_link_headers_per_lane():
        """Both lanes advertise the same discovery relations.

        Read every `Link` value, not `headers['link']`: repeated headers keep
        only the last through a plain dict, and a folded comma-joined value is
        equally legal — MEASURED on this host, both relations arrive folded
        into one header over HTTP/2. So parse the relations out of everything
        that came back rather than counting headers.
        """
        wanted = {"alternate", "describedby"}
        for lane, ua in (("browser", BROWSER_UA), ("crawler", CRAWLER_UA)):
            status, headers, _ = get("/", ua=ua)
            expect(status == 200, f"{lane} GET / {status}")
            values = headers.get_all("link")
            rels = set(re.findall(r'rel="?([a-zA-Z-]+)"?', ", ".join(values)))
            expect(wanted <= rels,
                   f"{lane} lane advertises {sorted(rels) or 'no Link header'}"
                   f" — missing {sorted(wanted - rels)}")
            expect(all("/llms.txt" in v for v in values),
                   f"{lane} lane's Link headers do not point at /llms.txt: "
                   f"{values}")

    def directory_counts_are_derived():
        """The Network section lists exactly the peers the module names.

        Counts come from `lib/network_directory`, never a literal: a hard
        number in a battery is a check that stops testing the moment the
        fleet grows, and passes while doing it.
        """
        try:
            from lib.constants import BASE_URL
            from lib.network_directory import peers_for
        except Exception:
            skip("no checkout beside this script — the directory is unreadable")
        expected = {p["url"].rstrip("/") for p in peers_for(BASE_URL)}
        expect(len(expected) > 0,
               "peers_for() names no peers — nothing to hold the wire to")
        _status, _, text = get("/llms.txt")
        section = text.split("## Network", 1)[-1]
        missing = sorted(u for u in expected if u.rstrip("/") not in section)
        expect(not missing,
               f"{len(missing)} of {len(expected)} peers absent from the "
               f"/llms.txt Network section: {missing[:3]}")

    for name, fn in (
        ("healthz_ok", healthz_ok),
        ("head_get_parity_three_uas", head_get_parity_three_uas),
        ("api_llms_rows_present", api_llms_rows_present),
        ("discovery_link_headers_per_lane", discovery_link_headers_per_lane),
        ("directory_counts_are_derived", directory_counts_are_derived),
        ("python_matches_declared", python_matches_declared),
        ("llms_txt_identity", llms_txt_identity),
        ("llms_txt_names_the_hub", llms_txt_names_the_hub),
        ("page_llms_nav", page_llms_nav),
        ("hidden_pages_404", hidden_pages_404),
        ("agent_key_closed_to_anonymous", agent_key_closed_to_anonymous),
        ("robots_artifact_fingerprint", robots_artifact_fingerprint),
        ("sitemap_absolute_and_on_this_host", sitemap_absolute_and_on_this_host),
        ("crawler_gets_prose", crawler_gets_prose),
        ("agents_and_browsers_get_different_types",
         agents_and_browsers_get_different_types),
    ):
        check(name, fn)


# ------------------------------------------------------------------- main --

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--base-url", default=DEFAULT_BASE_URL,
                    help="the satellite under test (default: the CI container)")
    args = ap.parse_args()

    base = args.base_url.rstrip("/")
    print(f"network-smoke → {base}\n")
    satellite_checks(base)

    counts = {v: sum(1 for _, verdict, _ in _RESULTS if verdict == v)
              for v in (PASS, FAIL, WARN, SKIP)}
    print(f"\n{counts[PASS]} passed, {counts[FAIL]} failed, "
          f"{counts[WARN]} warnings, {counts[SKIP]} skipped")
    return 1 if counts[FAIL] else 0


if __name__ == "__main__":
    sys.exit(main())
