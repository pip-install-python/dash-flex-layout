"""The network's UI standard, pinned where it can actually fail.

Three rules arrived with the gate wave, and each one has taken a real host
down or degraded it silently:

1. **Never ``title=`` on a DMC component.** DMC 2.8's ActionIcon and Anchor
   accept ``aria-*`` wildcards but REJECT ``title``, raising TypeError DURING
   APP CONSTRUCTION — so the whole site fails to boot rather than rendering a
   wrong tooltip. It looks like the obvious way to add a hover hint, which is
   exactly why it needs a test rather than a comment. (``dmc.Alert(title=)``
   and ``dmc.Modal(title=)`` are different animals: ``title`` is a documented
   Mantine prop on those, the heading, not the HTML attribute. The check below
   is scoped to the components that reject it.)

2. **Every icon-only control needs an accessible name.** A control whose only
   child is an icon has no text for a screen reader to announce, and none for
   an agent driving the page to identify it by — both get "button". Mantine
   adds no name of its own, including on ``Burger``.

3. **The header height is one number.** ``lib.constants.HEADER_HEIGHT`` feeds
   the AppShell, the header's own Group, and the mobile drawer, which docks
   itself directly below the header. A drawer that disagrees with the real
   header either floats over it or leaves a dead band at the bottom.

These walk the REAL layout tree rather than the source text: a regex over
source can't tell a live call from one inside a comment or a docstring, and
this file's own prose names every construct it forbids.
"""

from __future__ import annotations

import dash_mantine_components as dmc
import pytest

from lib.constants import HEADER_HEIGHT

# The components measured to reject `title=` at construction on DMC 2.8.
TITLE_REJECTING = ("ActionIcon", "Anchor")

# Components that render no text of their own when their children are icons.
ICON_ONLY_CANDIDATES = ("ActionIcon", "Burger")


def _walk(node):
    """Every component instance in a Dash layout tree, depth first."""
    yield node
    children = getattr(node, "children", None)
    if children is None:
        return
    if not isinstance(children, (list, tuple)):
        children = [children]
    for child in children:
        if hasattr(child, "_type") or hasattr(child, "children"):
            yield from _walk(child)


def _text_of(node) -> str:
    """Concatenated string content beneath ``node``."""
    out = []
    for item in _walk(node):
        children = getattr(item, "children", None)
        if isinstance(children, str):
            out.append(children)
        elif isinstance(children, (list, tuple)):
            out.extend(c for c in children if isinstance(c, str))
    return " ".join(out).strip()


def _accessible_name(node) -> str:
    for attr in ("aria-label", "aria_label"):
        value = getattr(node, attr, None) or (
            node.to_plotly_json().get("props", {}).get(attr)
            if hasattr(node, "to_plotly_json") else None
        )
        if value:
            return str(value)
    return ""


@pytest.mark.parametrize("component", TITLE_REJECTING)
def test_the_title_prop_really_is_a_boot_killer(component):
    """The premise of rule 1, verified against the installed DMC.

    If a future DMC release starts accepting `title=`, this fails and the rule
    below can be relaxed deliberately instead of quietly rotting into a
    superstition nobody can justify.
    """
    with pytest.raises(TypeError):
        kwargs = {"title": "a tooltip"}
        if component == "Anchor":
            kwargs["href"] = "/"
        getattr(dmc, component)("x", **kwargs)


def test_no_title_prop_reaches_a_component_that_rejects_it(app):
    """Rule 1, over the whole rendered layout.

    Construction already succeeded to get here — which is the point: a page
    built lazily (a callback's return, a gate card rendered only for anonymous
    visitors) would not have been constructed at import time, and the crash
    would land on a visitor instead of on CI.
    """
    offenders = []
    for node in _walk(app.layout):
        name = type(node).__name__
        if name in TITLE_REJECTING:
            props = node.to_plotly_json().get("props", {})
            if "title" in props:
                offenders.append(f"dmc.{name}(id={props.get('id', '-')})")
    assert offenders == [], (
        f"`title=` passed to components that reject it: {offenders}. "
        "Use aria-label for the accessible name and dmc.Tooltip for hover text."
    )


