"""Site identity: one brand, every surface, verbatim.

The network standard says a site states what it is in the same words
everywhere an agent or a reader can reach. The failure this pins is silent,
which is why it needs tests rather than a code review: nothing errors when a
surface falls back to a default. On this host, before `SITE_BRAND` existed,
the llms viewer's brand chip read a bare **"Dash"** and the root /llms.txt H1
read **"# Home"** — the home page's nav label, leaking out as the public
identity of the site.

dash-improve-my-llms 2.3.4's `resolve_site_title` is what makes the fix
possible: it takes the home page's registered `name` first, `app.title`
second, and *skips* generic candidates ("Home", "Index", "Dash") rather than
publishing them. These tests assert both ends of that — the inputs this repo
controls, and the H1 it produces.
"""

from __future__ import annotations

import re

from conftest import REPO_ROOT
from lib.constants import (
    PAGE_TITLE_PREFIX,
    SITE_BRAND,
    SITE_DESCRIPTION,
    SITE_SHORT_NAME,
)

# Spelled out rather than imported, so that renaming the constant cannot
# silently rename the site. Changing the brand should require changing this
# line, deliberately.
EXPECTED_BRAND = "flexlayout-dash — resizable panel layouts for Dash"

HOME_MD = REPO_ROOT / "docs" / "home" / "home.md"


def test_brand_constant_is_the_agreed_identity():
    assert SITE_BRAND == EXPECTED_BRAND


def test_app_title_is_the_brand(app):
    """`Dash(title=...)` — the <title> and `resolve_site_title`'s fallback."""
    assert app.title == EXPECTED_BRAND


def test_home_prose_opens_with_the_brand():
    """The first H1 in docs/home/home.md (frontmatter and directives precede it)."""
    h1 = next(
        (line for line in HOME_MD.read_text().splitlines() if line.startswith("# ")),
        "",
    )
    assert h1 == f"# {EXPECTED_BRAND}"


def test_llms_index_h1_is_the_brand(client):
    """The single most-read line of this site, and the one nobody looks at."""
    response = client.get("/llms.txt")
    assert response.ok
    assert response.text.splitlines()[0] == f"# {EXPECTED_BRAND}"


def test_llms_index_tagline_is_the_description(client):
    body = client.get("/llms.txt").text
    assert f"> {SITE_DESCRIPTION}" in body


def test_the_viewer_brand_chip_is_not_a_framework_default(client):
    """The chip that read "Dash" on the pre-standard artifact.

    It is rendered from the same `resolve_site_title` call as the H1, so
    asserting the brand is present and the default is absent catches both a
    stale package and a regressed constant.
    """
    import html as html_module

    from conftest import BROWSER_ACCEPT

    page = client.get("/basic/llms.txt", accept=BROWSER_ACCEPT).text
    assert html_module.escape(EXPECTED_BRAND) in page, (
        "the viewer banner does not name this site"
    )


def test_the_byline_is_in_the_description_not_the_brand():
    """Naming rules from the standard.

    The brand says what the site *is*; the PyPI package name and the byline
    belong in the description. A brand of "Pip Install Python" would make
    every satellite in the network share one name. (Network convention puts
    the import-style name first in the brand — `dash-leaflet2 — …`,
    `flexlayout-dash — …` — so the package appearing there too is expected.)
    """
    assert "flexlayout-dash" in SITE_DESCRIPTION
    assert "Pip Install Python" in SITE_DESCRIPTION
    assert "Pip Install Python" not in SITE_BRAND


def test_no_surface_falls_back_to_a_generic_title():
    """The values `resolve_site_title` is designed to skip.

    If the brand were ever set to one of these, the package would silently
    fall through to the next candidate and this repo would have no idea which
    string it was publishing.
    """
    from dash_improve_my_llms.handlers import _GENERIC_SITE_TITLES

    assert SITE_BRAND.strip().lower() not in _GENERIC_SITE_TITLES


def test_readme_and_docs_agree_with_the_brand():
    """A README that names the site differently is the next drift."""
    readme = (REPO_ROOT / "README.md").read_text()
    assert EXPECTED_BRAND in readme, "README.md does not state the site brand"


def test_llms_package_floor_is_the_network_standard():
    """Identity resolution lives in the package; the floor is what delivers it."""
    import dash_improve_my_llms as pkg

    parts = tuple(int(p) for p in pkg.__version__.split(".")[:3] if p.isdigit())
    assert parts >= (2, 3, 4), (
        f"dash-improve-my-llms {pkg.__version__} predates resolve_site_title; "
        "the viewer chip and the /llms.txt H1 would fall back to app.title"
    )


# ---------------------------------------------------------------------------
# The per-page title — a share-card surface, not just a browser tab
#
# Dash passes each page's `title` straight into `og:title` and `twitter:title`
# (dash/_pages.py `_page_meta_tags`). PAGE_TITLE_PREFIX therefore sets the
# headline of every unfurl this site produces. Nobody sees their own share
# cards, so only a test catches it drifting to another site's name.
# ---------------------------------------------------------------------------


def test_the_page_title_prefix_is_this_site():
    assert PAGE_TITLE_PREFIX == f"{SITE_SHORT_NAME} | "


def test_the_short_name_cannot_drift_from_the_brand():
    """Two constants, one identity. Derived, so this should be automatic."""
    assert SITE_BRAND.startswith(SITE_SHORT_NAME)


def test_the_share_card_headline_names_this_site(client):
    """og:title and twitter:title, as a scraper reads them."""
    html = client.get("/").text
    for tag in ("og:title", "twitter:title"):
        found = re.findall(
            rf'<meta[^>]*property="{tag}"[^>]*content="([^"]*)"', html
        )
        assert found, f"no {tag} on the home page"
        for value in found:
            assert SITE_SHORT_NAME in value, f"{tag}={value!r} does not name this site"


def test_no_surface_still_carries_another_sites_brand():
    """A sweep for the two identities this repo could plausibly leak.

    The favicon set arrived carrying the HUB's webmanifest ("2plot.dev — Dash
    Components Documentation") — the string an install prompt would have shown
    on someone's phone. And the docs stack is adapted from the documentation
    boilerplate, whose brand is the other candidate. Comments explaining the
    fix are the one legitimate mention, so they are stripped first.
    """
    offenders = []
    for path in ("lib/constants.py", "templates/index.html",
                 "docs/home/home.md", "assets/favicon/site.webmanifest"):
        text = (REPO_ROOT / path).read_text()
        stripped = re.sub(r"#.*", "", text) if path.endswith(".py") else text
        stripped = re.sub(r"<!--.*?-->", "", stripped, flags=re.S)
        for foreign in ("Dash Documentation Boilerplate",
                        "Dash Components Documentation"):
            if foreign in stripped:
                offenders.append(f"{path}: {foreign}")
    assert offenders == [], f"another site's brand survives in {offenders}"
