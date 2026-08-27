"""One fleet Python — image, matrix and render.yaml must agree.

Found by the ops seat reading the tree, not a report (2026-08-25): the
template's Dockerfile said `python:3.11.8-slim` — a PATCH pin, so the image
never received a 3.11.x security release — while its CI matrix said 3.12 and
render.yaml said 3.12.0. Three declared Pythons, the docker boot/battery
testing an interpreter the matrix never ran, and nothing on the wire able to
contradict any of them. These pins hold every encoding to ONE minor, sourced
from the Dockerfile's FROM tag; /healthz's `python` field plus the
`python_matches_declared` battery check (scripts/network_smoke.py) hold the
serving host to the same one.

What is deliberately NOT here: no comparison of the RUNNING interpreter to the
fleet minor — the suite legitimately runs on the adjacent window legs (the
docs matrix's 3.13/3.12 rows), where that assertion would be false by design.
Image-vs-declaration is the battery's job, against a host.

THIS IS A COMPONENT REPO, so the site-vs-package split the template's
reference warns about is not hypothetical here — it is the whole shape of
`ci.yml` (SYNC-1.6.22-1.6.29 item 5, as amended 1.6.28 by flows and
clerkhook). Two Pythons live in that file and this module pins exactly one:

  SITE lane      lint / site-tests / docs / docker — installs
                 requirements.txt, boots run.py, runs the battery. Held to
                 the image's minor, because the image is what production
                 serves.
  PACKAGE lane   package / package-python-range — builds the wheel and tests
                 `requires-python = ">=3.9"` across 3.9-3.13. The package's
                 business, and out of this item's scope: pinning a wheel's
                 support window to a container base would break it the moment
                 the image moved.

The lane map below is exhaustive on purpose — a NEW job in ci.yml fails
`test_every_ci_job_is_assigned_a_lane` until someone says which Python it is
testing. That question is the entire point of this file.

Session-class, not block cargo: it presumes a Dockerfile and a render.yaml,
which not every fork carries.
"""
from __future__ import annotations

import re

from conftest import REPO_ROOT

# The site lane installs the docs site and serves it; the package lane builds
# and tests the wheel. See the module docstring.
SITE_LANE_JOBS = {"lint", "site-tests", "docs", "docker"}
PACKAGE_LANE_JOBS = {"package", "package-python-range"}


def _fleet_minor() -> str:
    """The single source: the Dockerfile's FROM tag."""
    for line in (REPO_ROOT / "Dockerfile").read_text(encoding="utf-8").splitlines():
        m = re.match(r"FROM\s+python:(\S+)", line)
        if m:
            return m.group(1)
    raise AssertionError("Dockerfile has no `FROM python:` line")


def _uncommented(path) -> list[str]:
    return [
        ln for ln in (REPO_ROOT / path).read_text(encoding="utf-8").splitlines()
        if not ln.lstrip().startswith("#")
    ]


def _jobs(path) -> dict[str, list[str]]:
    """{job name: its uncommented lines}. A hand parse, not yaml.safe_load,
    so this file keeps the template's zero-dependency shape and reports line
    text rather than a parsed structure when it fails."""
    jobs: dict[str, list[str]] = {}
    current = None
    in_jobs = False
    for line in _uncommented(path):
        if re.match(r"^jobs:\s*$", line):
            in_jobs = True
            continue
        if not in_jobs:
            continue
        m = re.match(r"^  ([a-z][a-z0-9_-]*):\s*$", line)
        if m:
            current = m.group(1)
            jobs[current] = []
            continue
        if current:
            jobs[current].append(line)
    return jobs


def _render_runtime() -> str:
    for ln in _uncommented("render.yaml"):
        m = re.match(r"\s*runtime:\s*(\S+)", ln)
        if m:
            return m.group(1)
    raise AssertionError("render.yaml declares no `runtime:`")


def test_dockerfile_tag_is_minor_only():
    """The patch pin IS the security bug: `3.11.8-slim` never receives a
    3.11.x fix release. The minor tag tracks them through Docker Hub."""
    tag = _fleet_minor()
    assert re.fullmatch(r"\d+\.\d+-slim", tag), (
        f"Dockerfile FROM tag is {tag!r} — must be a MINOR tag "
        "(python:X.Y-slim), never a patch pin"
    )


