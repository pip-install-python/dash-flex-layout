#!/usr/bin/env python
"""Headless smoke test for flexlayout-dash.

Two things are checked, in this order:

1. **The component** — ``flexlayout_dash`` imports, ships its JS bundle, and a
   realistic ``DashFlexLayout`` tree survives Dash's own JSON encoder. This leg
   is what the Dash-version matrix is really about: it is the package, not the
   docs site, that ``pip install flexlayout-dash`` gives people.
2. **The documentation site** — ``run.py`` boots and is driven
   through Flask's **test client** (real request/response handling, no socket
   bind): page registration, layout render, an HTTP sweep of every route, and a
   syntax check of every clientside callback.

This is the same harness ``scripts/compat_matrix.py`` runs against each Dash
version and the same one ``.github/workflows/ci.yml`` runs in the matrix, so
what passes here is what those measure.

Usage
-----
    python scripts/smoke_test.py                 # human-readable table
    python scripts/smoke_test.py --json out.json # machine-readable
    python scripts/smoke_test.py --quiet         # only failures
    python scripts/smoke_test.py --component     # skip the docs-site legs

Exit code is 0 when every check passed, 1 otherwise.
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
import traceback
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent

# The docs site lives at the repo root (like every other satellite), so one
# directory is both the cwd and the import root: it resolves docs/, assets/,
# components/, lib/ and pages/ relative to the working directory, imports
# `components.*` / `lib.*` / `pages.*` as top-level packages, and holds the
# built flexlayout_dash/ package the live examples import.
sys.path.insert(0, str(PROJECT_ROOT))
os.chdir(PROJECT_ROOT)

# Werkzeug's test client sends NO User-Agent by default, and at dimll >=2.8 an
# absent UA is crawler-lane (item 12's contract: no browser engine token, no
# browser lane). A mark_hidden() path (the admin pages) then 404s from the
# PACKAGE's own middleware before this app's own gate ever runs — a real
# fact about the crawler lane, not a route failure. Every route check below
# must use a browser-shaped UA so it exercises what an anonymous person
# actually sees; the internal token keeps this traffic off the analytics
# ledger (lib.constants.INTERNAL_UA_TOKEN).
try:
    from lib.constants import INTERNAL_UA as _INTERNAL_UA
except Exception:  # pragma: no cover — running outside a repo checkout
    _INTERNAL_UA = "2plot-internal/1.0 (+https://2plot.ai/docs/satellite-analytics)"
BROWSER_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 " + _INTERNAL_UA
)

# Never let a smoke run beacon traffic at the live 2plot.ai hub, and keep the
# ad client from adding a network timeout to every page view.
# Popping the secret is what keeps lib/satellite_reporter.py dormant, so no
# rollup is ever POSTed at the live hub from a test run.
os.environ.pop("CROSS_APP_WEBHOOK_SECRET", None)
os.environ.setdefault("AD_SERVER_URL", "http://127.0.0.1:1")  # unreachable → slot hides
# Keep the analytics ledger lib/analytics_tracker.py writes out of the working
# tree — it defaults to a path next to the app.
os.environ.setdefault("TRAFFIC_ANALYTICS_FILE",
                      str(Path(os.environ.get("TMPDIR", "/tmp")) / "flexlayout-smoke.json"))


class Results:
    def __init__(self) -> None:
        self.checks: list[dict] = []

    def add(self, group: str, name: str, ok: bool, detail: str = "") -> None:
        self.checks.append({"group": group, "name": name, "ok": ok, "detail": detail})

    @property
    def failures(self) -> list[dict]:
        return [c for c in self.checks if not c["ok"]]

    def summary(self) -> dict:
        return {
            "total": len(self.checks),
            "passed": len(self.checks) - len(self.failures),
            "failed": len(self.failures),
        }


# ---------------------------------------------------------------------------
# Leg 1 — the component itself
# ---------------------------------------------------------------------------

def _check_component(res: Results) -> None:
    """Import flexlayout_dash and serialise a realistic dock layout.

    This is deliberately independent of the docs site: a wheel installed with
    nothing but Dash present must pass exactly these checks, which is what
    ci.yml's `package-python-range` job asserts against the built artifact.
    """
    try:
        import flexlayout_dash as dfl
    except Exception:
        res.add("component", "flexlayout_dash imports", False, traceback.format_exc(limit=6))
        return
    res.add("component", "flexlayout_dash imports", True, f"v{dfl.__version__}")

    pkg_dir = Path(dfl.__file__).parent
    bundle = pkg_dir / "flexlayout_dash.min.js"
    res.add("component", "JS bundle present", bundle.exists(),
            f"{bundle.stat().st_size // 1024} KB" if bundle.exists() else str(bundle))

    for name in ("DashFlexLayout", "Tab"):
        res.add("component", f"exports {name}", hasattr(dfl, name))

    # Every entry in _js_dist must point at a file that actually shipped —
    # Dash 404s at runtime otherwise, and only in the browser.
    missing = [
        d["relative_package_path"] for d in getattr(dfl.DashFlexLayout, "_js_dist", [])
        if not (pkg_dir / d["relative_package_path"]).exists()
    ]
    res.add("component", "_js_dist files all exist", not missing,
            ", ".join(missing) or "all present")

    # A dock model exercising the shapes the component actually has to handle:
    # nested rows, a tabset, and a border.
    try:
        from dash import html
        from dash._utils import to_json

        model = {
            "global": {"tabEnableClose": False, "tabEnableFloat": True},
            "borders": [{
                "type": "border", "location": "left",
                "children": [{"type": "tab", "name": "Files", "id": "border-tab"}],
            }],
            "layout": {
                "type": "row", "weight": 100,
                "children": [
                    {"type": "tabset", "weight": 50, "children": [
                        {"type": "tab", "name": "One", "id": "tab-1"}]},
                    {"type": "tabset", "weight": 50, "children": [
                        {"type": "tab", "name": "Two", "id": "tab-2"}]},
                ],
            },
        }
        layout = html.Div([
            dfl.DashFlexLayout(
                id="dock",
                model=model,
                useStateForModel=True,
                supportsPopout=True,
                colorScheme="dark",
                style={"height": "500px"},
                children=[
                    dfl.Tab(id="tab-1", children=html.P("one")),
                    dfl.Tab(id="tab-2", children=html.P("two")),
                    dfl.Tab(id="border-tab", children=html.P("files")),
                ],
            ),
        ])
        to_json(layout)
        res.add("component", "dock layout serialises", True, "row + tabset + border")
    except Exception as exc:  # noqa: BLE001
        res.add("component", "dock layout serialises", False, f"{type(exc).__name__}: {exc}")


# ---------------------------------------------------------------------------
# Leg 2 — the documentation site
# ---------------------------------------------------------------------------

def _import_app(res: Results):
    """Import run.py and hand back (module, dash)."""
    t0 = time.time()
    try:
        import run  # noqa: F401  (side effects are the point)
        import dash

        res.add("import", "run.py imports", True, f"{time.time() - t0:.1f}s")
        return run, dash
    except Exception:
        res.add("import", "run.py imports", False, traceback.format_exc(limit=8))
        return None, None


def _check_registration(res: Results, dash_mod) -> None:
    registry = dash_mod.page_registry
    md_files = list(Path("docs").glob("*/*.md"))
    res.add("pages", "markdown files discovered", bool(md_files), f"{len(md_files)} files")

    paths = [entry["path"] for entry in registry.values()]
    dupes = {p for p in paths if paths.count(p) > 1}
    res.add("pages", "no duplicate page paths", not dupes, ", ".join(sorted(dupes)) or "clean")

    # Every markdown file should have produced a route.
    missing = []
    for md in md_files:
        try:
            import frontmatter

            meta, _ = frontmatter.parse(md.read_text())
            endpoint = meta.get("endpoint")
            if endpoint and endpoint not in paths:
                missing.append(f"{md} → {endpoint}")
        except Exception as exc:  # noqa: BLE001
            missing.append(f"{md} (frontmatter unreadable: {exc})")
    res.add("pages", "every .md registered a route", not missing,
            "; ".join(missing) or "all present")


def _render_layouts(res: Results, dash_mod) -> None:
    """Invoke and serialise every page layout — where broken examples surface."""
    from dash._utils import to_json

    for entry in dash_mod.page_registry.values():
        path, name = entry["path"], entry["name"]
        try:
            layout = entry["layout"]
            if callable(layout):
                layout = layout()
            to_json(layout)  # Dash's own encoder — catches invalid components
            res.add("layout", f"{path}", True, name)
        except Exception as exc:  # noqa: BLE001
            res.add("layout", f"{path}", False, f"{type(exc).__name__}: {exc}")


def _http_checks(res: Results, run_mod, dash_mod) -> None:
    server = run_mod.app.server
    try:
        client = server.test_client()
    except Exception as exc:  # noqa: BLE001
        res.add("http", "test client available", False, str(exc))
        return
    res.add("http", "test client available", True, type(server).__name__)

    def get(url: str, group: str, expect=(200,), label: str | None = None,
            user_agent: str = BROWSER_UA):
        try:
            resp = client.get(url, headers={"User-Agent": user_agent} if user_agent else {})
            ok = resp.status_code in expect
            res.add(group, label or url, ok, f"HTTP {resp.status_code}")
            return resp
        except Exception as exc:  # noqa: BLE001
            res.add(group, label or url, False, f"{type(exc).__name__}: {exc}")
            return None

    # Dash plumbing first — if these fail nothing else matters.
    get("/_dash-layout", "http")
    get("/_dash-dependencies", "http")

    # Network + SEO endpoints.
    get("/healthz", "endpoints")
    get("/llms.txt", "endpoints")
    get("/robots.txt", "endpoints")
    get("/sitemap.xml", "endpoints")

    # The SPA pageview beacon. A 400 here means the payload contract with the
    # clientside beacon in run.py drifted and SPA traffic would silently stop.
    try:
        resp = client.post("/api/pageview", json={"path": "/basic"})
        res.add("endpoints", "/api/pageview", resp.status_code == 200,
                f"HTTP {resp.status_code}")
    except Exception as exc:  # noqa: BLE001
        res.add("endpoints", "/api/pageview", False, f"{type(exc).__name__}: {exc}")

    # The component bundle must be reachable at the URL Dash advertises for it;
    # a 404 here is a blank dock in the browser and nothing in the server log.
    get("/_dash-component-suites/flexlayout_dash/flexlayout_dash.min.js",
        "endpoints", label="component bundle served")

    # Every page path. A Dash SPA returns the same index HTML for all of them,
    # so a non-200 means routing or the index template broke. Browser-lane UA:
    # a real person on /admin/traffic or /admin/control-board sees a 200 with
    # the fail-closed hidden card (lib/gate_layouts.py), never a 404 — the
    # 404 belongs to crawlers only, checked separately below.
    for entry in dash_mod.page_registry.values():
        get(entry["path"], "routes")

    # The crawler-404 positive control (paired with the browser-lane 200s
    # above): an admin path is mark_hidden(), so the PACKAGE's own bot
    # middleware 404s a crawler-lane request before this app's gate ever
    # runs. Checked with no User-Agent at all — the absent-UA-is-crawler
    # contract (item 12) — so this is also proof the ledger's crawler
    # classification and the SEO 404 agree on the same lane.
    admin_paths = [e["path"] for e in dash_mod.page_registry.values()
                  if e["path"].startswith("/admin/")]
    for path in admin_paths:
        get(path, "crawler-404", expect=(404,), user_agent="",
            label=f"{path} (crawler lane)")


def _check_callbacks(res: Results, run_mod) -> None:
    try:
        cb_count = len(run_mod.app.callback_map)
        res.add("callbacks", "callbacks registered", cb_count > 0, f"{cb_count} callbacks")
    except Exception as exc:  # noqa: BLE001
        res.add("callbacks", "callbacks registered", False, str(exc))


def _check_clientside_js(res: Results, run_mod) -> None:
    """Syntax-check every inline clientside callback with node.

    Python-side tests cannot catch a malformed clientside callback: Dash ships
    the string to the browser verbatim, so a syntax error is silent server-side
    and the callback simply never runs. The theme toggle, the navbar collapse
    and the satellite pageview beacon are all clientside here.
    """
    scripts = getattr(run_mod.app, "_inline_scripts", [])
    if not scripts:
        res.add("clientside", "inline scripts collected", False, "none found")
        return
    res.add("clientside", "inline scripts collected", True, f"{len(scripts)} scripts")

    if not shutil.which("node"):
        res.add("clientside", "javascript parses", True, "SKIPPED — node not installed")
        return

    bad: list[str] = []
    for i, src in enumerate(scripts):
        proc = subprocess.run(["node", "--check", "-"], input=src,
                              capture_output=True, text=True, timeout=20)
        if proc.returncode:
            first = next((ln for ln in proc.stderr.splitlines() if ln.strip()), "")
            bad.append(f"script[{i}]: {first[:120]}")

    res.add("clientside", "javascript parses", not bad,
            "all valid" if not bad else f"{len(bad)} invalid — " + "; ".join(bad[:3]))


def _check_asset_js(res: Results) -> None:
    """Syntax-check assets/*.js individually AND concatenated.

    The concatenated pass is the one that matters. Dash serves everything in
    `assets/` as separate classic <script> tags, which share ONE global lexical
    scope — so a top-level `const log` in two files is a SyntaxError in the
    second, and every handler in it silently never registers. Checking files
    one at a time cannot see that; concatenating them reproduces the browser's
    actual condition.
    """
    assets = sorted(Path("assets").glob("*.js"))
    if not assets:
        return
    if not shutil.which("node"):
        res.add("assets", "javascript parses", True, "SKIPPED — node not installed")
        return

    bad = []
    for f in assets:
        proc = subprocess.run(["node", "--check", str(f)],
                              capture_output=True, text=True, timeout=20)
        if proc.returncode:
            first = next((ln for ln in proc.stderr.splitlines() if "Error" in ln), "")
            bad.append(f"{f.name}: {first[:80]}")
    res.add("assets", f"each of {len(assets)} files parses", not bad,
            "all valid" if not bad else "; ".join(bad[:3]))

    combined = "\n".join(f.read_text() for f in assets)
    proc = subprocess.run(["node", "--check", "-"], input=combined,
                          capture_output=True, text=True, timeout=30)
    ok = proc.returncode == 0
    detail = "no global collisions"
    if not ok:
        detail = next((ln for ln in proc.stderr.splitlines() if "Error" in ln),
                      "see node output")[:120]
    res.add("assets", "no collisions in shared global scope", ok, detail)


def run_all(component_only: bool = False) -> Results:
    res = Results()
    _check_component(res)
    if component_only:
        return res
    run_mod, dash_mod = _import_app(res)
    if run_mod is None:
        return res
    _check_registration(res, dash_mod)
    _render_layouts(res, dash_mod)
    _http_checks(res, run_mod, dash_mod)
    _check_callbacks(res, run_mod)
    _check_clientside_js(res, run_mod)
    _check_asset_js(res)
    return res


def report(res: Results, quiet: bool = False) -> None:
    import dash

    width = 78
    print()
    print("=" * width)
    print(f" flexlayout-dash smoke test · Dash {dash.__version__} · "
          f"Python {sys.version.split()[0]}")
    print("=" * width)

    current = None
    for c in res.checks:
        if quiet and c["ok"]:
            continue
        if c["group"] != current:
            current = c["group"]
            print(f"\n[{current}]")
        mark = "PASS" if c["ok"] else "FAIL"
        detail = c["detail"].replace("\n", "\n        ") if c["detail"] else ""
        print(f"  {mark}  {c['name']:<38} {detail}")

    s = res.summary()
    print()
    print("-" * width)
    print(f" {s['passed']}/{s['total']} checks passed"
          + (f" · {s['failed']} FAILED" if s["failed"] else ""))
    print("-" * width)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--json", metavar="PATH", help="write machine-readable results here")
    ap.add_argument("--quiet", action="store_true", help="print only failures")
    ap.add_argument("--component", action="store_true",
                    help="check only the installed component, not the docs site")
    args = ap.parse_args()

    res = run_all(component_only=args.component)
    report(res, quiet=args.quiet)

    if args.json:
        import dash

        payload = {
            "dash_version": getattr(dash, "__version__", "unknown"),
            "python": sys.version.split()[0],
            "summary": res.summary(),
            "checks": res.checks,
        }
        out = Path(args.json)
        if not out.is_absolute():
            out = PROJECT_ROOT / out
        out.write_text(json.dumps(payload, indent=2))
        print(f"\nWrote {out}")

    return 0 if not res.failures else 1


if __name__ == "__main__":
    sys.exit(main())
