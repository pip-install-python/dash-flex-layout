#!/usr/bin/env python3
"""Render this site's favicon set and web app manifest from one drawn mark.

    python scripts/make_brand_assets.py            # regenerate everything
    python scripts/make_brand_assets.py --check    # verify, change nothing

WHY A SCRIPT AND NOT A ONE-OFF EXPORT
-------------------------------------
tests/test_social_card.py pins a whole installable-app surface — the manifest
names the site, every icon it declares resolves, the apple-touch-icon
resolves, and the theme colour agrees with the manifest. Four files and a JSON
document have to stay consistent with `lib/constants.py` and with each other.
Hand-exported icons drift the first time the brand changes and nobody notices,
because a wrong manifest produces no error: the browser simply declines to
offer an install. (This is dash-emoji-mart's `make_brand_assets.py` pattern.)

THE MARK
--------
Drawn here rather than loaded from a source file: a dark rounded tile holding
three indigo dock panels — a left sidebar, a main panel wearing a tab, and a
bottom panel. It is the layout the component actually produces, in the site's
own palette (Mantine indigo on the #1a1b1e surface the card and the manifest
already use). The favicon set that shipped before this was the generic
pip-install-python package box, which said nothing about THIS project.

Pillow is a build-time dependency only, deliberately absent from
requirements.txt: nothing at runtime renders images.
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

OUT_DIR = REPO_ROOT / "assets" / "favicon"

# The palette. TILE is the dark surface everything in this brand renders on —
# site.webmanifest's background_color and the social card's backdrop. The
# panel colours are Mantine indigo shades 8/6/4, anchored on indigo-6 #4c6ef5,
# which is templates/index.html's theme-color and the manifest's theme_color;
# tests/test_social_card.py pins that pair.
TILE = (26, 27, 30, 255)          # #1a1b1e
INDIGO_DEEP = (59, 91, 219, 255)  # #3b5bdb — the sidebar
INDIGO_MAIN = (76, 110, 245, 255) # #4c6ef5 — the tabbed main panel
INDIGO_SOFT = (116, 143, 252, 255)  # #748ffc — the bottom panel
SLATE_DIM = (52, 58, 84, 255)     # an unselected tab: present, not competing
THEME_COLOR = "#4c6ef5"
BACKGROUND_COLOR = "#1a1b1e"

# PNG icons the manifest declares. 192 and 512 are the two sizes Chrome
# requires before it will offer an install prompt at all.
PNG_SIZES = (192, 512)

# iOS ignores the manifest entirely and uses this. It also composites onto a
# WHITE background if the image has alpha, so this one is drawn full-bleed and
# emitted as RGB — iOS applies its own corner mask.
APPLE_SIZE = 180

# .ico carries several sizes in one file; browsers pick. 48 is for Windows
# taskbar pinning, 16/32 are the tab.
ICO_SIZES = (16, 32, 48)

# Everything is drawn once on this canvas and LANCZOS-downscaled per target —
# ImageDraw has no antialiasing of its own, so the smoothing comes entirely
# from the downscale ratio (2048 -> 512 is 4x even at the largest target).
MASTER = 2048


# Pillow is imported INSIDE the render path, not here: `--check` only compares
# a JSON document and stats files, and the suite runs where Pillow is absent
# (it is deliberately not in requirements.txt).
def _pillow():
    try:
        from PIL import Image, ImageDraw
    except ImportError:  # pragma: no cover - the one dependency, named clearly
        sys.exit("This script needs Pillow:\n    pip install Pillow")
    return Image, ImageDraw


def _draw_mark(opaque: bool):
    """The dock mark on the MASTER canvas.

    `opaque=False` — the tile is a rounded square, transparent outside its
    corners: the tab-icon and manifest form. `opaque=True` — the tile bleeds
    to every edge with no alpha anywhere: the apple-touch form.
    """
    Image, ImageDraw = _pillow()
    s = MASTER
    img = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    if opaque:
        d.rectangle([0, 0, s, s], fill=TILE)
        margin = 0.17 * s  # iOS crops nothing but masks corners; inset a touch
    else:
        d.rounded_rectangle([0, 0, s - 1, s - 1], radius=int(0.22 * s), fill=TILE)
        margin = 0.15 * s

    x0 = y0 = margin
    x1 = y1 = s - margin
    w, h = x1 - x0, y1 - y0
    gutter = 0.055 * s          # the splitters: the tile showing through
    r = int(0.045 * s)          # panel corner radius

    # Left sidebar, full height.
    left_w = 0.32 * w
    d.rounded_rectangle([x0, y0, x0 + left_w, y1], radius=r, fill=INDIGO_DEEP)

    rx0 = x0 + left_w + gutter

    # The active tab, merged seamlessly into the main panel below it: it
    # overshoots the panel's top edge, and the panel's fill covers the
    # overlap — same colour, so the two read as one tabbed window. Tabs get a
    # flatter radius than panels or they render as pills at icon sizes.
    tab_h = 0.14 * h
    tab_w = 0.40 * (x1 - rx0)
    rt = int(0.025 * s)
    d.rounded_rectangle([rx0, y0, rx0 + tab_w, y0 + tab_h + rt],
                        radius=rt, fill=INDIGO_MAIN)

    # A second, unselected tab beside it — one notch reads as a folder icon;
    # a tab BAR is the component's identity. It floats on the strip without
    # joining the panel, which is what unselected looks like.
    tab2_x0 = rx0 + tab_w + 0.55 * gutter
    d.rounded_rectangle([tab2_x0, y0, x1, y0 + tab_h],
                        radius=rt, fill=SLATE_DIM)

    # Main panel, under the tab.
    main_y1 = y0 + 0.62 * h
    d.rounded_rectangle([rx0, y0 + tab_h, x1, main_y1],
                        radius=r, fill=INDIGO_MAIN)

    # Bottom panel.
    d.rounded_rectangle([rx0, main_y1 + gutter, x1, y1],
                        radius=r, fill=INDIGO_SOFT)

    return img


def _at(size: int, *, opaque: bool):
    Image, _ = _pillow()
    out = _draw_mark(opaque).resize((size, size), Image.LANCZOS)
    # RGB, not filled RGBA: "is this icon opaque?" then reads structurally
    # from the IHDR colour type with the standard library alone.
    return out.convert("RGB") if opaque else out


def _manifest() -> dict:
    """The manifest document, derived from the constants. No pixels involved."""
    from lib.constants import SITE_BRAND, SITE_SHORT_NAME

    return {
        "name": SITE_BRAND,
        "short_name": SITE_SHORT_NAME,
        "description": (
            "IDE-style dockable, resizable and floatable window panels "
            "for Plotly Dash."
        ),
        "start_url": "/",
        "display": "standalone",
        # Must equal templates/index.html's theme-color;
        # tests/test_social_card.py pins the pair.
        "theme_color": THEME_COLOR,
        "background_color": BACKGROUND_COLOR,
        "icons": [
            {
                "src": f"/assets/favicon/favicon-{size}.png",
                "sizes": f"{size}x{size}",
                "type": "image/png",
                "purpose": "any",
            }
            for size in PNG_SIZES
        ],
    }


GENERATED = (
    [f"favicon-{size}.png" for size in PNG_SIZES]
    + ["apple-touch-icon.png", "favicon.ico", "site.webmanifest"]
)


def check() -> int:
    """Verify without rendering — and therefore without Pillow."""
    problems = []
    for name in GENERATED:
        if not (OUT_DIR / name).exists():
            problems.append(f"{name} MISSING")

    manifest_path = OUT_DIR / "site.webmanifest"
    if manifest_path.exists():
        try:
            on_disk = json.loads(manifest_path.read_text())
        except json.JSONDecodeError as exc:
            problems.append(f"site.webmanifest UNREADABLE ({exc})")
        else:
            if on_disk != _manifest():
                problems.append(
                    "site.webmanifest STALE — it disagrees with lib/constants.py"
                )

    if problems:
        for problem in problems:
            print(f"[brand] {problem}", file=sys.stderr)
        print("[brand] run: python scripts/make_brand_assets.py", file=sys.stderr)
        return 1

    print("[brand] every generated asset is present and current")
    return 0


def render() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    written: list[tuple[str, str]] = []

    def emit(path: Path, image, **save_kwargs) -> None:
        image.save(path, **save_kwargs)
        written.append((path.name, f"{image.width}x{image.height}"))

    # Transparent PNGs — the manifest icons, and favicon-512.png doubles as
    # make_social_card.py's default --artwork.
    for size in PNG_SIZES:
        emit(OUT_DIR / f"favicon-{size}.png", _at(size, opaque=False),
             format="PNG", optimize=True)

    emit(OUT_DIR / "apple-touch-icon.png", _at(APPLE_SIZE, opaque=True),
         format="PNG", optimize=True)

    # The .ico. Pillow writes every requested size into the one file.
    #
    # One copy, in this subdirectory: Dash's {%favicon%} placeholder scans the
    # whole assets tree for a file named favicon.ico (not only the assets
    # root), finds this one and emits its own <link rel="icon"> pointing here.
    # Measured by dash-emoji-mart — an extra copy at assets/favicon.ico was
    # never served.
    emit(OUT_DIR / "favicon.ico", _at(max(ICO_SIZES), opaque=False),
         format="ICO", sizes=[(n, n) for n in ICO_SIZES])

    (OUT_DIR / "site.webmanifest").write_text(
        json.dumps(_manifest(), indent=2) + "\n"
    )
    written.append(("site.webmanifest", "ok"))

    for name, detail in written:
        print(f"[brand] {name:24} {detail}")
    print("[brand] mark: drawn in-script (dock panels, Mantine indigo on #1a1b1e)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--check", action="store_true",
                    help="verify the generated files exist and the manifest "
                         "matches the constants; write nothing")
    return check() if ap.parse_args().check else render()


if __name__ == "__main__":
    sys.exit(main())
