#!/usr/bin/env python
"""Dash compatibility matrix for flexlayout-dash.

The README claims the component runs on Dash 4.1 through 4.4. This script is
what turns that claim into evidence: it builds one throwaway virtualenv per
Dash version, installs the docs site into each, and runs
`scripts/smoke_test.py` there — component import + dock-layout serialisation,
page registration, layout render of every documented example, and an HTTP sweep
of every route through Flask's test client.

    python scripts/compat_matrix.py                     # 4.1.0 4.2.0 4.3.0 4.4.1
    python scripts/compat_matrix.py 4.1.0 4.4.1         # specific versions
    python scripts/compat_matrix.py --component-only    # skip the docs-site legs
    python scripts/compat_matrix.py --keep              # keep the venvs
    python scripts/compat_matrix.py --report COMPATIBILITY.md

Each run writes `.compat/<version>.json` (the raw smoke-test output) and a
markdown table.

Requirements
------------
Network access to PyPI, and a `python3` that can create venvs. Each venv is a
real install of the docs site, so the default four-version run needs a few GB
of scratch space and several minutes. They are deleted afterwards unless you
pass `--keep`.

Offline alternative
-------------------
`--local` skips venv creation and runs the suite under interpreters that
already have the target Dash installed (discovered under `--search-root`).
HONEST LIMITATION, repeated in the report: only DASH comes from the target
interpreter — the docs-site libraries are lent from this project's own
environment. So `--local` measures "our code against Dash X", not "a fresh
dependency resolution against Dash X". A resolver conflict that only appears on
a clean install is caught by the full run (or CI), not by `--local`.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
WORK_DIR = PROJECT_ROOT / ".compat"

# The support claim is Dash 4.1+. These are the rungs actually tested: the
# floor, the two intermediate minors, and the current release.
DEFAULT_VERSIONS = ["4.1.0", "4.2.0", "4.3.0", "4.4.1"]

# The line in requirements.txt carrying the Dash pin. It is
# stripped so each venv gets exactly the version under test.
DASH_PIN_MARKER = "# COMPAT-MATRIX: dash"


def log(msg: str) -> None:
    print(f"[compat] {msg}", flush=True)


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


# ---------------------------------------------------------------------------
# venv mode
# ---------------------------------------------------------------------------

def requirements_without_dash() -> str:
    """The docs requirements with the Dash pin removed.

    Without this, installing the requirements would drag in whatever Dash the
    resolver prefers and every leg of the matrix would silently measure the
    same version.
    """
    src = (PROJECT_ROOT / "requirements.txt").read_text().splitlines()
    kept = [ln for ln in src if DASH_PIN_MARKER not in ln]
    if len(kept) == len(src):
        log(f"WARNING: no line carrying '{DASH_PIN_MARKER}' in "
            f"requirements.txt — the Dash pin may override the "
            f"version under test.")
    return "\n".join(kept) + "\n"


def make_venv(version: str) -> Path | None:
    """Create .compat/venv-<version> with Dash pinned, and return its python."""
    venv_dir = WORK_DIR / f"venv-{version}"
    if venv_dir.exists():
        shutil.rmtree(venv_dir)
    venv_dir.mkdir(parents=True)

    log(f"creating venv for dash {version}")
    r = run([sys.executable, "-m", "venv", str(venv_dir)])
    if r.returncode:
        log(f"venv creation failed: {r.stderr.strip()[:300]}")
        return None

    py = venv_dir / ("Scripts" if os.name == "nt" else "bin") / "python"

    # Dash FIRST and pinned, so the rest of the requirements resolve against it
    # rather than pulling a newer one in.
    r = run([str(py), "-m", "pip", "install", "--upgrade", "pip", "--quiet"])
    r = run([str(py), "-m", "pip", "install", f"dash=={version}", "--quiet"])
    if r.returncode:
        log(f"dash=={version} install failed: {r.stderr.strip()[:300]}")
        return None

    reqs = WORK_DIR / f"reqs-{version}.txt"
    reqs.write_text(requirements_without_dash())
    r = run([str(py), "-m", "pip", "install", "-r", str(reqs), "--quiet"])
    if r.returncode:
        log(f"requirements install failed: {r.stderr.strip()[:400]}")
        return None

    # The second half of the two-command install (see requirements.txt):
    # markdown2dash declares gunicorn<22 against the CVE-driven >=23 floor, so
    # it is absent from requirements.txt and installed with --no-deps.
    r = run([str(py), "-m", "pip", "install", "--no-deps",
             "markdown2dash==0.1.2", "--quiet"])
    if r.returncode:
        log(f"markdown2dash install failed: {r.stderr.strip()[:300]}")
        return None

    return py


def resolved_dash(py: Path) -> str:
    r = run([str(py), "-c", "import dash;print(dash.__version__)"])
    return r.stdout.strip() or "unknown"


def smoke(py: Path, version: str, component_only: bool) -> dict:
    """Run the smoke suite under `py` and return its JSON result."""
    out = WORK_DIR / f"{version}.json"
    cmd = [str(py), str(PROJECT_ROOT / "scripts" / "smoke_test.py"),
           "--json", str(out), "--quiet"]
    if component_only:
        cmd.append("--component")

    got = resolved_dash(py)
    if got != version:
        log(f"WARNING: requested dash {version} but the venv resolved {got}")

    proc = run(cmd, cwd=str(PROJECT_ROOT))
    row = {"version": version, "resolved": got, "exit": proc.returncode}
    if out.exists():
        try:
            payload = json.loads(out.read_text())
            row.update(summary=payload["summary"],
                       failures=[c for c in payload["checks"] if not c["ok"]])
        except Exception as exc:  # noqa: BLE001
            row["error"] = f"unreadable smoke JSON: {exc}"
    else:
        row["error"] = (proc.stderr or proc.stdout).strip()[-600:] or "no output"
    return row


# ---------------------------------------------------------------------------
# --local mode
# ---------------------------------------------------------------------------

def discover_interpreters(search_root: Path) -> dict[str, Path]:
    """Map dash version -> interpreter, for pythons found under `search_root`.

    Looks at every `*/bin/python` beneath the root, asks each for its Dash
    version, and keeps the first interpreter offering each version.
    """
    found: dict[str, Path] = {}
    if not search_root.exists():
        return found
    # Both layouts: a directory OF venvs (`envs/py311-dash41/bin/python`) and
    # a directory of PROJECTS each carrying its own `.venv` — which is how
    # ~/PycharmProjects is laid out, and the case the original glob missed.
    candidates = (
        list(search_root.glob("*/bin/python"))
        + list(search_root.glob("*/.venv/bin/python"))
        + list(search_root.glob("*/venv/bin/python"))
        + list(search_root.glob("*/Scripts/python.exe"))
        + list(search_root.glob("*/.venv/Scripts/python.exe"))
    )
    for py in candidates:
        r = run([str(py), "-c", "import dash;print(dash.__version__)"], timeout=60)
        v = r.stdout.strip()
        if v and re.match(r"^\d+\.\d+", v) and v not in found:
            found[v] = py
    return found


def donor_site_packages() -> Path:
    """This interpreter's site-packages — the docs libraries get lent from here."""
    import sysconfig

    return Path(sysconfig.get_paths()["purelib"])


