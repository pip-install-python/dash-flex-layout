"""Admin pages hide from BOTH audiences — the llms-2plot-dev footgun, kept.

Before item 16, a path hidden from the sidebar (then a hand-typed
`excluded_links` list in components/navbar.py) stayed in sitemap.xml,
/llms.txt, the tier corpora, MCP and the prerender; a fork "hid" a page
from its own nav while still publishing it to every crawler. Item 16
deleted `excluded_links` (the sidebar is built from frontmatter now) —
what remains hidden-by-rule is `/admin/*`, and this suite pins the
parity from both ends: the mechanism (every admin path is in dimll's
hidden state) and the surfaces (none appears in the sitemap or
/llms.txt, none in the sidebar tree, while a control page does — so an
empty sitemap can never pass this vacuously).
"""

from __future__ import annotations


def _admin_paths():
    import dash

    return [p["path"] for p in dash.page_registry.values() if p["path"].startswith("/admin/")]


def test_every_admin_path_is_machine_hidden(app):
    from dash_improve_my_llms import is_hidden

    paths = _admin_paths()
    assert paths, "no admin pages registered — the pin would be vacuous"
    not_hidden = [p for p in paths if not is_hidden(p)]
    assert not_hidden == [], (
        f"in the app but NOT hidden from the machine surfaces: {not_hidden} — "
        "the page's mark_hidden wiring is broken or was removed"
    )


def test_admin_paths_absent_from_sitemap_llms_and_sidebar(client, app):
    """The corpus sweep covers the TIER DOCS too (item 18 amendment):
    /llms-small.txt and /llms-full.txt are their own index documents, not
    derived from /llms.txt, so a leak into either would slip past a
    sweep that only reads the root index — a page's prose can leak a
    link to a hidden page (hyperlinking it from elsewhere) even when
    every structural pin (navbar, sitemap) passes. Both clauses are
    LINK-shaped: the same `(path)` / `path/llms.txt` check the root
    index gets, not a bare substring — an admin path could otherwise
    appear inside an UNRELATED word and false-positive."""
    import dash

    from components.navbar import create_content

    sitemap = client.get("/sitemap.xml").text
    llms = client.get("/llms.txt").text
    llms_small = client.get("/llms-small.txt").text
    llms_full = client.get("/llms-full.txt").text
    tree = str(create_content(dash.page_registry.values()))

    def link_leaked(path: str, doc: str) -> bool:
        return f"{path})" in doc or f"{path}/llms.txt" in doc

    leaked = []
    for path in _admin_paths():
        if f"{path}</loc>" in sitemap:
            leaked.append(f"{path} in sitemap.xml")
        if link_leaked(path, llms):
            leaked.append(f"{path} in /llms.txt")
        if link_leaked(path, llms_small):
            leaked.append(f"{path} in /llms-small.txt")
        if link_leaked(path, llms_full):
            leaked.append(f"{path} in /llms-full.txt")
        if path in tree:
            leaked.append(f"{path} in the startup sidebar tree")
    assert leaked == [], f"admin pages published: {leaked}"

    # Positive control: a real page IS listed, so an empty sitemap or a
    # broken llms.txt cannot make the assertions above pass vacuously.
    assert "/getting-started</loc>" in sitemap
    assert "/getting-started" in llms
    assert "/getting-started" in tree
    assert link_leaked("/getting-started", llms_small) or link_leaked("/getting-started", llms_full), (
        "neither tier doc links a single real page — the positive control "
        "would let a broken tier doc pass this test vacuously"
    )