def test_render_yaml_agrees_with_the_image():
    """BRANCHES on the service runtime (1.6.28 — filed independently by three
    forks in the batch-2/3 round). This host is `runtime: docker`, so the
    branch that runs here asserts PYTHON_VERSION is ABSENT: nothing reads it
    on a docker service, and a string that looks like the platform's setting
    and can never be true is this item's own defect class arriving through
    the fix. The `python` branch is kept live rather than deleted — if this
    service is ever converted to Render's native runtime the test flips by
    itself instead of going quietly vacuous."""
    minor = _fleet_minor().removesuffix("-slim")
    runtime = _render_runtime()
    lines = _uncommented("render.yaml")
    value = None
    for i, ln in enumerate(lines):
        if re.match(r"\s*- key: PYTHON_VERSION$", ln):
            m = re.search(r'value:\s*"([^"]+)"', lines[i + 1])
            value = m and m.group(1)
            break
    if runtime == "docker":
        assert value is None, (
            f"render.yaml declares PYTHON_VERSION {value!r} on a docker "
            "runtime — nothing reads it there; a string that looks like the "
            "platform's setting and can never be true is the drift class "
            "this file exists to kill. Delete the key."
        )
        return
    assert runtime == "python", (
        f"render.yaml runtime is {runtime!r} — this test knows `python` and "
        "`docker`; extend the branch deliberately"
    )
    assert value, "render.yaml declares no PYTHON_VERSION"
    assert re.fullmatch(r"\d+\.\d+\.\d+", value), (
        f"PYTHON_VERSION {value!r} — Render requires full X.Y.Z"
    )
    assert value.startswith(minor + "."), (
        f"render.yaml PYTHON_VERSION {value} vs image python:{minor}-slim — "
        "the native-runtime lane and the image lane disagree"
    )


def test_every_ci_job_is_assigned_a_lane():
    """The guard that keeps this file from going quietly vacuous. A job added
    to ci.yml without a lane is a Python nobody decided about — exactly how
    the template ended up serving three."""
    jobs = set(_jobs(".github/workflows/ci.yml"))
    unassigned = sorted(jobs - SITE_LANE_JOBS - PACKAGE_LANE_JOBS)
    assert not unassigned, (
        f"ci.yml jobs {unassigned} belong to no lane — add each to "
        "SITE_LANE_JOBS (it installs requirements.txt / boots the docs app) "
        "or PACKAGE_LANE_JOBS (it builds or tests the wheel)"
    )
    missing = sorted((SITE_LANE_JOBS | PACKAGE_LANE_JOBS) - jobs)
    assert not missing, f"the lane map names jobs ci.yml no longer has: {missing}"


def test_site_lane_pins_agree_with_the_image():
    """Every literal Python in a SITE-lane job equals the image's minor.

    The docs job's own pin is `${{ matrix.python }}` and deliberately not a
    literal; its matrix main is checked below."""
    minor = _fleet_minor().removesuffix("-slim")
    jobs = _jobs(".github/workflows/ci.yml")
    for name in sorted(SITE_LANE_JOBS):
        literals = [m.group(1) for ln in jobs[name]
                    if (m := re.match(r'\s*python-version:\s*"([\d.]+)"', ln))]
        assert set(literals) <= {minor}, (
            f"ci.yml job {name!r} pins python-version {literals}, image is "
            f"python:{minor}-slim"
        )

    mains = [m.group(1) for ln in jobs["docs"]
             if (m := re.match(r'\s*python:\s*\["([\d.]+)"\]', ln))]
    assert mains == [minor], (
        f"the docs matrix main is {mains} vs image python:{minor}-slim"
    )

    cd = _jobs(".github/workflows/cd.yml")
    cd_literals = [m.group(1) for lines in cd.values() for ln in lines
                   if (m := re.match(r'\s*python-version:\s*"([\d.]+)"', ln))]
    assert cd_literals and set(cd_literals) == {minor}, (
        f"cd.yml pins {cd_literals}, image is python:{minor}-slim — the verify "
        "job runs the same battery against production that ci.yml ran against "
        "the container, so it belongs to the site lane too"
    )


def test_docs_matrix_legs_are_the_adjacent_minors():
    """The site's compat window stays three wide: the include legs are X.Y-1
    and X.Y-2 (or X.Y+1 once it exists).

    The legs here are written `- dash: "4.4.1"` / `python: "3.13"` — a dash
    row that varies the python axis — where the template writes `- python:`
    first. Same window, different key order, so the grep is this fork's.

    The PACKAGE matrix's 3.9-3.13 is not a window around anything and is
    excluded by construction: it lives in `package-python-range`, and this
    test reads only `docs`."""
    major, y = (int(p) for p in _fleet_minor().removesuffix("-slim").split("."))
    allowed = {f"{major}.{y}", f"{major}.{y - 1}", f"{major}.{y - 2}",
               f"{major}.{y + 1}"}
    docs = _jobs(".github/workflows/ci.yml")["docs"]
    include = docs[docs.index(next(ln for ln in docs
                                   if re.match(r"\s*include:\s*$", ln))):]
    legs = [m.group(1) for ln in include
            if (m := re.match(r'\s*-?\s*python:\s*"([\d.]+)"', ln))]
    assert legs, "the docs matrix has no include legs — the window collapsed to one"
    outside = [leg for leg in legs if leg not in allowed]
    assert not outside, (
        f"docs matrix legs {outside} fall outside the three-wide window around "
        f"{major}.{y}"
    )


def test_healthz_reports_the_running_interpreter():
    """The wire half. Absence is NOT-ADOPTED, never not-applicable: an image
    that reaches the fleet minor through dependabot alone passes the cheap
    half of item 5's detect while the expensive half fails invisibly
    (emojimart, 2026-08-26)."""
    import platform

    from lib.health import health_payload

    payload = health_payload("flask")
    assert payload.get("python") == platform.python_version(), payload