def test_every_icon_only_control_has_an_accessible_name(app):
    """Rule 2, over the whole rendered layout."""
    unnamed = []
    for node in _walk(app.layout):
        name = type(node).__name__
        if name not in ICON_ONLY_CANDIDATES:
            continue
        if _text_of(node):
            continue  # it announces itself
        if _accessible_name(node):
            continue
        props = node.to_plotly_json().get("props", {})
        unnamed.append(f"dmc.{name}(id={props.get('id', '-')})")
    assert unnamed == [], (
        f"icon-only controls with no accessible name: {unnamed}. A screen "
        "reader and an agent both announce these as just 'button'."
    )


def test_the_home_anchor_is_named_even_when_the_wordmark_is_hidden(app):
    """The trap that is specific to `visibleFrom`.

    `visibleFrom`/`hiddenFrom` are `display:none` media queries: the node stays
    in the DOM (so JS and animations keep working) but LEAVES the accessibility
    tree. The header's wordmark is `visibleFrom="xs"`, so below that breakpoint
    the home link's only content is a decorative glyph — the anchor must carry
    its own name or it has none at all on a phone. Two forks derived this
    incorrectly before it was written down.
    """
    home_anchors = [
        node for node in _walk(app.layout)
        if type(node).__name__ == "Anchor"
        and node.to_plotly_json().get("props", {}).get("href") == "/"
        and any(
            getattr(inner, "to_plotly_json", lambda: {})().get("props", {}).get("visibleFrom")
            for inner in _walk(node)
        )
    ]
    assert home_anchors, "no header home anchor with a breakpoint-hidden wordmark found"
    for anchor in home_anchors:
        assert _accessible_name(anchor), (
            "the header home link hides its wordmark at a breakpoint and "
            "carries no aria-label — it has no accessible name on a phone"
        )


def test_the_header_height_is_one_number(app):
    """Rule 3: the AppShell, the header Group and the drawer must agree."""
    shells = [n for n in _walk(app.layout) if type(n).__name__ == "AppShell"]
    assert shells, "no AppShell in the layout"
    header = shells[0].to_plotly_json()["props"].get("header") or {}
    assert header.get("height") == HEADER_HEIGHT, (
        f"AppShell(header.height)={header.get('height')} but "
        f"HEADER_HEIGHT={HEADER_HEIGHT} — the mobile drawer docks itself "
        "against the constant, so a mismatch leaves a dead band or overlaps"
    )

    drawers = [n for n in _walk(app.layout) if type(n).__name__ == "Drawer"]
    assert drawers, "no mobile navigation Drawer in the layout"
    styles = drawers[0].to_plotly_json()["props"].get("styles") or {}
    assert styles.get("inner", {}).get("top") == HEADER_HEIGHT, (
        "the mobile drawer does not dock at HEADER_HEIGHT"
    )
    assert styles.get("overlay", {}).get("top") == HEADER_HEIGHT, (
        "the drawer overlay covers the header, so the hamburger that opens it "
        "cannot be tapped to close it"
    )


def test_the_mobile_drawer_is_the_docked_shape_not_a_floating_card(app):
    """What the dash-mantine-components>=2.8.0 floor buys.

    Below 2.8 these identical props render as a floating card. The props are
    still the contract: no close-button header row, square corners, and a body
    with a definite height so the nav can scroll inside it.
    """
    drawers = [n for n in _walk(app.layout) if type(n).__name__ == "Drawer"]
    props = drawers[0].to_plotly_json()["props"]
    assert props.get("withCloseButton") is False, "the drawer keeps its header row"
    content = (props.get("styles") or {}).get("content", {})
    assert content.get("borderRadius") == 0, "the drawer still has card corners"
    body = (props.get("styles") or {}).get("body", {})
    assert body.get("minHeight") == 0 and body.get("height") == "100%", (
        "the drawer body has no definite height, so its ScrollArea cannot scroll"
    )
