#!/usr/bin/env python
"""Release-consistency checks for flexlayout-dash.

None of these break a test run, which is exactly why they need their own gate:
a version that drifted between `package.json` and the shipped
`package-info.json`, or a JS bundle that was never rebuilt after a `.tsx` edit,
produces a wheel that installs cleanly and is quietly wrong.

`pyproject.toml` is the source of truth for the version — it is what the built
wheel is named. Three other files must agree with it:

  * `package.json`                         — the npm/build manifest;
    `dash-generate-components` copies its version into
  * `flexlayout_dash/package-info.json`    — what `flexlayout_dash.__version__`
    actually returns at runtime, so a drift here ships a wheel that installs
    cleanly and reports the wrong number; and
  * `lib/constants.py`                     — reported by the docs site's
    `/healthz` to the 2plot.ai pulse sweep.

    python scripts/check_release.py            # errors fail, warnings do not
    python scripts/check_release.py --strict   # warnings fail too

Exit code is 0 when there are no errors, 1 otherwise.
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

ERRORS: list[str] = []
WARNINGS: list[str] = []
NOTES: list[str] = []


def error(msg: str) -> None:
    ERRORS.append(msg)


def warn(msg: str) -> None:
    WARNINGS.append(msg)


def note(msg: str) -> None:
    NOTES.append(msg)


# ---------------------------------------------------------------------------
# Versions
# ---------------------------------------------------------------------------

def pyproject_version() -> str | None:
    """The authoritative version — what the built wheel is named."""
    try:
        text = (ROOT / "pyproject.toml").read_text()
    except Exception as exc:  # noqa: BLE001
        error(f"pyproject.toml unreadable: {exc}")
        return None
    # Anchored to the [project] table's own `version = "..."`, which is the
    # first such key in the file. Deliberately not tomllib: this script must
    # run on 3.9/3.10, where tomllib does not exist.
    m = re.search(r'^version\s*=\s*"([^"]+)"', text, re.M)
    if not m:
        error("pyproject.toml has no [project] version")
        return None
    return m.group(1)


def check_versions() -> None:
    """Every place the version is written must agree with pyproject.toml."""
    truth = pyproject_version()
    if truth is None:
        return
    note(f"pyproject.toml version = {truth} (authoritative)")

    # The npm manifest. dash-generate-components reads THIS when writing
    # package-info.json, so a drift here silently propagates to __version__.
    try:
        pkg_json = json.loads((ROOT / "package.json").read_text())["version"]
        if pkg_json != truth:
            error(f"version drift: pyproject.toml={truth} but "
                  f"package.json={pkg_json}. `npm run build:backends` would "
                  f"regenerate package-info.json at {pkg_json}, so the wheel "
                  f"would be named {truth} and report {pkg_json}.")
        else:
            note(f"package.json = {pkg_json}")
    except Exception as exc:  # noqa: BLE001
        error(f"package.json unreadable: {exc}")

    # The file flexlayout_dash/__init__.py actually reads at import time. If
    # this drifts, the wheel is named one version and reports another.
    info = ROOT / "flexlayout_dash" / "package-info.json"
    if not info.exists():
        error("flexlayout_dash/package-info.json is missing — run `npm run build:backends`. "
              "flexlayout_dash.__version__ cannot resolve without it.")
    else:
        try:
            got = json.loads(info.read_text())["version"]
            if got != truth:
                error(f"version drift: pyproject.toml={truth} but "
                      f"flexlayout_dash/package-info.json={got}. The wheel would be "
                      f"built as {truth} while flexlayout_dash.__version__ reports {got}. "
                      f"Run `npm run build:backends`.")
            else:
                note(f"flexlayout_dash/package-info.json = {got}")
        except Exception as exc:  # noqa: BLE001
            error(f"flexlayout_dash/package-info.json unreadable: {exc}")

    # The docs site reports this from /healthz to the 2plot.ai pulse sweep.
    constants = ROOT / "lib" / "constants.py"
    if constants.exists():
        m = re.search(r'^APP_VERSION\s*=\s*"([^"]+)"', constants.read_text(), re.M)
        if not m:
            warn("lib/constants.py has no APP_VERSION")
        elif m.group(1) != truth:
            warn(f"lib/constants.py APP_VERSION={m.group(1)} "
                 f"does not match pyproject.toml {truth} — /healthz would report "
                 f"a stale version to the 2plot.ai hub.")
        else:
            note(f"lib/constants.py APP_VERSION = {m.group(1)}")


# ---------------------------------------------------------------------------
# Build artifacts
# ---------------------------------------------------------------------------

REQUIRED_ARTIFACTS = [
    "flexlayout_dash/__init__.py",
    "flexlayout_dash/_imports_.py",
    "flexlayout_dash/DashFlexLayout.py",
    "flexlayout_dash/Tab.py",
    "flexlayout_dash/flexlayout_dash.min.js",
    "flexlayout_dash/package-info.json",
]


def check_artifacts() -> None:
    for rel in REQUIRED_ARTIFACTS:
        if not (ROOT / rel).exists():
            error(f"missing build artifact: {rel} — run `npm run build`")


def _last_commit_time(path: str) -> int | None:
    """Unix time of the last commit touching `path`, or None."""
    try:
        out = subprocess.run(
            ["git", "log", "-1", "--format=%ct", "--", path],
            cwd=ROOT, capture_output=True, text=True, timeout=20,
        )
        return int(out.stdout.strip()) if out.stdout.strip() else None
    except Exception:  # noqa: BLE001
        return None


def check_bundle_freshness() -> None:
    """Warn when the TypeScript source was committed after the bundle was.

    Git commit times, not mtimes: a fresh clone (and CI's checkout) rewrites
    every mtime, so mtimes would make this check meaningless there.
    """
    src = _last_commit_time("src/lib")
    bundle = _last_commit_time("flexlayout_dash/flexlayout_dash.min.js")
    if src is None or bundle is None:
        note("bundle freshness: SKIPPED (no git history for one of the paths)")
        return
    if src > bundle:
        warn("src/lib was committed AFTER flexlayout_dash.min.js — the bundle is "
             "probably stale. Run `npm run build:js` and commit the result.")
    else:
        note("bundle freshness: bundle is at least as new as src/lib")


def check_init_wiring() -> None:
    """The hand-maintained __init__.py must point at the real bundle.

    `dash-generate-components` crashes in dash's R-package step before writing
    this file (see .claude/CLAUDE.md), so it is maintained by hand and is the
    single most likely thing to be wrong after a rename.
    """
    init = ROOT / "flexlayout_dash" / "__init__.py"
    if not init.exists():
        return  # already reported by check_artifacts
    text = init.read_text()
    if "package_name = 'flexlayout_dash'" not in text and \
       'package_name = "flexlayout_dash"' not in text:
        error("flexlayout_dash/__init__.py does not set package_name = 'flexlayout_dash'")
    if "flexlayout_dash.min.js" not in text:
        error("flexlayout_dash/__init__.py does not register flexlayout_dash.min.js "
              "in _js_dist — the component would render blank.")
    if "dash_flex_layout" in text:
        error("flexlayout_dash/__init__.py still references the old "
              "`dash_flex_layout` namespace.")


# ---------------------------------------------------------------------------
# Packaging
# ---------------------------------------------------------------------------

def check_packaging() -> None:
    manifest = (ROOT / "MANIFEST.in")
    if not manifest.exists():
        error("MANIFEST.in is missing — the JS bundle would not ship in the sdist.")
        return
    text = manifest.read_text()

    if "flexlayout_dash/flexlayout_dash.min.js" not in text:
        error("MANIFEST.in does not include flexlayout_dash/flexlayout_dash.min.js")

    if "include pyproject.toml" not in text:
        error("MANIFEST.in does not include pyproject.toml — the sdist would be "
              "unbuildable.")

    # metadata.json is the react-docgen artifact. Only `dash-generate-components`
    # reads it; shipping it adds ~1 MB to every install for no runtime benefit.
    meta = ROOT / "flexlayout_dash" / "metadata.json"
    if meta.exists() and "exclude flexlayout_dash/metadata.json" not in text:
        warn(f"MANIFEST.in does not exclude flexlayout_dash/metadata.json "
             f"({meta.stat().st_size // 1024} KB react-docgen artifact). Nothing "
             f"reads it at runtime.")

    # MANIFEST.in must be an ALLOWLIST. A `recursive-include` outside the
    # package directory is how the docs site leaks into the artifact — and the
    # failure is silent, visible only to someone who unpacks the tarball.
    strays = [
        ln.strip() for ln in text.splitlines()
        if ln.strip().startswith("recursive-include")
        and not ln.strip().startswith("recursive-include flexlayout_dash")
    ]
    if strays:
        error("MANIFEST.in has a recursive-include outside the package — the "
              "documentation site would ship to PyPI: " + "; ".join(strays))

    # LICENSE is referenced by pyproject's license-files. An empty one produces
    # a wheel that claims MIT and carries no licence text.
    lic = ROOT / "LICENSE"
    if not lic.exists() or lic.stat().st_size == 0:
        error("LICENSE is missing or empty while the metadata declares MIT.")

    # The documentation site lives at the REPO ROOT, so every one of its
    # directories has to be pruned by name. A missing prune ships the
    # deployment's config to PyPI and the build stays green — which is exactly
    # the failure mode .subdomains/PACKAGING.md exists to prevent.
    lines = [ln.strip() for ln in text.splitlines()]
    for d in ("docs", "pages", "lib", "components", "assets", "templates",
              "scripts", "src", "tests", "github_assets"):
        if f"prune {d}" not in lines:
            error(f"MANIFEST.in does not `prune {d}` — the documentation site "
                  f"would ship to PyPI.")
    for f in ("run.py", "requirements.txt", "render.yaml", "Dockerfile"):
        if f"exclude {f}" not in lines:
            error(f"MANIFEST.in does not `exclude {f}` — that belongs to the "
                  f"deployment, not to the package.")
        if any(ln.startswith(("include " + f, "recursive-include " + f)) for ln in lines):
            error(f"MANIFEST.in ships {f} — that belongs to the deployment, "
                  f"not to the package.")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--strict", action="store_true",
                    help="treat warnings as errors")
    args = ap.parse_args()

    check_versions()
    check_artifacts()
    check_init_wiring()
    check_bundle_freshness()
    check_packaging()

    width = 78
    print("=" * width)
    print(" flexlayout-dash release consistency")
    print("=" * width)
    for n in NOTES:
        print(f"  ok    {n}")
    for w in WARNINGS:
        print(f"  WARN  {w}")
    for e in ERRORS:
        print(f"  ERROR {e}")
    print("-" * width)
    print(f" {len(ERRORS)} error(s), {len(WARNINGS)} warning(s)")
    print("-" * width)

    if ERRORS:
        return 1
    if WARNINGS and args.strict:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
