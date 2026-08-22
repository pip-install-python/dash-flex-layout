"""Every runtime import must be declared — the clean-image witness.

A fork of this template died in production on ``ModuleNotFoundError: No
module named 'PIL'``: the package arrived with half the scientific stack,
so every machine it was tested on already had it — suite green, boots
locally, dies in a clean image. And because Dash imports every page while
constructing the app, one undeclared import in one docs example took the
whole site down. "Works here" and "works in a clean image" are different
claims, and the gap is always a package someone installed by hand months
ago. The fix is not discipline — it is this test, which reads the code
instead of trusting the interpreter's search path.

The check walks every runtime module (``lib/``, ``pages/``,
``components/``, ``docs/``, ``run.py``) and asserts each absolute import
resolves in the environment CI actually installs (requirements.txt and
nothing else). Nesting is deliberately ignored: the fatal PIL import was
function-local, so "only check module-level imports" would have missed it.
Nesting does not predict whether an import can kill a boot.

Exemptions are earned, not asserted. Each one carries a companion check
below proving the condition that makes it safe still holds — a comment
explaining why a rule doesn't apply decays; a test doesn't.
"""

from __future__ import annotations

import ast
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
RUNTIME_DIRS = ("lib", "pages", "components", "docs")
RUNTIME_ROOT_FILES = ("run.py",)

# Dead-branch backends. The boilerplate boots on Flask, FastAPI or Quart and
# exempts all three stacks; THIS FORK IS FLASK-ONLY (run.py registers the
# Flask health route directly and passes the literal "flask" to every
# backend-aware helper). Two template-shaped modules — lib/health.py and
# lib/agent_key.py — still carry the fastapi/quart branches so a future
# template sync stays a clean copy rather than a merge, and those branches
# import packages this fork does not install.
#
# The exemption is therefore narrow and earned: only names that appear
# EXCLUSIVELY inside a `backend == "..."` branch. `pydantic` is deliberately
# NOT here — the boilerplate exempts it as arriving with the fastapi extra,
# but pages/markdown.py imports it unconditionally and requirements.txt
# declares it, so it is checked like any other dependency.
# test_optional_backend_imports_are_unreachable_here is the companion.
OPTIONAL_BACKEND_MODULES = {
    "fastapi": "dead branch — this fork never selects the FastAPI backend",
    "starlette": "arrives with fastapi; same dead branch",
    "quart": "dead branch — this fork never selects the Quart backend",
    "hypercorn": "quart's server; same dead branch",
    "uvicorn": "fastapi's server; same dead branch",
}

# The boilerplate's carrier modules (they import fastapi/starlette at module
# level). This fork ships neither, which test_this_fork_is_flask_only pins.
CARRIER_MODULES: set[str] = set()

# VENDORED distributions: declared in requirements.txt as a path to a tarball
# in vendor/ rather than as a package name, because they are not on PyPI.
#
# `find_spec` answers "is it installed HERE", which is the right question for
# a PyPI dependency and the wrong one for this: a vendored sdist has to be
# BUILT to be importable, so a sandbox without network access (no setuptools
# to fetch) reports it missing while the declaration is perfectly correct and
# the Docker image installs it fine. The declaration is what this test is
# actually about — the PIL outage was an UNdeclared import, not an uninstalled
# one — so a vendored module is satisfied by its declaration, and
# test_vendored_declarations_are_real earns that by checking the tarball
# exists and the Dockerfile copies it before the install layer.
VENDORED_MODULES = {"dash_clerk_auth": "vendor/dash_clerk_auth-1.0.5.tar.gz"}


def _runtime_files():
    for d in RUNTIME_DIRS:
        yield from sorted((ROOT / d).rglob("*.py"))
    for f in RUNTIME_ROOT_FILES:
        yield ROOT / f


def _top_level_name(node: ast.AST) -> list[str]:
    if isinstance(node, ast.Import):
        return [alias.name.split(".")[0] for alias in node.names]
    if isinstance(node, ast.ImportFrom) and node.level == 0 and node.module:
        return [node.module.split(".")[0]]
    return []


def _requirements() -> str:
    return (ROOT / "requirements.txt").read_text(encoding="utf-8")


def _local_names() -> set[str]:
    names = {p.name for p in ROOT.iterdir() if p.is_dir()}
    names |= {p.stem for p in ROOT.glob("*.py")}
    return names


def test_every_runtime_import_is_declared_or_exempt():
    local = _local_names()
    stdlib = set(sys.stdlib_module_names)
    missing: list[str] = []
    checked: dict[str, bool] = {}

    for path in _runtime_files():
        if "__pycache__" in path.parts:
            continue
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        for node in ast.walk(tree):
            for name in _top_level_name(node):
                if name in stdlib or name in local:
                    continue
                if name in OPTIONAL_BACKEND_MODULES:
                    continue
                if name in VENDORED_MODULES and _requirements().count(
                    VENDORED_MODULES[name]
                ):
                    continue
                if name not in checked:
                    try:
                        checked[name] = (
                            importlib.util.find_spec(name) is not None
                        )
                    except (ImportError, ValueError):
                        checked[name] = False
                if not checked[name]:
                    rel = path.relative_to(ROOT)
                    missing.append(f"{rel}:{node.lineno}: {name}")

    assert missing == [], (
        "Runtime imports that do not resolve in this environment. In CI this "
        "environment is exactly requirements.txt — an unresolvable import "
        "here is a boot-time ModuleNotFoundError in a clean image, even if "
        "it works on a dev machine that happens to have the package: "
        f"{missing}"
    )


