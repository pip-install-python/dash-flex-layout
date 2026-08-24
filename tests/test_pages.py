"""Every page loads, and every page serves real content to a crawler."""

from __future__ import annotations

import re

import pytest

from conftest import CRAWLER_UA, STUB_MARKER, main_body

# Pages that must exist. A markdown file silently failing to register is
# invisible in a smoke test that only iterates whatever did register — the
# suite would pass with half the site missing.
REQUIRED_PATHS = {
    "/",
    "/getting-started",
    "/basic",
    "/borders",
    "/callbacks",
    "/reference",
    "/theming",
}

# The owner-only control board. It is a real registered page, so it turns up
# in `page_paths`, but it is not documentation: no prose is registered for it,
# it is mark_hidden() from every machine surface, and it fails closed. Loops
# that assert documentation properties skip it.
ADMIN_PATHS = {"/admin/control-board"}


def docs_paths(page_paths):
    return [p for p in page_paths if p not in ADMIN_PATHS]


def test_every_required_page_registered(page_paths):
    missing = REQUIRED_PATHS - set(page_paths)
    assert not missing, f"pages missing from dash.page_registry: {sorted(missing)}"


def test_no_duplicate_page_paths(page_paths):
    duplicates = {p for p in page_paths if page_paths.count(p) > 1}
    assert not duplicates, f"two pages registered on the same path: {sorted(duplicates)}"


def test_pages_are_reachable(client, page_paths):
    failures = [(p, client.get(p).status) for p in page_paths]
    assert [f for f in failures if f[1] != 200] == []


def test_no_page_serves_the_javascript_stub(client, page_paths):
    """The regression that cost this network twelve of fourteen crawlable URLs.

    A stub here means the page has no prose registered, or something erased
    it after registration. Either way crawlers and agents see nothing.
    """
    stubbed = [p for p in page_paths if STUB_MARKER in client.get(p, user_agent=CRAWLER_UA).text]
    assert stubbed == [], f"pages serving the stub body to crawlers: {stubbed}"


def test_crawler_bodies_are_substantial(client, page_paths):
    """A page can avoid the stub and still serve almost nothing.

    1200 characters rather than the template's 2000, and the reason is what
    this site documents: three of its pages (/basic, /borders, /theming) are
    mostly a LIVE dock demo behind `.. exec::`, which renders to a component
    tree and contributes no prose to the crawler body at all. Their real text
    runs 1500-1700 characters. A threshold above that would either fail
    forever or push someone to pad the prose to satisfy a test — the floor is
    set where "the page lost its content" is still caught (the stub is ~300)
    without penalising a page whose subject is an interaction.
    """
    thin = []
    for path in docs_paths(page_paths):
        body = main_body(client.get(path, user_agent=CRAWLER_UA).text)
        if len(body) < 1200:
            thin.append((path, len(body)))
    assert thin == [], f"suspiciously small crawler bodies: {thin}"


def test_prose_renders_as_html_not_literal_markdown(client):
    """2.1's renderer: links, code fences, rules and tables, not raw text.

    Before 2.1 these came through as `<p>---</p>`, literal `[text](url)` and
    pipe characters. Checked on Getting Started: it is the page that mixes all
    four constructs — install/usage code fences, rules, inline links and a
    list — in the shortest span.
    """
    body = main_body(client.get("/getting-started", user_agent=CRAWLER_UA).text)

    assert body.count("<pre") >= 2, "expected code fences to render as <pre> blocks"
    assert "<hr" in body, "expected horizontal rules to render as <hr>"
    assert not re.search(r"<p>\s*-{3,}\s*</p>", body), "horizontal rule leaked as literal text"
    assert not re.search(r"\[[^\]]+\]\(https?://", body), "markdown link leaked as literal text"


def test_pages_have_distinct_titles(client, page_paths):
    """Dash serves one static index template for every route, so without a
    per-page title every URL ships identical head metadata — which is most of
    what makes a site look like a set of near-duplicates."""
    titles = {}
    for path in docs_paths(page_paths):
        html = client.get(path).text
        match = re.search(r"<title>(.*?)</title>", html, re.S)
        assert match, f"{path} served no title element"
        titles[path] = match.group(1).strip()

    duplicates = {t for t in titles.values() if list(titles.values()).count(t) > 1}
    assert not duplicates, f"pages sharing a title: {duplicates}"


def test_home_page_links_out_to_other_pages(client):
    body = main_body(client.get("/", user_agent=CRAWLER_UA).text)
    assert body.count("<a href=") >= 5, "home page prose has almost no outbound links"


@pytest.mark.parametrize("path", ["/nope", "/basic/does-not-exist"])
def test_unknown_paths_do_not_500(client, path):
    assert client.get(path).status in (200, 404), "unknown path should 404 or render the app's 404"


def test_prerender_rides_the_generic_lane_not_a_ua_gate(client):
    """The universal prerender must be in the initial HTML for a PLAIN
    client — no crawler user-agent. An outside SEO audit (2026-08-22) read
    five hosts as serving "Loading... and nothing else" to browsers; the
    prose was there all along, but every test in this file fetched with
    CRAWLER_UA (which exercises the separate bot-document path), so a
    regression that UA-gated the universal lane would have been invisible
    to the suite. This test is the generic-lane pin.

    Since the 2.6.1 floor the block must also be VISIBLE: dimll <= 2.6.0
    shipped the div with a literal `hidden` attribute, so every
    visibility-respecting text extractor (and arguably crawler
    content-weighting) saw only "Loading..." — present and invisible, the
    worst of both. 2.6.1 serves it visible and hides it via a synchronous
    inline script that only JS browsers execute (React's mount then wipes
    the pair, so nothing changes for humans). The div shape below is the
    regression pin for that fix, from the app's side.
    """
    for path in ("/", "/getting-started"):
        html = client.get(path).text  # default UA — the point of the test
        div = re.search(r'<div id="dimll-prerender"[^>]*>', html)
        assert div, (
            f"{path}: no prerender block for a generic client — the "
            "universal lane is gated or off"
        )
        assert "hidden" not in div.group(0), (
            f"{path}: the prerender div carries `hidden` again — "
            "visibility-respecting consumers are back to reading "
            "'Loading...'; the floor first moved (to 2.6.1) for exactly "
            "this, and sits at >=2.7.1 now"
        )
        assert 'data-dimll-prerender="1">document.getElementById' in html, (
            f"{path}: the marked synchronous hide script is missing — "
            "JS browsers would flash the prose before React mounts"
        )
        assert "<main>" in html, f"{path}: prerender block carries no <main> prose"


