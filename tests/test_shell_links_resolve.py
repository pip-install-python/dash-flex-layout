"""Every internal link in the app shell resolves to a REGISTERED page.

1.6.44 item 11, from pipdocs f5ec42f: `/terms` and `/privacy` were linked
from every page in the fleet's footer and served nothing. They did not show
up as 404s because Dash answers 200 for ANY path — the server returns the
app shell and the client-side router decides what to render — so a status
sweep over the site cannot see a broken internal link. It reports 200 and
moves on.

The detect therefore has to be REGISTRATION, not a request: walk the shell's
internal hrefs and hold each one against `dash.page_registry`. That is a
question only the layout can answer, which is also why curl cannot ask it
(the shell is built by React from `app.layout`, so the served HTML does not
contain these links at all — the same reason a `curl | grep skip-link`
returns zero on a host whose skip link works).

THIS FORK IS FLASK-ONLY (DIVERGENCES 2). The template whitelists `/docs` and
`/redoc` per LANE because they exist only on FastAPI; here there is no such
lane and no OpenAPI badge, so those paths are NOT whitelisted at all. A
blanket entry would let a link to either ship a soft 404 on this host and
still pass — the exact defect the item exists to catch.
"""
from __future__ import annotations

import pytest
from dash.development.base_component import Component

# Paths served by something other than a registered page: the package's own
# routes and this app's native ones. Each is a real URL with a real handler,
# just not a Dash page.
NON_PAGE_ROUTES = {
    "/llms.txt", "/llms-small.txt", "/llms-full.txt",
    "/robots.txt", "/sitemap.xml", "/healthz",
    "/api/agent-key", "/api/pageview",
}


def _hrefs(node, out: list) -> None:
    """Every `href` in the tree, depth-first."""
    if isinstance(node, (list, tuple)):
        for child in node:
            _hrefs(child, out)
        return
    if not isinstance(node, Component):
        return
    href = getattr(node, "href", None)
    if isinstance(href, str):
        out.append(href)
    children = getattr(node, "children", None)
    if children is not None:
        _hrefs(children, out)


def _internal(href: str) -> bool:
    if not href.startswith("/"):
        return False          # external, a mailto:, or an in-page anchor
    return not href.startswith("//")


def _norm(path: str) -> str:
    return path.split("#")[0].split("?")[0].rstrip("/") or "/"


@pytest.fixture(scope="module")
def shell(app_module):
    """The app shell EXACTLY as run.py builds it.

    `create_appshell(dash.page_registry.values())` is the literal expression
    at run.py's `app.layout =`, so this walks header, navbar, mobile drawer
    and footer together rather than a hand-picked pair — the artifact the
    claim is about.
    """
    import dash

    from components.appshell import create_appshell

    return create_appshell(dash.page_registry.values())


@pytest.fixture(scope="module")
def registered(app_module):
    import dash

    return {entry["path"] for entry in dash.page_registry.values()}


def test_the_registry_is_populated(registered):
    """Note 88: an empty registry would make every assertion below green."""
    print(f"registry: {len(registered)} page(s)")
    assert len(registered) >= 5, f"only {len(registered)} pages registered"


def test_the_walk_finds_links_at_all(shell):
    """And a shell with no links would do the same."""
    found = []
    _hrefs(shell, found)
    internal = [h for h in found if _internal(h)]
    print(f"shell hrefs: {len(found)} total, {len(internal)} internal")
    assert found, "the walk found no hrefs anywhere in the shell"
    assert internal, (
        f"the shell has {len(found)} hrefs and none are internal — the walk "
        "is looking at the wrong tree"
    )


def test_every_internal_shell_link_is_a_registered_page(shell, registered):
    """Item 11. A soft 404 advertised from every page is still a soft 404."""
    found = []
    _hrefs(shell, found)
    internal = {_norm(h) for h in found if _internal(h)}
    known = {_norm(p) for p in registered} | {_norm(p) for p in NON_PAGE_ROUTES}
    unserved = sorted(internal - known)
    assert unserved == [], (
        f"the app shell links to {len(unserved)} path(s) nothing serves: "
        f"{unserved} — Dash answers 200 for these and renders nothing"
    )


def test_the_check_goes_red_when_a_link_points_at_nothing(registered):
    """The mutation, as a test rather than as a claim in a commit message.

    A guard that has never been shown to fail is a guard nobody has tested.
    """
    import dash_mantine_components as dmc

    broken = dmc.Anchor("Terms", href="/terms-that-nobody-registered")
    found = []
    _hrefs(broken, found)
    internal = {_norm(h) for h in found if _internal(h)}
    known = {_norm(p) for p in registered} | {_norm(p) for p in NON_PAGE_ROUTES}
    assert internal - known == {"/terms-that-nobody-registered"}, (
        "the walk cannot see a broken link, so its green means nothing"
    )


def test_no_openapi_paths_are_linked_on_this_flask_only_host():
    """The whitelist's own guard, inverted for a fork with no ASGI lane.

    `/docs` and `/redoc` are FastAPI-only. This host has neither, so nothing
    in the shell may link to them — and because Dash answers 200 for both,
    such a link would be invisible to every status sweep. Asserted rather
    than whitelisted, which is the difference between recording a lane and
    excusing one.
    """
    import dash

    from components.appshell import create_appshell

    found = []
    _hrefs(create_appshell(dash.page_registry.values()), found)
    linked = {_norm(h) for h in found if _internal(h)}
    assert not (linked & {"/docs", "/redoc"}), (
        "this Flask-only host advertises an OpenAPI path it does not serve"
    )
