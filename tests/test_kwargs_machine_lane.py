"""The 4th empty-machine-lane mechanism (item 18, muicharts 1b2ac12) — this
fork's own instance, found while porting the item: a markdown2dash DIRECTIVE
that renders Dash components (lib/directives/kwargs.py's Kwargs) puts its
output ONLY in the React tree. The machine lane (`/<page>/llms.txt`) and the
crawler HTML are both built from the markdown SOURCE, where the directive
line survived untouched — so docs/reference/reference.md's two
`.. kwargs::` tables (13 props on DashFlexLayout, 2 on Tab) reached browsers
and were completely absent from `/reference/llms.txt` and the crawler
document.

The test lesson from the drop: assert ROWS and row CONTENT with lane-parity
pins, never section headings (a heading survives even when the table under
it goes missing), and MUTATION-CHECK them — disable the expansion and watch
the pins go red, so a future refactor that quietly breaks the wiring is
caught here rather than by a human reading the wire.

Artifact measured: `/reference/llms.txt` (the machine lane dash-improve-
my-llms serves) and the crawler-UA HTML response to `/reference` (built
from the same expanded markdown — this fix's actual landing site, not the
browser's JS-rendered DOM, which was never broken).
"""

from __future__ import annotations

CRAWLER_UA = "Mozilla/5.0 (compatible; Googlebot/2.1)"

# A handful of real prop facts from flexlayout_dash's docstrings — content,
# not structure, so a table that renders empty or wrong still fails this.
_DASHFLEXLAYOUT_FACTS = ("colorScheme", "useStateForModel", "supportsPopout")
_TAB_FACTS = ("children",)


def test_llms_txt_carries_the_prop_rows_not_just_the_heading(client):
    doc = client.get("/reference/llms.txt", user_agent=CRAWLER_UA)
    assert doc.status == 200
    text = doc.text
    assert "### DashFlexLayout" in text and "### Tab" in text, "headings alone prove nothing"
    for fact in _DASHFLEXLAYOUT_FACTS:
        assert fact in text, f"{fact!r} (a real DashFlexLayout prop) missing from /reference/llms.txt"
    for fact in _TAB_FACTS:
        assert fact in text, f"{fact!r} (a real Tab prop) missing from /reference/llms.txt"
    # The specific defect measured before the fix: the DashFlexLayout table
    # is entirely gone between the two headings.
    between = text.split("### DashFlexLayout", 1)[1].split("### Tab", 1)[0]
    assert "colorScheme" in between, "the DashFlexLayout table is empty between its own heading and Tab's"


def test_crawler_html_carries_the_same_rows_llms_txt_does(client):
    """Lane parity: the crawler document (a different dash-improve-my-llms
    surface from llms.txt, same underlying expanded markdown) must not
    disagree about what a page contains."""
    page = client.get("/reference", user_agent=CRAWLER_UA)
    assert page.status == 200
    for fact in _DASHFLEXLAYOUT_FACTS + _TAB_FACTS:
        assert fact in page.text, f"{fact!r} present in llms.txt but missing from the crawler HTML"


def test_the_expansion_is_a_real_dependency_not_a_coincidence(monkeypatch):
    """MUTATION CHECK (the drop's own test lesson): disable
    resolve_kwargs() — the ONE shared parse both lanes call — and confirm
    the machine-lane expansion actually goes empty. If this test fails to
    fail under the mutation, the pins above are checking something else."""
    import pages.markdown as markdown_page

    monkeypatch.setattr(markdown_page, "resolve_kwargs", lambda spec: [])

    content = (
        ".. kwargs::flexlayout_dash.DashFlexLayout\n\n"
        ".. kwargs::flexlayout_dash.Tab\n"
    )
    expanded = markdown_page._expand_kwargs_directives(content)
    assert "colorScheme" not in expanded, (
        "mutating resolve_kwargs to return [] should empty the table — "
        "the expansion is not actually calling it"
    )
    assert "resolved to no props" in expanded


def test_expansion_is_fence_aware():
    """A `.. kwargs::` line inside a fenced code block is a syntax example,
    not a directive — must not be expanded (the same rule
    _expand_source_directives already enforces)."""
    import pages.markdown as markdown_page

    content = "```markdown\n.. kwargs::flexlayout_dash.DashFlexLayout\n```\n"
    expanded = markdown_page._expand_kwargs_directives(content)
    assert expanded.strip() == content.strip()


def test_a_real_kwargs_directive_resolves_to_the_same_props_the_browser_sees():
    """ONE shared parse (the item's own requirement): the browser's Kwargs
    directive and the machine-lane expansion both call
    lib.directives.kwargs.resolve_kwargs — assert they resolve the SAME
    component spec to the SAME data, not merely that both return
    something."""
    from lib.directives.kwargs import resolve_kwargs

    browser_lane = resolve_kwargs("flexlayout_dash.DashFlexLayout")

    import pages.markdown as markdown_page

    expanded = markdown_page._expand_kwargs_directives(
        ".. kwargs::flexlayout_dash.DashFlexLayout\n"
    )
    for p in browser_lane:
        assert p["name"] in expanded, f"browser-lane prop {p['name']!r} missing from the machine-lane table"
