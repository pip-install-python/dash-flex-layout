"""Shared fixtures — boot the real app once, then interrogate it.

The suite deliberately exercises `run.py` itself rather than a stripped-down
app assembled for testing. Nearly everything worth catching here lives in the
wiring: registration order, which middleware runs first, whether a page's
prose survived to the response. A test app that re-implements that wiring
tests the re-implementation.

This site is Flask-only, so the multi-backend client the boilerplate carries
is collapsed to the Werkzeug branch — same `.get(path, user_agent=...)`
surface, same lenient decode.

SECRETLESS, AND ORDER MATTERS. The suite runs against the app exactly as CI's
zero-secret container does: no `CROSS_APP_WEBHOOK_SECRET` (the traffic
reporter never starts a thread), and the analytics ledger in a temp dir. The
env block below has to run BEFORE anything imports `run.py`, because run.py
calls `load_dotenv()` during that import and a developer's local `.env` would
otherwise flip the app into a configured posture. `load_dotenv()` never
overrides an existing key, so pinning each secret to `""` here (falsy to every
`os.getenv(...) or None` reader in `lib/`) neutralises the file without
deleting it. In CI there is no `.env` at all and this is belt-and-braces.
Same pattern as the boilerplate, 2plotai and pip-docs+.
"""

from __future__ import annotations

import importlib.util
import os
import sys
import tempfile
from pathlib import Path

import pytest

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

# --- 1. Neutralise every secret (must precede any import of run.py) ---------
SECRET_ENV_KEYS = (
    "CROSS_APP_WEBHOOK_SECRET",
    "SATELLITE_TRAFFIC_URL",
    "NETWORK_BULLETIN_URL",
    # Clerk: the gate must be provably dormant without keys. lib/auth.clerk_enabled
    # needs all three of SECRET/PUBLISHABLE/SIGN_IN plus an importable package, so
    # emptying them here is what makes "docs fall open without Clerk" a tested
    # property rather than an assumption about the developer's .env.
    "CLERK_SECRET_KEY", "CLERK_PUBLISHABLE_KEY", "CLERK_SIGN_IN_URL",
    "CLERK_SIGN_UP_URL", "CLERK_FRONTEND_API", "CLERK_WEBHOOK_SECRET",
    "CLERK_IS_SATELLITE", "CLERK_SATELLITE_DOMAIN", "SESSION_SECRET",
    "ADMIN_EMAILS",
)
for _key in SECRET_ENV_KEYS:
    os.environ[_key] = ""

# --- 2. Keep app state out of the repo --------------------------------------
# Without this the suite appends its own hits to the checked-out
# visitor_analytics.json, which then shows up in `git status` and, worse, in
# the next hourly rollup a developer's local run happens to send.
_TMP_STATE = tempfile.mkdtemp(prefix="flexlayout-tests-")
os.environ["TRAFFIC_ANALYTICS_FILE"] = os.path.join(_TMP_STATE, "visitor_analytics.json")
# The control board's override store. Same reason, sharper edge: without this
# the suite's toggles would be written to whatever PAGE_VISIBILITY_FILE points
# at — in a developer shell, the real one.
os.environ["PAGE_VISIBILITY_FILE"] = os.path.join(_TMP_STATE, "page_visibility.json")
# Behind Cloudflare in production; in tests an outbound ip-api.com lookup per
# hit would make the suite depend on a third party being up.
os.environ["ANALYTICS_GEO_LOOKUP"] = "0"
# The base-URL guard keys off RENDER/APP_ENV; keep it inert.
os.environ.setdefault("APP_ENV", "test")

BROWSER_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
)
CRAWLER_UA = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

# What a real browser sends. `/<page>/llms.txt` negotiates on this header —
# not on the User-Agent — so it is what separates "a person opened the URL"
# from "an agent fetched it".
BROWSER_ACCEPT = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"

# The body dash-improve-my-llms serves when a page has no prose registered.
# Its presence on any page is the failure this whole network cares most about.
STUB_MARKER = "This page contains interactive content that requires JavaScript"


@pytest.fixture(scope="session")
def app_module():
    """Import run.py as a module, from the repo root.

    run.py opens 'templates/index.html' by relative path and pages/markdown.py
    globs 'docs/**/*.md', so the process CWD has to be the repo root regardless
    of where pytest was invoked from.
    """
    os.chdir(REPO_ROOT)
    spec = importlib.util.spec_from_file_location("runmod", REPO_ROOT / "run.py")
    module = importlib.util.module_from_spec(spec)
    sys.modules["runmod"] = module
    try:
        spec.loader.exec_module(module)
    except SystemExit:  # pragma: no cover - run.py doesn't call sys.exit today
        pass
    return module


@pytest.fixture(scope="session")
def app(app_module):
    return app_module.app


class Response:
    __slots__ = ("status", "text", "headers")

    def __init__(self, status: int, text: str, headers=None) -> None:
        self.status = status
        self.text = text
        # Keys are lowercased so no test cares how the server cased them —
        # `/<page>/llms.txt` content-negotiates, so the *type* of the response
        # is part of the contract and `Vary` is what stops a CDN serving
        # cached HTML to the next agent.
        self.headers = {k.lower(): v for k, v in (headers or {}).items()}

    @property
    def ok(self) -> bool:
        return self.status == 200

    def header(self, name: str, default: str = "") -> str:
        return self.headers.get(name.lower(), default)

    @property
    def content_type(self) -> str:
        return self.header("Content-Type")

    def __repr__(self) -> str:  # pragma: no cover - assertion output only
        return f"<Response {self.status} {self.content_type} {len(self.text)}b>"


class Client:
    """One synchronous `.get()` over the Werkzeug test client."""

    def __init__(self, raw) -> None:
        self._raw = raw

    def get(self, path: str, user_agent: str = BROWSER_UA, accept: str = None) -> Response:
        headers = {"User-Agent": user_agent}
        if accept is not None:
            headers["Accept"] = accept
        r = self._raw.get(path, headers=headers)
        # errors="replace", not `as_text=True`: the latter decodes strictly
        # and raises UnicodeDecodeError on any binary response, so a test
        # that merely checks a favicon or a manifest icon RESOLVES would
        # blow up on the PNG's first byte.
        return Response(r.status_code, r.get_data().decode("utf-8", "replace"),
                        dict(r.headers))


@pytest.fixture(scope="session")
def client(app):
    yield Client(app.server.test_client())


@pytest.fixture(scope="session")
def tmp_state_dir():
    """Where the app's ledger and lease files live for this run."""
    return _TMP_STATE


@pytest.fixture(scope="session")
def pages(app_module):
    """Every registered page as (path, name, entry), sorted by path."""
    import dash

    return sorted(
        ((entry["path"], entry.get("name", ""), entry) for entry in dash.page_registry.values()),
        key=lambda item: item[0],
    )


@pytest.fixture(scope="session")
def page_paths(pages):
    return [path for path, _name, _entry in pages]


def main_body(html: str) -> str:
    """The prerendered <main> block, or '' when the document has none."""
    if "<main>" not in html:
        return ""
    return html.split("<main>", 1)[1].split("</main>", 1)[0]