def smoke_local(py: Path, version: str, component_only: bool) -> dict:
    out = WORK_DIR / f"{version}-local.json"
    args = ["--json", str(out), "--quiet"] + (["--component"] if component_only else [])
    env = dict(os.environ,
               FLD_EXTRA_SITE=str(donor_site_packages()),
               FLD_SMOKE_ARGS="\n".join(args))
    proc = run([str(py), str(PROJECT_ROOT / "scripts" / "_compat_runner.py")],
               cwd=str(PROJECT_ROOT), env=env)
    row = {"version": version, "resolved": version, "exit": proc.returncode}
    if out.exists():
        try:
            payload = json.loads(out.read_text())
            row.update(summary=payload["summary"],
                       failures=[c for c in payload["checks"] if not c["ok"]])
        except Exception as exc:  # noqa: BLE001
            row["error"] = f"unreadable smoke JSON: {exc}"
    else:
        row["error"] = (proc.stderr or proc.stdout).strip()[-600:] or "no output"
    return row


# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------

def markdown_report(rows: list[dict], local: bool, component_only: bool) -> str:
    lines = [
        "# Dash compatibility",
        "",
        "Generated by `python scripts/compat_matrix.py`. Each row is a full run of",
        "`scripts/smoke_test.py` against that Dash version: the component imports and a",
        "dock model with a row, a tabset and a border survives Dash's JSON encoder"
        + ("." if component_only else
           ", then the documentation site boots and every route is fetched through Flask's test client."),
        "",
        "| Dash | Result | Checks | Notes |",
        "|------|--------|--------|-------|",
    ]
    for r in rows:
        s = r.get("summary")
        if r.get("error"):
            result, checks, notes = "❌ error", "—", r["error"].splitlines()[-1][:90]
        elif s and s["failed"] == 0:
            result, checks, notes = "✅ pass", f"{s['passed']}/{s['total']}", ""
        elif s:
            result = "❌ fail"
            checks = f"{s['passed']}/{s['total']}"
            notes = "; ".join(f"{f['group']}/{f['name']}" for f in r["failures"][:3])[:90]
        else:
            result, checks, notes = "❔ unknown", "—", ""
        if r["resolved"] != r["version"]:
            notes = (notes + f" (resolved {r['resolved']})").strip()
        lines.append(f"| {r['version']} | {result} | {checks} | {notes} |")

    lines += ["", "## How this was measured", ""]
    if local:
        lines += [
            "Run in **`--local` mode**. Only `dash` came from each target interpreter;",
            "the documentation-site libraries were lent from this project's own",
            "environment. So this measures *our code against Dash X*, not *a fresh",
            "dependency resolution against Dash X* — a resolver conflict that only",
            "appears on a clean install would not show up here. The full",
            "`python scripts/compat_matrix.py` (and CI) is what catches that.",
        ]
    else:
        lines += [
            "Each version got its own throwaway virtualenv: `dash==<version>` installed",
            "first, then `requirements.txt` with the Dash pin stripped, so",
            "the rest of the dependencies resolved against the version under test.",
        ]
    lines += [
        "",
        "The suite drives the app through Flask's in-process test client — no socket,",
        "no browser. That exercises routing, layout construction and serialisation, which",
        "is the layer a Dash version bump actually breaks. It does **not** verify that",
        "FlexLayout paints panels in a real browser.",
        "",
    ]
    return "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("versions", nargs="*", default=None,
                    help=f"Dash versions to test (default: {' '.join(DEFAULT_VERSIONS)})")
    ap.add_argument("--component-only", action="store_true",
                    help="test only the component, not the documentation site")
    ap.add_argument("--local", action="store_true",
                    help="use already-installed interpreters instead of building venvs")
    ap.add_argument("--search-root", default=str(Path.home() / ".virtualenvs"),
                    help="where --local looks for interpreters")
    ap.add_argument("--keep", action="store_true", help="keep the venvs afterwards")
    ap.add_argument("--report", metavar="PATH", default=None,
                    help="write the markdown table here (e.g. COMPATIBILITY.md)")
    args = ap.parse_args()

    versions = args.versions or DEFAULT_VERSIONS
    WORK_DIR.mkdir(exist_ok=True)
    rows: list[dict] = []

    if args.local:
        found = discover_interpreters(Path(args.search_root))
        log(f"discovered dash versions: {', '.join(sorted(found)) or 'none'}")
        for v in versions:
            if v not in found:
                log(f"skipping {v} — no interpreter with it under {args.search_root}")
                rows.append({"version": v, "resolved": v,
                             "error": "no local interpreter with this Dash"})
                continue
            log(f"running smoke suite on dash {v}")
            rows.append(smoke_local(found[v], v, args.component_only))
    else:
        for v in versions:
            py = make_venv(v)
            if py is None:
                rows.append({"version": v, "resolved": v, "error": "venv setup failed"})
                continue
            log(f"running smoke suite on dash {v}")
            rows.append(smoke(py, v, args.component_only))
        if not args.keep:
            for v in versions:
                shutil.rmtree(WORK_DIR / f"venv-{v}", ignore_errors=True)

    report = markdown_report(rows, local=args.local, component_only=args.component_only)
    print()
    print(report)
    if args.report:
        out = Path(args.report)
        if not out.is_absolute():
            out = PROJECT_ROOT / out
        out.write_text(report)
        log(f"wrote {out}")

    failed = [r for r in rows if r.get("error") or (r.get("summary") or {}).get("failed")]
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
