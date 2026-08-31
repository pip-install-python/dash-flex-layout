"""dimll 2.6.0's SEO honesty features, pinned from the app's side.

Two contracts land with the 2.6.0 floor:

1. **Icon discovery agrees with the declaration.** This app still declares
   `configure_seo(icons=[...])` explicitly (declared wins), but the fleet's
   satellites will increasingly rely on discovery alone — so the reference
   host proves the two produce the SAME set. Set-equality, not order: the
   release notes are explicit that discovery orders differently
   (.ico first, biggest square descending, apple-touch last) and that
   order-inequality is not a failure.

2. **The sitemap tells the truth or says nothing.** `<lastmod>` is emitted
   verbatim from frontmatter `lastmod:` and omitted when unset. No date in
   the sitemap may exist that no page declared — the invented daily "today"
   is the exact lie 2.6.0 exists to end.
"""

from __future__ import annotations

import re
from pathlib import Path


def _normalize(entries):
    """(rel, href, sizes) triples from the package's mixed icon shapes."""
    out = set()
    for e in entries:
        if isinstance(e, str):
            out.add(("icon", e, None))
        else:
            out.add((e.get("rel", "icon"), e["href"], e.get("sizes")))
    return out


def test_discovery_agrees_with_the_declared_icons(app):
    from dash_improve_my_llms.seo import _config, discover_icons

    declared = _normalize(_config.icons or [])
    discovered = _normalize(discover_icons(app))

    assert declared, "configure_seo(icons=) is no longer declared in run.py?"
    assert discovered, "discovery found nothing in assets/ — pattern drift?"
    assert declared == discovered, (
        "Declared and discovered icon sets diverged.\n"
        f"declared only:   {sorted(declared - discovered)}\n"
        f"discovered only: {sorted(discovered - declared)}\n"
        "If a favicon file was added/renamed, update run.py's icons list — "
        "or if discovery's patterns changed upstream, this is the canary."
    )


def test_every_declared_icon_resolves(client):
    """A head full of 404s looks fixed. This is the half discovery can't prove.

    THIS HOST DRAWS ITS OWN MARK, and its set is deliberately smaller than the
    template's eight-file realfavicongenerator layout: favicon.ico,
    favicon-192, favicon-512, apple-touch-icon. Copying the template's icon
    list verbatim — the failure another fork shipped — would publish five
    hrefs (android-chrome-*, favicon-16x16/32x32/96x96) that 404 here, while
    every offline test that only compares declarations to each other stayed
    green. So the declaration is checked against the SERVER, not against
    another list.
    """
    from dash_improve_my_llms.seo import _config

    broken = []
    for entry in _config.icons or []:
        href = entry if isinstance(entry, str) else entry["href"]
        response = client.get(href)
        if not response.ok:
            broken.append((href, response.status))
    assert broken == [], f"declared icons that do not resolve: {broken}"


def test_the_crawler_and_browser_heads_declare_the_same_icons(client):
    """Content may differ between the two documents; identity may not.

    Browsers read templates/index.html's links; crawlers read the ones
    configure_seo writes into the generated document. If those sets drift, the
    site shows one mark in a tab and another in search results — invisible
    from either side alone.
    """
    from dash_improve_my_llms.seo import _config

    template = (Path(__file__).resolve().parent.parent
                / "templates" / "index.html").read_text()
    live = re.sub(r"<!--.*?-->", "", template, flags=re.S)
    in_template = set(re.findall(r'<link[^>]+href="(/assets/favicon/[^"]+)"', live))
    declared = {e if isinstance(e, str) else e["href"] for e in (_config.icons or [])}

    # index.html links the manifest too, and Dash's {%favicon%} placeholder
    # supplies the .ico — neither is a configure_seo icon entry.
    in_template.discard("/assets/favicon/site.webmanifest")
    declared.discard("/assets/favicon/favicon.ico")

    assert in_template == declared, (
        "the browser head and the crawler head declare different icons\n"
        f"template only:  {sorted(in_template - declared)}\n"
        f"configure_seo only: {sorted(declared - in_template)}"
    )


