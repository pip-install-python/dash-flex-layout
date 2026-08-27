#!/usr/bin/env python3
"""Post-deploy checks against a *live* satellite.

    python scripts/smoke_live.py https://flexlayout.2plot.dev

Everything here fails silently in production if it isn't checked. A wrong
canonical host doesn't error, it deindexes; a stub body doesn't error, it
serves crawlers nothing; a dead peer link doesn't error, it just teaches an
agent that this network's directory isn't worth following.

Run in CD after every deploy, and by hand against any satellite you're
upgrading. Exit code is the number of failed checks, capped at 125.

Much of the fleet runs on Render's free tier, which sleeps after ~15 minutes
idle and answers the first probe with a loading page or a hang — so the
battery wakes the host up first (a `/healthz` poll, LESSONS §21) and `fetch`
retries transport errors and 5xx. Both are tunable without editing this file:

    SMOKE_WAKE_ATTEMPTS    /healthz probes before giving up   (default 24)
    SMOKE_WAKE_INTERVAL_S  seconds between probes             (default 10)
    SMOKE_FETCH_RETRIES    attempts per request inside fetch  (default 3)

This host is on Render's `starter` plan and does not sleep, so the wake loop
normally passes on its first probe — it is here for the deploy window, when
the container is swapping and the wire answers 502 for a few seconds, and
because the knobs are the fleet's contract (SYNC-1.6.22-1.6.29 item 6).

Only the standard library, so it runs anywhere without an install step.
"""

from __future__ import annotations

import html as html_lib
import json
import os
import re
import sys
import ssl
import time
import urllib.error
import urllib.request
from typing import Dict, List, Optional, Tuple
from urllib.parse import urlparse

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Every UA below carries the network's internal-traffic token (the analytics
# point of truth — https://2plot.ai/docs/satellite-analytics, "Internal
# traffic"). A post-deploy battery runs on every push and sweeps every peer in
# the directory; without the token it registers as a burst of visitors, and
# the crawler-shaped probes register as crawler interest. The Googlebot and
# Chrome tokens are still there, so the target exercises exactly the path
# being tested — it just knows the caller is machinery.
try:
    from lib.constants import INTERNAL_UA as _INTERNAL_UA
except Exception:  # pragma: no cover — running outside a repo checkout
    _INTERNAL_UA = "2plot-internal/1.0 (+https://2plot.ai/docs/satellite-analytics)"

CRAWLER_UA = (
    "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html) "
    + _INTERNAL_UA
)
BROWSER_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 " + _INTERNAL_UA
)
# `/<page>/llms.txt` negotiates on Accept, not on the User-Agent.
BROWSER_ACCEPT = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
STUB_MARKER = "This page contains interactive content that requires JavaScript"
# Rendered chrome, not the bare class name — a Markdown page may legitimately
# discuss `dv-banner` (this network has one that does); it can never contain
# the element.
CHROME = re.compile(r'<[a-z]+ class="dv-banner')
TIMEOUT = 30
# Generous on purpose: a free-tier cold start routinely takes 60-90s, and the
# only cost of a wide window is paid when the host is actually down — a warm
# host passes the first probe. 24 x 10s covers the slow tail with room; a
# satellite on an even slower tier stretches it via the env vars above.
RETRIES = max(1, int(os.getenv("SMOKE_FETCH_RETRIES") or 3))
WAKE_ATTEMPTS = max(1, int(os.getenv("SMOKE_WAKE_ATTEMPTS") or 24))
WAKE_INTERVAL_S = max(0.0, float(os.getenv("SMOKE_WAKE_INTERVAL_S") or 10))


def _ssl_context() -> ssl.SSLContext:
    """Verify certificates via certifi when available.

    macOS Python ships without OS trust-store integration, so bare urllib
    fails every https fetch with CERTIFICATE_VERIFY_FAILED — which reads as
    "the whole site is down" (every check 0s). Same fix as audit_links.py.
    Verification stays ON either way; certifi only supplies the CA bundle.
    """
    try:
        import certifi

        return ssl.create_default_context(cafile=certifi.where())
    except ImportError:
        return ssl.create_default_context()


SSL_CONTEXT = _ssl_context()

failures: List[str] = []
warnings: List[str] = []
checks_run = 0


