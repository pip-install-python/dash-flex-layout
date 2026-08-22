"""Configuration that is silently wrong when it's wrong: base URL, template
metadata, and the version numbers that live in more than one file."""

from __future__ import annotations

import json
import re

import pytest

from conftest import REPO_ROOT
from lib import constants

INDEX_HTML = (REPO_ROOT / "templates" / "index.html").read_text()

# The template is heavily commented, and several comments quote the very tags
# they are explaining. Scanning for live markup has to ignore them.
INDEX_HTML_LIVE = re.sub(r"<!--.*?-->", "", INDEX_HTML, flags=re.S)


# ---------------------------------------------------------------------------
# BASE_URL guard
# ---------------------------------------------------------------------------


def test_default_base_url_is_this_hosts_own_domain(monkeypatch):
    """A DELIBERATE deviation from the template, and the reason is the fork.

    The boilerplate defaults BASE_URL to its own domain and makes an unset
    APP_BASE_URL fatal in production — correct there, because a fork that
    inherits the template's default silently deindexes itself as a duplicate
    of the template. This repo IS the fork: its default is its own real
    domain, so the failure the template's guard exists to catch cannot happen
    here, and there is nothing to raise about.
    """
    monkeypatch.delenv("APP_BASE_URL", raising=False)
    monkeypatch.delenv("FLEXLAYOUT_BASE_URL", raising=False)
    import importlib

    reloaded = importlib.reload(constants)
    try:
        assert reloaded.BASE_URL == "https://flexlayout.2plot.dev"
        assert not reloaded.BASE_URL.endswith("/")
    finally:
        importlib.reload(constants)


def test_the_shared_env_name_wins_over_the_legacy_alias(monkeypatch):
    """Two names on the live service, and the order between them matters.

    APP_BASE_URL is the network-shared spelling every host's scripts and tests
    read; FLEXLAYOUT_BASE_URL is this repo's legacy alias, still set on the
    live service and deliberately kept until a named fleet retirement pass.
    render.yaml sets BOTH — removing one of two names from a live service is
    how a satellite quietly deindexes itself.
    """
    monkeypatch.setenv("APP_BASE_URL", "https://shared.example")
    monkeypatch.setenv("FLEXLAYOUT_BASE_URL", "https://legacy.example")
    import importlib

    reloaded = importlib.reload(constants)
    try:
        assert reloaded.BASE_URL == "https://shared.example"
    finally:
        monkeypatch.delenv("APP_BASE_URL", raising=False)
        monkeypatch.delenv("FLEXLAYOUT_BASE_URL", raising=False)
        importlib.reload(constants)


def test_guard_is_inert_outside_production(monkeypatch):
    monkeypatch.delenv("RENDER", raising=False)
    monkeypatch.delenv("APP_ENV", raising=False)
    monkeypatch.delenv("APP_BASE_URL", raising=False)
    constants.require_owned_base_url()  # must not raise locally or in CI


def test_guard_tolerates_an_unset_base_url_in_production(monkeypatch):
    """The mirror of the template's test, and deliberately the opposite.

    There, an unset APP_BASE_URL in production is fatal because the fallback
    is another site's domain. Here the fallback IS this site's domain, so an
    unset variable is merely redundant — refusing to boot over it would take
    the site down to prevent a canonical that was already correct.
    """
    monkeypatch.setenv("RENDER", "true")
    monkeypatch.delenv("APP_BASE_URL", raising=False)
    monkeypatch.delenv("FLEXLAYOUT_BASE_URL", raising=False)
    constants.require_owned_base_url("https://flexlayout.2plot.dev")


def test_guard_rejects_platform_hostnames(monkeypatch):
    monkeypatch.setenv("RENDER", "true")
    monkeypatch.setenv("APP_BASE_URL", "https://my-docs.onrender.com")
    with pytest.raises(RuntimeError, match="platform-generated"):
        constants.require_owned_base_url("https://my-docs.onrender.com")


def test_guard_accepts_a_real_domain(monkeypatch):
    monkeypatch.setenv("RENDER", "true")
    monkeypatch.setenv("APP_BASE_URL", "https://leaflet.2plot.dev")
    constants.require_owned_base_url("https://leaflet.2plot.dev")


# ---------------------------------------------------------------------------
# index.html
# ---------------------------------------------------------------------------


def test_template_has_no_hardcoded_canonical():
    """The package injects a per-page canonical. A second one in the template
    doesn't override it — both ship, and a conflicting pair is no signal."""
    live = re.findall(r'<link[^>]+rel="canonical"[^>]*>', INDEX_HTML_LIVE)
    assert live == [], f"remove the hard-coded canonical: {live}"


def test_template_has_no_placeholder_hosts():
    for placeholder in ("yourdomain.com", "onrender.com", "Your Organization Name",
                        "Your Name or Organization", "plotly.pro"):
        assert placeholder not in INDEX_HTML, f"{placeholder!r} left in templates/index.html"


def test_template_references_only_assets_that_exist():
    """A <link> or <meta> pointing at a missing asset is a 404 on every page
    load — invisible in a browser, noisy in the logs, and a broken preview
    card on every share."""
    referenced = set(
        re.findall(
            r'["\'(](?:https://boilerplate\.2plot\.dev)?/assets/([^"\')\s]+)',
            INDEX_HTML_LIVE,
        )
    )
    missing = {name for name in referenced if not (REPO_ROOT / "assets" / name).exists()}
    assert not missing, f"index.html references assets that do not exist: {sorted(missing)}"


def test_structured_data_parses():
    blocks = re.findall(
        r'<script type="application/ld\+json">\s*(\{.*?\})\s*</script>', INDEX_HTML, re.S
    )
    assert len(blocks) >= 2, "expected Organization and SoftwareApplication JSON-LD"
    for block in blocks:
        json.loads(block)  # raises on malformed markup


