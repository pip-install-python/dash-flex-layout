"""The a11y / agentic block — 1.6.44 item 6, sub-items (a) to (g).

Each test names its sub-item. THREE of the seven are RECORDED rather than
fixed, and say so here as well as in DIVERGENCES.md, because a sub-item that
quietly disappears from a checklist is indistinguishable from one that was
done:

(d) the mobile console error seen on leaflet/llms/pannellum — NOT ASSESSED on
    this host. The seat that built this item has no browser, so neither
    "reproduced" nor "not reproduced" would be an honest word. Recorded as
    open in DIVERGENCES 22, not silently closed;
(e) shipped CSS/JS minified — NOT minified, and deliberately. MEASURED on
    this host's wire: `content-encoding: gzip`, and the whole of assets/*.css
    + assets/*.js is 34,235 bytes of text that gzips to 10,337. An
    unminified stylesheet is also the one a fork reads when it forks;
(f) the intrinsic-size machinery is NOT ported, because this fork ships ZERO
    content images. The pin that Dash still rejects the lazy-loading
    attributes IS ported — that one guards a future edit rather than a
    current corpus — and a tripwire below fails the day an image appears.

Everything else is asserted.
"""
from __future__ import annotations

import re

from conftest import REPO_ROOT

CSS = (REPO_ROOT / "assets" / "main.css").read_text()


def code(path) -> str:
    """A Python file with its comments removed.

    Item 13's rule, and this file needs it: a detect that reads prose about a
    defect is a detect on prose. The comment beside the fix in header.py
    names `trigger="hover"` while the code does the opposite.
    """
    return "\n".join(
        line for line in path.read_text().splitlines()
        if not line.lstrip().startswith("#")
    )


# ------------------------------------------------------------------- (a) --


def test_the_other_apps_menu_target_is_a_real_button():
    """A div with aria-haspopup is not a control; a Button is."""
    block = code(REPO_ROOT / "components" / "header.py").split(
        "def create_other_apps_menu", 1)[1]
    assert "dmc.MenuTarget(" in block and "dmc.Button(" in block, (
        "the menu target is not a real button element"
    )
    assert "aria-haspopup" not in block, (
        "a hand-written aria-haspopup means the target is standing in for a "
        "control rather than being one"
    )


def test_the_other_apps_menu_opens_without_a_pointer():
    """`trigger="hover"` made the only listing of the network mouse-only."""
    block = code(REPO_ROOT / "components" / "header.py").split(
        "def create_other_apps_menu", 1)[1]
    assert 'trigger="click-hover"' in block, (
        "the menu opens on hover alone — focus it and press Enter and nothing "
        "happens, and a touch screen has no hover at all"
    )


# ------------------------------------------------------------------- (b) --


def test_prose_links_do_not_rely_on_colour_alone():
    """WCAG 1.4.1. The global Anchor default is underline-on-hover, which is
    right for chrome and wrong inside running text."""
    block = re.search(r"#main-content p a[^{]*\{([^}]*)\}", CSS)
    assert block, "no prose-link rule scoped to #main-content"
    assert "text-decoration: underline" in block.group(1)


def test_the_chrome_keeps_its_hover_underline():
    """The fix must be scoped: underlining every anchor would put a rule
    under the nav rows and the footer icons."""
    appshell = (REPO_ROOT / "components" / "appshell.py").read_text()
    assert '"underline": "hover"' in appshell
    assert "\na {\n    text-decoration: underline" not in CSS, (
        "a global anchor underline would repaint the chrome too"
    )


# ------------------------------------------------------------------- (c) --


def test_touch_targets_reach_44px_at_phone_width():
    """iOS/Android minimum. A Mantine ActionIcon size="lg" is 34px, and the
    header and footer are made of them."""
    phone = [b for b in re.findall(r"@media[^{]*\{(.*?)\n\}", CSS, re.S)
             if "max-width: 750px" in CSS[:CSS.index(b)][-120:]]
    assert phone, "no phone-width media block in main.css"
    icons = [b for b in phone if "ActionIcon" in b]
    assert icons, "no phone-width rule widens the icon controls"
    assert "min-width: 44px" in icons[0] and "min-height: 44px" in icons[0]