def fetch(
    url: str,
    user_agent: str = BROWSER_UA,
    accept: Optional[str] = None,
    retries: Optional[int] = None,
    timeout: float = TIMEOUT,
) -> Tuple[int, str, Dict[str, str]]:
    """Returns (status, body, headers).

    Headers are part of the contract from 2.2.0 on: `/<page>/llms.txt`
    content-negotiates, so which *type* came back is the thing being checked,
    and `Vary` is what stops a CDN handing cached HTML to the next agent.

    TRANSPORT errors and 5xx are retried with backoff; other statuses are
    verdicts and are not. The distinction matters because this script makes
    ~50 requests in a burst, and one dropped connection used to surface as
    `FAIL canonical on /<page>` — a check that had never actually run,
    sending you to look at canonical tags that were correct all along
    (LESSONS §21; the same ladder network_smoke.py has always had). A 404 is
    a real answer and retrying it would only slow the battery down; a check
    still failing after every attempt is a real failure.

    `errors="surrogateescape"`, not `"replace"`: this function also fetches
    the social card, and the card check reads the PNG's IHDR chunk for the
    real pixel dimensions. `"replace"` substitutes U+FFFD for every invalid
    byte and is one-way, so the header would be gone before it could be read.
    surrogateescape round-trips exactly through
    `body.encode("utf-8", "surrogateescape")`, and behaves identically to a
    plain decode for text.
    """
    headers = {"User-Agent": user_agent}
    if accept is not None:
        headers["Accept"] = accept
    request = urllib.request.Request(url, headers=headers)
    attempts = RETRIES if retries is None else max(1, retries)
    last: Tuple[int, str, Dict[str, str]] = (0, "no attempt was made", {})
    for attempt in range(attempts):
        if attempt:
            time.sleep(2 * attempt)
        try:
            with urllib.request.urlopen(
                request, timeout=timeout, context=SSL_CONTEXT
            ) as response:
                body = response.read().decode("utf-8", "surrogateescape")
                return response.status, body, dict(response.headers)
        except urllib.error.HTTPError as exc:
            # The STATUS is the answer; the body is a bonus. Reading it can
            # itself raise — a host that 502s mid-body raises IncompleteRead
            # here — and an exception escaping `fetch` takes the whole script
            # down, turning one sick response into a dead CD run.
            try:
                body = exc.read().decode("utf-8", "surrogateescape")
            except Exception:  # noqa: BLE001 - truncated or already-closed body
                body = ""
            last = (exc.code, body, dict(exc.headers or {}))
            if exc.code < 500:
                return last
            reason = f"HTTP {exc.code}"
        except Exception as exc:  # noqa: BLE001 - DNS, TLS, timeouts all land here
            last = (0, f"{type(exc).__name__}: {exc}", {})
            reason = type(exc).__name__
        if attempt + 1 < attempts:
            # Visible on purpose: a green run whose log shows retries is a
            # host worth watching, and CD output is the only place that shows.
            print(f"        retry {attempt + 1}/{attempts - 1} for {url} — {reason}",
                  flush=True)
    return last


def header(headers: Dict[str, str], name: str) -> str:
    """Case-insensitive header lookup — proxies rewrite the casing."""
    for key, value in headers.items():
        if key.lower() == name.lower():
            return value
    return ""


def post(url: str, payload: str = "{}") -> int:
    """POST for the auth-wiring probe; returns the status, 0 on transport.

    No retry ladder on purpose: a 4xx here IS the answer (invalid token,
    anonymous signout — both prove the route is registered and callable),
    so only a transport failure reads as 0.
    """
    request = urllib.request.Request(
        url,
        data=payload.encode("utf-8"),
        headers={"User-Agent": BROWSER_UA, "Content-Type": "application/json"},
        method="POST",
    )
    try:
        # `context=SSL_CONTEXT` for the same reason `fetch` uses it, and the
        # omission here was a real one-way defect: on any Python without OS
        # trust-store integration (macOS, the fleet's whole local-dev half)
        # every POST died with CERTIFICATE_VERIFY_FAILED, returned 0, and the
        # check announced "the configure_app(app) half of the auth wiring is
        # missing" — accusing the app of the exact regression dc8c1d6 fixed.
        # Measured against production 2026-08-24: this script said 0/0 while
        # `curl -X POST` on the same machine, same minute, got 401 and 200.
        # CD never saw it (Linux's default context verifies fine), so the
        # failure mode was local-only and read as a live outage.
        with urllib.request.urlopen(
            request, timeout=TIMEOUT, context=SSL_CONTEXT
        ) as resp:
            return resp.status
    except urllib.error.HTTPError as exc:
        return exc.code
    except (urllib.error.URLError, TimeoutError, OSError):
        return 0


