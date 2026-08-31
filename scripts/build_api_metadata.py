#!/usr/bin/env python3
"""Distil a component package's react-docgen metadata.json to the committed
extract /api renders from (item 18; leaflet's finding).

WHY: in a component REPO, `<package>/metadata.json` can be a multi-megabyte
build artifact that is .gitignored and excluded from the wheel — a build
INPUT, not a runtime file. The host clones the repo and never has it, so
/api passes every local check and renders EMPTY in production. This writes
`<package>/api_metadata.json` in `lib.api_reference.load_package`'s output
shape (about 1% of the size), which IS committed; `load_package` prefers
metadata.json when present, so a developer who just rebuilt sees new props
immediately, and everyone else gets this file.

THIS FORK: flexlayout_dash/metadata.json is git-tracked, not gitignored —
mechanism 1 already serves /api's table content here. This extract still
matters for the SITEMAP LASTMOD: pages/api.py reads slim_generated_on(),
which is None (and the sitemap omits the tag, honestly) until this script
has run at least once.

`generated` IS NOT "the day this script ran" — muicharts shipped exactly
that and it was live for about four minutes before it caught it: the
sitemap asserting a content date that is not one. It is the date the
CONTENT last actually changed, taken from CHANGELOG.md's entry for the
INSTALLED package version (flexlayout_dash.__version__) — the same date a
person reading the changelog would call "when this shipped". Bumping the
package's version (and dating that release in CHANGELOG.md, which this
repo's own release process already requires) moves this date in the same
change; tests/test_seo_icons.py pins it against a fresh read of the
CHANGELOG, so a future bump that forgets to run this script goes red
rather than silently drifting.

RUN whenever a component's props change (after bumping the version and
dating the CHANGELOG.md entry — this script reads that date, it does not
invent one):

    python scripts/build_api_metadata.py            # API_PACKAGES[0]
    python scripts/build_api_metadata.py my_package  # or name it
    git add <package>/api_metadata.json
"""
from __future__ import annotations

import importlib
import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO))

from lib.api_reference import SLIM_METADATA, _from_metadata  # noqa: E402

CHANGELOG_PATH = REPO / "CHANGELOG.md"


def changelog_date_for_version(version: str, changelog: Path = CHANGELOG_PATH) -> str | None:
    """The date CHANGELOG.md declares for ``## [<version>] - <date>``, or
    None if the version has no dated entry (an unreleased or hand-edited
    version). Never invents a date — the caller decides what to do with
    None."""
    try:
        text = changelog.read_text(encoding="utf-8")
    except OSError:
        return None
    m = re.search(
        rf"^## \[{re.escape(version)}\][^\n]*?(\d{{4}}-\d{{2}}-\d{{2}})",
        text, re.MULTILINE,
    )
    return m.group(1) if m else None


def build(package: str) -> Path:
    mod = importlib.import_module(package)
    pkg_dir = Path(mod.__file__).resolve().parent
    source = pkg_dir / "metadata.json"
    if not source.is_file():
        raise SystemExit(f"{source} is missing — build the package first (it is the react-docgen artifact).")
    components = _from_metadata(mod, source)
    if not components:
        raise SystemExit(f"{source} parsed to zero components — refusing to write an empty extract.")

    version = getattr(mod, "__version__", None)
    generated = changelog_date_for_version(version) if version else None
    if not generated:
        raise SystemExit(
            f"CHANGELOG.md has no dated '## [{version}]' entry — date the release "
            "in CHANGELOG.md before regenerating the extract. Refusing to write "
            "today's date: a lastmod must be a date the CONTENT moved, never the "
            "day this script happened to run."
        )

    out = pkg_dir / SLIM_METADATA
    out.write_text(json.dumps({"generated": generated, "components": components},
                              indent=1, sort_keys=True) + "\n", encoding="utf-8")
    props = sum(len(c["props"]) for c in components)
    print(f"{out}: {len(components)} components, {props} props, "
          f"{out.stat().st_size / 1024:.0f} KB (from {source.stat().st_size / 1024 / 1024:.1f} MB); "
          f"generated {generated} (from CHANGELOG.md [{version}])")
    return out


if __name__ == "__main__":
    if len(sys.argv) > 1:
        pkg = sys.argv[1]
    else:
        from lib.constants import API_PACKAGES

        if not API_PACKAGES:
            raise SystemExit("API_PACKAGES is empty and no package was named.")
        pkg = API_PACKAGES[0]
    build(pkg)