def test_prerender_single_h1_and_deduped_footer_llms_links(client, page_paths):
    """What the >=2.7.1 floor buys, pinned from the app's side, EVERY page.

    Below dimll 2.7.0 every page served TWO h1s to a generic client — the
    injected prerender header plus the doc body's own markdown H1, a
    duplicate-H1 page in every crawler's eyes (2026-08-22 SEO-audit
    finding) — and the home footer printed its /llms.txt link twice (on
    "/" the per-page link equals the root's; subpages legitimately carry
    both, DISTINCT). The sweep also catches app-side H1 pollution: on the
    boilerplate its first run found docs/example's machine lane serving
    FIVE h1s because _expand_source_directives expanded a `.. source::`
    example inside a ```markdown teaching fence (fixed fence-aware,
    template 1.6.11 — ported here).

    HTML comments are stripped before counting: templates/index.html
    legitimately SAYS "h1" inside the comment explaining its noscript
    block. The control board is skipped — it is hidden from every machine
    surface and carries no prerender.
    """
    for path in docs_paths(page_paths):
        html = client.get(path).text  # default UA — the universal lane
        stripped = re.sub(r"<!--.*?-->", "", html, flags=re.S)

        h1s = re.findall(r"<h1[\s>]", stripped)
        assert len(h1s) == 1, (
            f"{path}: {len(h1s)} h1 elements in the generic-lane document — "
            "either the pre-2.7.0 prerender-header duplicate or app-side "
            "markdown leaking headings (the fence-expansion class)"
        )

        footer = re.search(r"<footer.*?</footer>", stripped, re.S)
        assert footer, f"{path}: no prerender footer in the generic-lane document"
        llms_links = re.findall(r'href="([^"]*llms\.txt)"', footer.group(0))
        assert len(llms_links) == len(set(llms_links)), (
            f"{path}: duplicate llms.txt links in the prerender footer "
            f"({llms_links}) — 2.7.0 dedups the per-page link when it "
            "equals the root"
        )
        if path == "/":
            assert llms_links == ["/llms.txt"], (
                f"home footer llms links {llms_links} — expected exactly the "
                "root link once"
            )


def test_source_expansion_is_fence_aware(app):
    """A `.. source::` inside a fenced block is documentation, not a directive.

    No page in docs/ teaches the directive inside a fence TODAY, which is
    exactly why this is pinned: the boilerplate's docs/example and
    docs/directives do, and the moment one of those pages is adopted here
    the un-fenced expansion injects a ```python fence inside the already-open
    one, closing it early — from there the inlined file renders as markdown
    on the machine lane and every `# comment` line becomes an <h1> (the
    five-h1 finding, 2026-08-23; the browser lane was never affected because
    markdown2dash parses fences properly). The app fixture is requested only
    so pages/markdown.py is already imported with the repo root as CWD.
    """
    import sys

    expand = sys.modules["pages.markdown"]._expand_source_directives

    expanded = expand(".. source::requirements.txt")
    assert "# File: requirements.txt" in expanded, "real directive not expanded"
    assert "```" in expanded, "expansion lost its fence"

    taught = "```markdown\n.. source::requirements.txt\n```"
    assert expand(taught) == taught, "a fenced example was expanded"

    tilde = "~~~\n.. source::requirements.txt\n~~~"
    assert expand(tilde) == tilde, "a tilde-fenced example was expanded"


def test_llms_doc_preamble_does_not_double_a_body_h1(app):
    """`# {name}` is skipped when the body already opens with its own H1.

    docs/home/home.md opens with the site brand as an H1 — the identity
    standard, pinned by tests/test_site_identity.py — so the preamble would
    make the home page's machine lane a duplicate-H1 document: exactly the
    defect dash-improve-my-llms 2.7.0 removed from the package's side,
    reintroduced one layer up by this app. Measured on 2026-08-23: `/` served
    3 h1s on 2.7.1 before this (noscript + preamble + brand), 4 on 2.6.1.

    This is a deliberate divergence from the boilerplate, whose docs all
    start at h2 and so never hit it.
    """
    import sys

    md = sys.modules["pages.markdown"]
    build = md._build_llms_doc

    own_h1 = build("Home", "A description.", "# The Brand\n\nprose\n", "/")
    assert own_h1.splitlines()[0] == "# The Brand", own_h1[:120]
    assert "# Home" not in own_h1, "preamble title doubled the body's H1"

    no_h1 = build("Theming", "A description.", "## Section\n\nprose\n", "/theming")
    assert no_h1.splitlines()[0] == "# Theming", no_h1[:120]
    assert "> A description." in no_h1, "preamble tagline lost"

    # Fence-aware: a `# comment` inside a code block is not a heading, and
    # this fork's docs are full of them.
    fenced = build("Basic", "A description.", "```python\n# not a heading\n```\n", "/basic")
    assert fenced.splitlines()[0] == "# Basic", fenced[:120]