def check(name: str, passed: bool, detail: str = "", fatal: bool = True) -> None:
    """Record one check. ``fatal=False`` warns instead of failing the deploy.

    The distinction is a policy, not a convenience: **a check about THIS host
    is fatal; a check about somebody else's host is a warning.**

    Peer reachability is the only thing in this script that fails on someone
    else's infrastructure, and gating a deploy on it is shared fate — one peer
    with an expired certificate turns every satellite in the network red, none
    of them can ship, and the people who see it learn that red CD means
    nothing. The information is still worth having (a directory of dead links
    degrades silently and nothing else reports it), so it is surfaced as a
    warning and, under Actions, as an annotation on the run summary.
    """
    global checks_run
    checks_run += 1
    if passed:
        print(f"  ok    {name}")
    elif fatal:
        print(f"  FAIL  {name}" + (f" — {detail}" if detail else ""))
        failures.append(name)
    else:
        print(f"  warn  {name}" + (f" — {detail}" if detail else ""))
        warnings.append(f"{name}" + (f" — {detail}" if detail else ""))
        if os.getenv("GITHUB_ACTIONS"):
            print(f"::warning title=peer unreachable::{name} — {detail}")


def wake(base: str) -> bool:
    """Poll `/healthz` until the host actually answers. LESSONS §21.

    A sleeping free-tier host greets its first visitor with Render's loading
    page or a hang, and the first visitor after a deploy is this battery — so
    without this loop the opening checks fail on a perfectly healthy site.
    Requiring `ok: true` rather than any 200 keeps the loading page (and a
    CDN error page, which can also be a 200) from counting as awake.

    Each probe is single-shot with a short timeout: the loop IS the retry
    ladder here, and per-probe printing is what makes a slow start readable
    in the CD log rather than a silent multi-minute stall.
    """
    url = f"{base}/healthz"
    for attempt in range(1, WAKE_ATTEMPTS + 1):
        try:
            status, body, _ = fetch(url, retries=1, timeout=10)
        except TypeError:
            # A legacy fetch stub — `(url, user_agent, accept)`, pre-wake
            # vintage — from a test that monkeypatches fetch without patching
            # wake. The real fetch cannot raise TypeError (its signature takes
            # these kwargs and everything inside its attempt loop is caught),
            # so this branch can only be a stub's signature binding; probe
            # bare rather than take a whole suite down. The 1.6.28 fan-out
            # went red on 7 of 12 forks exactly here, which is why the
            # template's file was reclassed from cargo to contract.
            status, body, _ = fetch(url)
        if status == 200 and re.search(r'"ok"\s*:\s*true', body):
            print(f"  wake  attempt {attempt}/{WAKE_ATTEMPTS}: up")
            return True
        detail = f"HTTP {status}" if status else body[:80]
        print(f"  wake  attempt {attempt}/{WAKE_ATTEMPTS}: {detail}", flush=True)
        if attempt < WAKE_ATTEMPTS:
            time.sleep(WAKE_INTERVAL_S)
    return False