def _declared_lastmods() -> set[str]:
    dates = set()
    for md in Path("docs").glob("**/*.md"):
        head = md.read_text().split("---")[1] if md.read_text().startswith("---") else ""
        m = re.search(r"^lastmod:\s*(\d{4}-\d{2}-\d{2})\s*$", head, re.MULTILINE)
        if m:
            dates.add(m.group(1))
    # /api's lastmod (item 18) is NOT frontmatter — it is the `generated`
    # stamp scripts/build_api_metadata.py writes to
    # flexlayout_dash/api_metadata.json, moved only when the extract that
    # actually regenerates /api's content runs. Same truth-or-silence rule,
    # different declaration site.
    from lib import api_reference
    from lib.constants import API_PACKAGES

    for pkg in API_PACKAGES:
        stamp = api_reference.slim_generated_on(pkg)
        if stamp:
            dates.add(stamp)
    # /changelog's lastmod (item 18) is the newest DATED release heading in
    # CHANGELOG.md — a third declaration site, moving only when a release
    # is actually dated by hand.
    from pages.changelog import newest_date

    changelog_date = newest_date()
    if changelog_date:
        dates.add(changelog_date)
    return dates


def test_sitemap_lastmod_is_verbatim_or_absent(client):
    sitemap = client.get("/sitemap.xml").text
    emitted = re.findall(r"<lastmod>([^<]+)</lastmod>", sitemap)
    declared = _declared_lastmods()

    assert emitted, (
        "No <lastmod> anywhere — the frontmatter stamps were removed? "
        "Truth-or-silence allows silence per page, but the docs set "
        "deliberately declares real dates."
    )
    undeclared = [d for d in emitted if d not in declared]
    assert not undeclared, (
        f"Sitemap emits dates nobody declared: {undeclared} — an invented "
        "date is the lie that gets the whole sitemap discarded."
    )

    # The home page declares no lastmod; its <url> entry must carry none.
    home_block = re.search(
        r"<url>\s*<loc>[^<]*?://[^/<]+/</loc>.*?</url>", sitemap, re.DOTALL
    )
    assert home_block and "<lastmod>" not in home_block.group(0), (
        "The home page's sitemap entry carries a lastmod it never declared."
    )


def test_apple_touch_icon_is_opaque():
    """iOS composites the icon's alpha onto ITS OWN background — black on
    some surfaces, white on others — so a transparent apple-touch icon
    renders differently everywhere it appears. This repo's generator is
    scripts/make_brand_assets.py (NOT the template's make_favicons.py — this
    host draws its own mark), and it already emits exactly this one file
    full-bleed as RGB while every other size keeps its alpha, which browsers
    and Android handle correctly. Verified against the committed bytes
    2026-08-22: colour type 2, nothing to flatten.

    Read the colour type straight out of the PNG header — stdlib only, no
    Pillow in the test environment. IHDR is always the first chunk: colour
    type is the byte at offset 25. 2 = RGB (opaque), 6 = RGBA. A palette
    PNG (3) can smuggle transparency back in through a tRNS chunk, so pin
    that absent too.
    """
    icon = (
        Path(__file__).resolve().parent.parent
        / "assets"
        / "favicon"
        / "apple-touch-icon.png"
    )
    data = icon.read_bytes()
    assert data[:8] == b"\x89PNG\r\n\x1a\n", "not a PNG?"
    colour_type = data[25]
    assert colour_type in (0, 2, 3), (
        f"apple-touch-icon.png has colour type {colour_type} (an alpha "
        "channel) — regenerate the set with scripts/make_brand_assets.py, "
        "which emits this one icon full-bleed as RGB."
    )
    assert b"tRNS" not in data, (
        "apple-touch-icon.png carries a tRNS transparency chunk — iOS will "
        "composite it onto an unpredictable background."
    )