def test_optional_backend_imports_are_unreachable_here():
    """What earns the dead-branch exemption: every one of those imports sits
    inside a backend conditional, and no caller ever selects that backend.

    The exemption is a hole in the clean-image guard, so it is bounded from
    both ends. If someone hoists one of these imports to a module body, or
    starts passing a backend other than "flask", this fails and the packages
    have to be declared for real.
    """
    exempt = set(OPTIONAL_BACKEND_MODULES)
    hoisted: list[str] = []

    for path in _runtime_files():
        if "__pycache__" in path.parts:
            continue
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        # Collect every import node that is NOT nested inside an `if`.
        guarded: set[int] = set()
        for node in ast.walk(tree):
            if isinstance(node, ast.If):
                for inner in ast.walk(node):
                    if isinstance(inner, (ast.Import, ast.ImportFrom)):
                        guarded.add(id(inner))
        for node in ast.walk(tree):
            if isinstance(node, (ast.Import, ast.ImportFrom)):
                if id(node) in guarded:
                    continue
                if set(_top_level_name(node)) & exempt:
                    hoisted.append(f"{path.relative_to(ROOT)}:{node.lineno}")

    assert hoisted == [], (
        "an optional-backend package is imported outside a backend "
        f"conditional — a Flask boot would die on it: {hoisted}"
    )

    run_py = (ROOT / "run.py").read_text(encoding="utf-8")
    for call in ("register_health_route(app, ", "register_agent_key_route(app, "):
        at = run_py.find(call)
        assert at != -1, f"run.py no longer calls {call.strip('(, ')}"
        assert run_py[at + len(call):].startswith('"flask"'), (
            f"{call.strip('(, ')} is passed something other than the literal "
            '"flask" — the dead-branch exemption above assumes it never is'
        )


def test_this_fork_is_flask_only():
    """Why there is no optional-backend exemption above.

    The boilerplate boots on any of three backends and ships carrier modules
    that import fastapi/starlette at module level. This fork serves Flask and
    nothing else: no backend selector, no ASGI modules, flask + gunicorn
    declared outright. That is what keeps the dead-branch exemption above
    narrow — the exempt packages appear only in branches nothing reaches.

    If a backend selector is ever added here, this fails, and whoever adds it
    has to bring back the boilerplate's carrier machinery and declare the
    packages for real rather than inheriting an exemption written for code
    that could not run.
    """
    for carrier in ("lib/asgi_routes.py", "lib/asgi_middleware.py",
                    "lib/backend.py"):
        assert not (ROOT / carrier).exists(), (
            f"{carrier} exists — this fork grew a second backend, so the "
            "optional-backend exemption and its two companion checks must "
            "come back from the boilerplate"
        )
    text = _requirements()
    assert "flask>=" in text and "gunicorn>=" in text, (
        "the only backend this fork claims must be declared outright"
    )


def test_vendored_declarations_are_real():
    """What earns the VENDORED_MODULES exemption.

    Skipping `find_spec` for a vendored module is only safe while three
    things hold, and all three have failed on real hosts:

    1. requirements.txt actually names the tarball path;
    2. the tarball is actually committed at that path (a `vendor/` that
       resolves to an empty directory installs NOTHING, silently);
    3. the Dockerfile copies vendor/ BEFORE the requirements layer — get
       that order wrong and pip reports the missing path as a soft WARNING,
       then dies seconds later on an OSError that reads like a registry
       outage.
    """
    requirements = _requirements()
    dockerfile = (ROOT / "Dockerfile").read_text(encoding="utf-8")

    for module, tarball in VENDORED_MODULES.items():
        assert tarball in requirements, (
            f"{module} is exempted as vendored, but requirements.txt does "
            f"not install {tarball}"
        )
        assert (ROOT / tarball).is_file(), (
            f"requirements.txt installs {tarball}, which is not committed — "
            "an empty vendor/ installs nothing and says almost nothing"
        )

    copy_at = dockerfile.find("COPY vendor/")
    reqs_at = dockerfile.find("COPY requirements.txt")
    install_at = dockerfile.find("pip install --no-cache-dir -r requirements.txt")
    assert copy_at != -1, "the Dockerfile never copies vendor/"
    assert install_at != -1, "could not find the requirements install layer"
    assert copy_at < reqs_at < install_at, (
        "the Dockerfile must COPY vendor/ before the requirements layer; "
        "otherwise pip warns about the missing path and then fails with an "
        "error that looks like a registry outage"
    )


def test_runtime_code_never_imports_build_scripts():
    """scripts/ is excluded from the declared-imports walk because its
    tools (favicon and social-card generation) run at build time with
    out-of-band installs (Pillow). That exclusion is only safe while no
    runtime module reaches into scripts/ — the moment one does, its
    undeclared imports become boot-time imports."""
    offenders: list[str] = []
    for path in _runtime_files():
        if "__pycache__" in path.parts:
            continue
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                if any(a.name.split(".")[0] == "scripts" for a in node.names):
                    offenders.append(f"{path.relative_to(ROOT)}:{node.lineno}")
            elif isinstance(node, ast.ImportFrom):
                if node.level == 0 and node.module and (
                    node.module.split(".")[0] == "scripts"
                ):
                    offenders.append(f"{path.relative_to(ROOT)}:{node.lineno}")
    assert offenders == [], (
        "Runtime code imports from scripts/ — build-time tools carry "
        f"undeclared dependencies by design: {offenders}"
    )