def main(base: str) -> int:
    base = base.rstrip("/")
    host = urlparse(base).netloc
    print(f"Smoke-testing {base}\n")

    # --- 0. Wake the host before asserting anything about it ---------------
    print("Wake-up")
    if not wake(base):
        # ONE clear failure, not a cascade: fifty per-check failures against a
        # host that never answered all say the same thing and bury it.
        check(
            "host answered /healthz",
            False,
            f"never woke after {WAKE_ATTEMPTS} probes ~{WAKE_INTERVAL_S:g}s "
            "apart — nothing else was tested",
        )
        print(f"\n0/{checks_run} checks passed")
        print("\nFailed:")
        for name in failures:
            print(f"  - {name}")
        return min(len(failures), 125)

    # --- 1. The site is up, and llms.txt is the index it should be ---------
    print("Core surfaces")
    status, home, _ = fetch(f"{base}/")
    check("home page responds 200", status == 200, f"got {status}")

    status, llms, llms_headers = fetch(f"{base}/llms.txt")
    check("/llms.txt responds 200", status == 200, f"got {status}")
    check("/llms.txt lists pages", "## Pages" in llms or "# " in llms)
    check("/llms.txt publishes the network directory", "## Network" in llms)

    status, robots, _ = fetch(f"{base}/robots.txt")
    check("/robots.txt responds 200", status == 200, f"got {status}")
    check(
        "/robots.txt points at this host's sitemap",
        f"Sitemap: {base}/sitemap.xml" in robots,
        "sitemap line missing or pointing elsewhere",
    )
    # The artifact fingerprint. pip metadata is invisible from outside, so
    # these robots.txt pairs are how a live host is proven to run the intended
    # dash-improve-my-llms: 2.3.2 allowed OAI-SearchBot; 2.3.3 moved ClaudeBot
    # (the training crawler) to Disallow while allowing the user-triggered and
    # search fetchers Claude-User / Claude-SearchBot.
    robots_lines = robots.splitlines()

    def robots_rule(agent: str) -> str:
        marker = f"User-agent: {agent}"
        if marker not in robots_lines:
            return "(missing)"
        idx = robots_lines.index(marker)
        following = robots_lines[idx + 1: idx + 2]
        return following[0] if following else "(missing)"

    for agent, expected, since in (
        ("OAI-SearchBot", "Allow: /", "2.3.2"),
        ("ClaudeBot", "Disallow: /", "2.3.3"),
        ("Claude-User", "Allow: /", "2.3.3"),
        ("Claude-SearchBot", "Allow: /", "2.3.3"),
    ):
        got = robots_rule(agent)
        check(
            f"/robots.txt {agent} -> {expected.split(':')[0]} ({since} artifact fingerprint)",
            got == expected,
            f"got {got}: this host runs a pre-{since} artifact",
        )

    status, sitemap, _ = fetch(f"{base}/sitemap.xml")
    check("/sitemap.xml responds 200", status == 200, f"got {status}")
    page_urls = re.findall(r"<loc>([^<]+)</loc>", sitemap)
    check("/sitemap.xml lists pages", bool(page_urls), "no <loc> entries")
    foreign = [u for u in page_urls if urlparse(u).netloc != host]
    check("/sitemap.xml stays on this host", not foreign, f"foreign URLs: {foreign[:3]}")

    status, health, _ = fetch(f"{base}/healthz")
    check("/healthz responds 200", status == 200, f"got {status}")
    try:
        build = json.loads(health).get("build")
    except Exception:
        build = None
    # Not fatal: the field is optional by contract and absent outside Render.
    # It is printed because it is the only way, from outside, to tell WHICH
    # build answered — cd.yml waits on exactly this value.
    check("/healthz names the running build", bool(build),
          "no `build` field — cannot tell which commit is serving "
          "(RENDER_GIT_COMMIT unset, or a build predating the field)",
          fatal=False)
    if build:
        print(f"    build: {build}")

    # WHICH satellite answered — a different question from which commit, on a
    # fleet where every host shares one template and a hostname can be
    # repointed between services (llms.2plot.dev was, 2026-08-23).
    try:
        payload = json.loads(health)
    except Exception:
        payload = {}
    check("/healthz claims this app's identity",
          payload.get("app") == "flexlayout",
          f"app={payload.get('app')!r} — expected 'flexlayout'; 'unknown' means "
          "SATELLITE_APP_KEY never reached the process (run.py's FORK POINT)",
          fatal=False)

    # THE CACHE-TRAP TELL. `geo` is emitted only on dash-improve-my-llms >=
    # 2.7.0, and OMITTED (never error-flagged) below it. So its absence from a
    # deploy that bumped the requirements floor to >=2.7.1 does not mean the
    # geo guardrail is off — it means the Docker layer cache served a stale
    # image and the floor never actually moved. That failure is otherwise
    # completely silent from outside (the round-2 pannellum lesson).
    check("/healthz carries the geo diagnostic (>=2.7.0 is really installed)",
          isinstance(payload.get("geo"), dict),
          "no `geo` block — either the image predates 2.7.0 or the "
          "requirements-layer cache was never busted by the floor bump",
          fatal=False)
    if isinstance(payload.get("geo"), dict):
        print(f"    geo: {payload['geo']}")

    # --- 1b. The prerender a BROWSER receives -----------------------------
    # THE CHECK A PLAIN CURL CANNOT MAKE. Fetching with a default or crawler
    # UA gets the separate crawler document; the universal prerender lives on
    # the ordinary browser lane, and this is the only place its shape is
    # measured against a real deployment.
    #
    # Three properties, and each has been wrong on a live host in this fleet:
    #   present   — a UA-gated prerender serves browsers "Loading..." and
    #               nothing else (an outside SEO audit read five hosts that
    #               way, 2026-08-22);
    #   VISIBLE   — dash-improve-my-llms <= 2.6.0 shipped the div with a
    #               literal `hidden`, so every visibility-respecting text
    #               extractor read "Loading..." even though the prose was
    #               there. THIS HOST served that until the 2.6.1 floor, so
    #               this check is its regression pin;
    #   per-page  — the block must carry THIS page's prose, not the home
    #               page's on every route.
    print("\nPrerender (browser lane)")
    prerender_routes = [f"{base}/"] + [u for u in page_urls if urlparse(u).path not in ("", "/")][:2]
    for url in prerender_routes:
        path = urlparse(url).path or "/"
        _status, html, _ = fetch(url, BROWSER_UA)
        div = re.search(r'<div id="dimll-prerender"[^>]*>', html)
        check(f"prerender block present on {path}", bool(div),
              "no #dimll-prerender for a browser — the universal lane is off or UA-gated")
        if div:
            check(f"prerender is VISIBLE on {path}", "hidden" not in div.group(0),
                  f"{div.group(0)} — carries `hidden`; the floor first moved (to 2.6.1) for exactly this, and sits at >=2.7.1 now")
        check(f"prerender hide script marked on {path}",
              'data-dimll-prerender="1">document.getElementById' in html,
              "the marked synchronous hide script is missing — JS browsers "
              "would flash the prose before React mounts")
        body = html.split("<main>", 1)[1].split("</main>", 1)[0] if "<main>" in html else ""
        check(f"prerender carries prose on {path}", len(body) > 500,
              f"only {len(body)} characters inside <main>")

        # ONE h1 in the document a crawler parses. Below dimll 2.7.0 the
        # injected prerender header and the doc body's own markdown H1 were
        # both emitted; this app also used to prepend `# {name}` on top of a
        # body that already had one (pages/markdown.py). Comments are
        # stripped first — templates/index.html explains its noscript block
        # in prose that names the tag.
        stripped = re.sub(r"<!--.*?-->", "", html, flags=re.S)
        h1s = re.findall(r"<h1[\s>]", stripped)
        check(f"exactly one h1 on {path}", len(h1s) == 1,
              f"{len(h1s)} h1 elements — duplicate-H1 page in a crawler's "
              "parse (a pre-2.7.0 package, or app-side heading leakage)",
              fatal=False)

        footer = re.search(r"<footer.*?</footer>", stripped, re.S)
        if footer:
            links = re.findall(r'href="([^"]*llms\.txt)"', footer.group(0))
            check(f"no duplicate llms.txt footer links on {path}",
                  len(links) == len(set(links)), f"{links}", fatal=False)

    # --- 1c. The person->agent handoff ------------------------------------
    # /api/agent-key must be silent for anyone without a session. A 200
    # carrying a key here would mean this host mints authority for anonymous
    # callers — invisible from a browser, and the only failure on this
    # surface that matters.
    print("\nAgent key")
    status, body, headers = fetch(f"{base}/api/agent-key")
    check("/api/agent-key is 204 for an anonymous caller", status == 204, f"got {status}")
    check("/api/agent-key returns no body to an anonymous caller", not (body or "").strip())

    # --- Auth wiring: the two-call split, proven from outside --------------
    # dash-clerk-auth wires either side of Dash(...): register() is the UI
    # half, configure_app(app) registers /api/auth/* and per-request
    # identity. A fork that drops the second call still LOOKS signed in
    # (components render, ClerkJS runs) while every server render reads
    # signed-out and sign-out never revokes — THIS SITE shipped exactly that
    # in its 2026-08-22 gate-wave pass, and no local suite can see it because
    # Clerk is off in test environments and configure_app no-ops without keys.
    # From outside the tell is unambiguous: registered, these POSTs answer
    # 2xx/4xx; unregistered, the path falls through to Dash's GET-only page
    # catch-all and answers 405 (or 404). Gated on the package's inline
    # bootstrap being in the served shell, so clerk-off hosts skip rather
    # than fail.
    print("\nAuth wiring")
    if "dashClerkAuth" in home:
        for endpoint in ("session", "signout"):
            status = post(f"{base}/api/auth/{endpoint}")
            check(
                f"POST /api/auth/{endpoint} is a registered route",
                status not in (0, 404, 405),
                f"got {status} — the configure_app(app) half of the auth "
                "wiring is missing: components without a server",
            )
    else:
        print("    skipped — no Clerk bootstrap in the served shell (gate is dark)")

    # --- 1d. Machine surfaces stay open ------------------------------------
    # The 30-day crawl-demand window: whatever the interactive gate is set to,
    # the corpus documents answer an anonymous agent with prose.
    print("\nMachine surfaces (anonymous)")
    for doc in ("/llms.txt", "/llms-small.txt", "/llms-full.txt"):
        status, text, _ = fetch(f"{base}{doc}")
        check(f"{doc} responds 200", status == 200, f"got {status}")
        check(f"{doc} serves prose", len(text) > 400 and "Authentication required" not in text,
              f"{len(text)} characters" + (" and reads as a gate card" if "Authentication required" in text else ""))

    # --- 2. Canonical host — the failure that deindexes a satellite --------
    print("\nCanonical tags")
    for url in [f"{base}/"] + page_urls[:8]:
        _status, html, _ = fetch(url, CRAWLER_UA)
        found = re.findall(r'rel="canonical"\s+href="([^"]*)"', html)
        check(
            f"canonical on {urlparse(url).path or '/'}",
            len(found) == 1 and urlparse(found[0]).netloc == host,
            f"got {found}",
        )

    # --- 3. No page serves the JavaScript stub ----------------------------
    print("\nCrawler bodies")
    for url in [f"{base}/"] + page_urls[:8]:
        _status, html, _ = fetch(url, CRAWLER_UA)
        check(
            f"real content on {urlparse(url).path or '/'}",
            STUB_MARKER not in html,
            "served the JavaScript stub",
        )

    # --- 3b. The social card actually exists, and is the shape we claim ----
    # This is the ONLY check that can see either failure. The card is on the
    # CDN, so no offline test can fetch it; and its dimensions are hard-coded
    # in three places (lib/constants.py, index.html, the CDN object), so
    # replacing the uploaded file with a different shape leaves every test
    # green while the platform reserves the wrong box and crops into it.
    #
    # A blank preview is also self-inflicting: platforms cache a failed scrape,
    # so the first share after a bad upload poisons the link for everyone.
    print("\nSocial card")
    card_urls = re.findall(r'<meta[^>]+property="og:image"[^>]+content="([^"]*)"', home)
    check("og:image is declared exactly once", len(card_urls) == 1, f"got {card_urls}")
    if card_urls and card_urls[0]:
        card_url = card_urls[0]
        check("og:image is not served by the app", "/assets/" not in card_url,
              f"{card_url} — a cold container blanks the preview, cached")
        status, body, headers = fetch(card_url)
        check("og:image resolves", status == 200, f"got {status}")
        ctype = header(headers, "Content-Type")
        check("og:image is a real image", ctype.startswith("image/"), ctype or "none")

        declared = {
            prop: re.findall(
                rf'<meta[^>]+property="{prop}"[^>]+content="([^"]*)"', home)
            for prop in ("og:image:width", "og:image:height")
        }
        # PNG stores its dimensions in the IHDR chunk: bytes 16..24 of the
        # file. Read from the RESPONSE, so what is checked is what a scraper
        # would actually receive rather than what the repo believes.
        raw = body.encode("utf-8", "surrogateescape")
        if raw[1:4] == b"PNG" and len(raw) > 24:
            actual_w = int.from_bytes(raw[16:20], "big")
            actual_h = int.from_bytes(raw[20:24], "big")
            check(
                "og:image dimensions match the declared width/height",
                declared["og:image:width"] == [str(actual_w)]
                and declared["og:image:height"] == [str(actual_h)],
                f"file is {actual_w}x{actual_h}, tags say "
                f"{declared['og:image:width']}x{declared['og:image:height']}",
            )
            ratio = actual_w / actual_h if actual_h else 0
            check("og:image suits summary_large_image (~1.91:1)",
                  1.7 <= ratio <= 2.05, f"{actual_w}x{actual_h} is {ratio:.2f}:1")
    else:
        check("og:image is not empty", False,
              "an EMPTY og:image renders a blank card — worse than none")

    # --- 3c. Crawler/browser identity parity (the 2.5.0 Tier-B standard) ---
    # Every SEO defect measured across the fleet in 2026-08 was one bug in
    # different clothes: the head a crawler received had drifted from the
    # head a browser received — 4-7 icon links vs zero, "site | page" vs a
    # bare page name, og:image vs nothing. Content may differ between the
    # two documents (that is what the prerender is for); identity may not.
    # This block is the single assertion that would have caught all of it,
    # and its absence from this fork's copy is why CD, not CI, was the seat
    # that found the last head defect on the fleet.
    print("\nCrawler/browser identity parity")

    def identity(html: str) -> Dict[str, object]:
        # Icons compare as the SET of declared sizes, not a raw link count:
        # Dash auto-injects one extra favicon link (with a cache-busting
        # query) into the browser head, so counts differ by one forever
        # while the actual identity — which sizes a consumer can pick from
        # — is what the two heads must agree on.
        icon_links = re.findall(r'<link[^>]+rel="(?:icon|apple-touch-icon)"[^>]*>', html)
        # Unescape before comparing: one side may write an apostrophe as
        # &#x27; and the other verbatim — same identity, different escaping.
        unescape = html_lib.unescape
        return {
            "icon sizes": sorted(
                {s for link in icon_links for s in re.findall(r'sizes="([^"]+)"', link)}
            ),
            "title": unescape(
                (re.findall(r"<title>(.*?)</title>", html, re.S) or [""])[0].strip()
            ),
            "og:image": sorted({
                unescape(u)
                for u in re.findall(r'property="og:image"[^>]+content="([^"]*)"', html)
            }),
            "twitter:card": sorted({
                unescape(v)
                for v in re.findall(r'name="twitter:card"[^>]+content="([^"]*)"', html)
            }),
        }

    # `page_urls` comes from the sitemap, which lists the home page first, so
    # a bare `page_urls[:3]` spends one of the three content slots re-checking
    # `/` — the same filter section 1b already applies. Upstream's 3c block
    # has this by construction on every fork; filed with the report.
    content_urls = [u for u in page_urls if urlparse(u).path not in ("", "/")]
    for url in [f"{base}/"] + content_urls[:3]:
        path = urlparse(url).path or "/"
        _status, crawler_html, _ = fetch(url, CRAWLER_UA)
        _status, browser_html, _ = fetch(url, BROWSER_UA)
        seen_c, seen_b = identity(crawler_html), identity(browser_html)
        for field in ("icon sizes", "title", "og:image", "twitter:card"):
            check(
                f"{path}: crawler and browser agree on {field}",
                seen_c[field] == seen_b[field] and seen_c[field] not in (0, "", []),
                f"crawler={seen_c[field]!r} browser={seen_b[field]!r}",
            )
        check(
            f"{path}: crawlers get an icon >=192px",
            'sizes="192x192"' in crawler_html or 'sizes="512x512"' in crawler_html,
            "no >=192px icon link in the crawler head — Google's preferred size",
        )

    # Google falls back to <origin>/favicon.ico when the page it crawled
    # declares no icon. Dash's page catch-all used to answer it with the app
    # shell — 200 text/html where an image belongs, a poisoned fallback.
    status, favicon_body, _ = fetch(f"{base}/favicon.ico")
    check("/favicon.ico resolves", status == 200, f"got {status}")
    check(
        "/favicon.ico is an image, not the app shell",
        not favicon_body.lstrip().lower().startswith("<!doctype"),
        "text/html where an image belongs — a poisoned fallback",
    )

    # --- 4. Content negotiation on llms.txt -------------------------------
    # Production is where this can break in ways development cannot show: a
    # CDN sitting in front of the app is free to ignore `Vary` and serve one
    # cached variant to everyone. Chrome leaking into the Markdown makes every
    # agent in the network pay tokens for decoration and appears in no
    # dashboard; the Markdown leaking into a browser just looks unfinished.
    print("\nContent negotiation")
    check(
        "/llms.txt serves Markdown to a plain request",
        not CHROME.search(llms) and "<!DOCTYPE html>" not in llms,
        "the viewer chrome reached an agent",
    )

    page_doc = next(
        (f"{u.rstrip('/')}/llms.txt" for u in page_urls if urlparse(u).path not in ("", "/")),
        f"{base}/llms.txt",
    )

    status, doc, doc_headers = fetch(page_doc)
    check(f"{urlparse(page_doc).path} responds 200", status == 200, f"got {status}")
    check(
        "agents get text/markdown",
        "text/markdown" in header(doc_headers, "Content-Type"),
        header(doc_headers, "Content-Type") or "no Content-Type",
    )
    check(
        "agents get no viewer chrome",
        not CHROME.search(doc) and "<!DOCTYPE html>" not in doc,
        "the viewer chrome reached an agent",
    )
    check(
        "page document is not a dead end",
        f"{base}/llms.txt" in doc,
        "no route back to the site index",
    )

    status, view, view_headers = fetch(page_doc, accept=BROWSER_ACCEPT)
    check(
        "browsers get text/html",
        "text/html" in header(view_headers, "Content-Type"),
        header(view_headers, "Content-Type") or "no Content-Type",
    )
    check("the viewer renders the network wordmark", "mk-wordmark" in view)
    # WARN, not fail, and for a different reason than the peer checks below: a
    # satellite may legitimately run with no bulletin, and a hub outage must
    # never fail a deploy. This is the deploy telling you a panel is empty,
    # which is the only place that fact is ever surfaced.
    check(
        "the network bulletin is wired (banner shows hub announcements)",
        "No announcements." not in view,
        "NETWORK_BULLETIN_URL is unset or unreachable — the viewer's "
        "\"What's new\" panel is empty and its tips are the built-in fallback",
        fatal=False,
    )
    check(
        "the viewer is noindex",
        bool(re.search(r'<meta[^>]+name="robots"[^>]+noindex', view)),
        "the rendered view would compete with the page it documents",
    )

    # Both variants, because a cache keys on the request that populated it.
    for label, headers in (("markdown", doc_headers), ("html", view_headers)):
        check(
            f"Vary: Accept on the {label} variant",
            "accept" in header(headers, "Vary").lower(),
            f"Vary: {header(headers, 'Vary') or '(absent)'} — a shared cache "
            "may serve this variant to everyone",
        )

    # --- 5. Every peer in the directory resolves --------------------------
    # A directory of dead links degrades quietly, and nothing else will tell
    # you — so this is still worth checking on every deploy. But it is the ONE
    # section that tests hosts this deployment does not control, so it warns
    # rather than fails. See `check()` for why. That the directory is
    # *published at all* is this host's job, so that check stays fatal.
    print("\nNetwork directory")
    # `[` `]` `(` are excluded, not just whitespace: the 2.2.0 nav block writes
    # links as `[https://host/llms.txt](https://host/llms.txt)`, and a class
    # that stops only at `)` swallows the label and the opening paren into one
    # malformed URL — which then 404s and fails a perfectly good deploy.
    peer_docs = sorted(set(re.findall(r"https://[^\s()\[\]\"'<>]+/llms\.txt", llms)))
    check("directory lists peer llms.txt URLs", bool(peer_docs), "none found")
    for url in peer_docs:
        if url.startswith(base):
            continue
        status, body, headers = fetch(url)
        # A 200 is not enough. A Dash app answers its catch-all with the SPA
        # shell for *any* unmatched path, so a host that does not serve
        # llms.txt at all still returns 200 text/html — and a status-only
        # check passes on every one of them. Verified on 2plot.dev, where
        # /api/this-endpoint-cannot-exist also returns 200 text/html.
        is_html = "text/html" in header(headers, "Content-Type").lower() or (
            body.lstrip()[:15].lower().startswith("<!doctype html")
        )
        if status != 200:
            check(f"peer reachable: {url}", False, f"got {status}", fatal=False)
        else:
            check(
                f"peer serves a document: {url}",
                not is_html,
                "200, but HTML — that host's catch-all, not an llms.txt",
                fatal=False,
            )

    passed = checks_run - len(failures) - len(warnings)
    summary = f"\n{passed}/{checks_run} checks passed"
    if warnings:
        summary += f", {len(warnings)} warnings (peers — not this deployment)"
    print(summary)

    if warnings:
        print("\nWarned:")
        for name in warnings:
            print(f"  - {name}")

    if failures:
        print("\nFailed:")
        for name in failures:
            print(f"  - {name}")
        return min(len(failures), 125)
    return 0


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(2)
    sys.exit(main(sys.argv[1]))