def test_the_mobile_drawer_rows_still_meet_the_minimum():
    """The rule this one was modelled on — a regression here is the same bug."""
    assert ".mobile-nav .navbar-link" in CSS
    row = CSS.split(".mobile-nav .navbar-link", 1)[1].split("}", 1)[0]
    assert "min-height: 44px" in row


# ------------------------------------------------------------------- (f) --


def test_dash_still_rejects_the_lazy_loading_attributes():
    """Why the renderer does not defer the load, pinned to the reason.

    `loading` and `decoding` are not props of dash's html.Img — passing
    either RAISES at render (196 collection errors on the template, not a
    soft warning). If a future Dash adds them, this test goes red and the
    renderer can have them.
    """
    from dash import html

    props = html.Img()._prop_names
    assert "width" in props and "height" in props
    assert "loading" not in props and "decoding" not in props, (
        "Dash learned the lazy-loading attributes — the image renderer can "
        "now defer the load; add them back and delete this test"
    )


def test_the_image_renderer_still_caps_the_box():
    """What this fork's renderer DOES do, so the absence of the size reader
    is a recorded decision rather than an unnoticed gap."""
    block = code(REPO_ROOT / "lib" / "directives" / "headings.py").split(
        "def image(self", 1)[1].split("m2d_renderer", 1)[0]
    assert '"maxWidth": "100%"' in block, (
        "the renderer stopped capping the box — an oversized content image "
        "would now overflow the column"
    )


def test_the_content_image_corpus_is_still_empty():
    """THE TRIPWIRE for sub-item (f), and the honest form of note 88.

    The template ports `_intrinsic_size` / `_size_from_header` so a content
    image reserves its box and the prose under it does not jump. This fork
    ships NO content images, so that machinery would be dead code here and
    the template's own non-vacuity test ("no content images anywhere — (f)
    swept nothing") would fail on this tree.

    Recording the emptiness is the useful move: the day someone adds an
    image, this goes red and points at the item to port, instead of the
    layout shift shipping unnoticed.
    """
    images = []
    for path in list(REPO_ROOT.glob("pages/*.md")) + list(REPO_ROOT.glob("docs/**/*.md")):
        images += re.findall(r"!\[[^\]]*\]\(([^)]+)\)", path.read_text())

    assert images == [], (
        f"this fork now ships {len(images)} content image(s): {images[:3]}. "
        "Sub-item 6(f) is no longer not-applicable — port _intrinsic_size / "
        "_size_from_header from the template and delete this tripwire."
    )


# ------------------------------------------------------------------- (g) --


def test_assets_get_a_cache_lifetime_and_documents_do_not():
    from lib.static_cache import ASSET_CACHE_CONTROL, cache_control_for

    assert cache_control_for("/assets/main.css") == ASSET_CACHE_CONTROL
    assert "max-age=3600" in ASSET_CACHE_CONTROL
    for document in ("/", "/basic", "/llms.txt", "/healthz",
                     "/admin/traffic", "/api/pages",
                     "/_dash-component-suites/dash/x.js"):
        assert cache_control_for(document) is None, (
            f"{document} is an answer about right now — it must keep "
            "revalidating"
        )


def test_the_flask_lane_applies_the_policy_from_that_one_place():
    """One lane here (DIVERGENCES 2 — this fork is Flask-only), so there is
    no second lane to drift from. The policy still lives in its own module
    rather than inline at the seam."""
    src = code(REPO_ROOT / "run.py")
    assert "from lib.static_cache import cache_control_for" in src
    assert "Cache-Control" in src


def test_the_lifetime_actually_reaches_a_response(client):
    """Through the real app, not just the pure function.

    A policy module nothing calls is the shape this test exists to refuse.
    """
    def cache_control(response):
        # conftest's Client lower-cases header names; the wire does not
        # promise either casing, so read it insensitively.
        return {k.lower(): v for k, v in response.headers.items()}.get(
            "cache-control")

    css = client.get("/assets/main.css", user_agent="curl/8 2plot-internal/probe")
    assert css.status == 200
    assert cache_control(css) == (
        "public, max-age=3600, stale-while-revalidate=86400")

    doc = client.get("/healthz", user_agent="curl/8 2plot-internal/probe")
    assert cache_control(doc) is None, "a document was given an asset lifetime"