def test_declared_software_version_matches_constants():
    """Two places hold the version; they drift the moment one is bumped alone."""
    blocks = re.findall(
        r'<script type="application/ld\+json">\s*(\{.*?\})\s*</script>', INDEX_HTML, re.S
    )
    versions = [
        json.loads(b)["softwareVersion"] for b in blocks if "softwareVersion" in b
    ]
    assert versions == [constants.APP_VERSION], (
        f"index.html declares softwareVersion {versions}, lib/constants.py says "
        f"{constants.APP_VERSION}"
    )


# ---------------------------------------------------------------------------
# The title element
#
# dash-improve-my-llms locates it with `re.compile(r"<title>.*?</title>",
# DOTALL | IGNORECASE)` and rewrites the first match. Two ways that goes
# wrong, both silent:
#
#   - No element at all: nothing to anchor on, so no page gets a title.
#   - The tag name written in angle brackets inside a nearby comment: the
#     match starts THERE and runs to the next closing tag, so every line in
#     between is replaced by the rewritten title and disappears from the
#     served page. With rewriting on it still looks correct.
# ---------------------------------------------------------------------------

TITLE_RE = re.compile(r"<title>.*?</title>", re.S | re.I)


def test_template_uses_the_dash_title_placeholder():
    """A hard-coded title discards the per-page titles pages/markdown.py
    registers, and makes every page depend on the package rewriting it."""
    assert "<title>{%title%}</title>" in INDEX_HTML


def test_only_one_title_match_and_it_is_the_element():
    """Guards the comment trap in both directions."""
    matches = TITLE_RE.findall(INDEX_HTML)
    assert matches == ["<title>{%title%}</title>"], (
        "the title regex matched something other than the element itself — "
        "check for the tag name written in angle brackets inside a comment"
    )


def test_no_title_tag_spelled_out_in_comments():
    for comment in re.findall(r"<!--.*?-->", INDEX_HTML, re.S):
        assert "<title" not in comment.lower(), (
            "a comment spells the title tag in angle brackets; the package's "
            "regex would start matching there and swallow the lines that follow"
        )


def test_app_title_is_set(app_module):
    """`{%title%}` resolves to app.title in the served HTML. Unset, Dash's
    default is the bare string "Dash" on every page."""
    assert app_module.app.title == constants.APP_TITLE
    assert constants.APP_TITLE != "Dash"


def test_no_dead_llm_endpoints_advertised():
    """/page.json and /architecture.txt were removed in dash-improve-my-llms
    2.0. Advertising them points agents at two 404s."""
    for dead in ("/page.json", "/architecture.txt", "/llms.toon"):
        assert dead not in INDEX_HTML_LIVE, (
            f"{dead} is no longer served but is still advertised"
        )


# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------


def test_the_installed_package_meets_the_floor(app_module):
    """Fail with the reason, not with thirty downstream symptoms.

    An IDE run configuration pointing at another project's virtualenv starts
    this app quite happily against whatever versions that environment holds.
    On dash-improve-my-llms 2.0.0 there is no `llms_viewer.py` at all, so
    `/<page>/llms.txt` serves plain Markdown to everyone and the negotiation
    tests below fail in a way that reads like a bug in the app. It isn't; it's
    the interpreter.
    """
    import sys

    import dash_improve_my_llms as pkg

    installed = tuple(int(p) for p in pkg.__version__.split(".")[:3] if p.isdigit())
    assert installed >= app_module.LLMS_PKG_FLOOR, (
        f"dash-improve-my-llms {pkg.__version__} is below the "
        f"{app_module.LLMS_PKG_FLOOR} floor. Running from {sys.executable} — "
        "if that is not this project's .venv, that is the whole problem."
    )


# ---------------------------------------------------------------------------
# Constructor arguments
# ---------------------------------------------------------------------------


def test_no_mcp_keyword_reaches_the_dash_constructor():
    """Dash raises TypeError on unknown constructor keywords.

    `enable_mcp` landed in Dash 4.3. This repo's CI matrix runs the docs site
    against Dash 4.1 through 4.4, so naming that keyword — even guarded — is
    how the site would refuse to boot on the older legs with an error that
    says nothing about MCP, over a feature that is off by default. This fork
    does not wire the MCP server at all (the template does, behind a
    signature check); the guard here is simply that the keyword never appears.
    """
    run_py = (REPO_ROOT / "run.py").read_text()
    assert "enable_mcp" not in run_py, (
        "run.py names enable_mcp — it must not reach Dash() on the 4.1/4.2 "
        "legs of the compatibility matrix"
    )


# ---------------------------------------------------------------------------
# Repo hygiene
# ---------------------------------------------------------------------------


# Live links to domains that have been retired. Matching the URL rather than
# the bare hostname on purpose: the changelog has to name plotly.pro in the
# entry that records its removal, and that mention is not a broken link.
RETIRED_LINKS = re.compile(r"https?://(?:www\.)?(plotly\.pro)")

SKIP_DIRS = {".venv", "node_modules", ".git", "__pycache__", ".claude", "vendor", ".idea"}


def test_no_links_to_retired_domains():
    """plotly.pro was retired in favour of 2plot.ai."""
    offenders = []
    for path in REPO_ROOT.glob("**/*"):
        if not path.is_file() or path.suffix not in {".py", ".md", ".html", ".css", ".yml"}:
            continue
        if any(part in SKIP_DIRS for part in path.parts):
            continue
        for match in RETIRED_LINKS.finditer(path.read_text(errors="ignore")):
            offenders.append(f"{path.relative_to(REPO_ROOT)} -> {match.group(1)}")
    assert offenders == [], f"links to retired domains: {offenders}"
