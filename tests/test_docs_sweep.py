"""The docs/ sweep — 1.6.44 item 7.

THIS REPO RUNS NO PYTHON LINTER IN CI. The lint job is actionlint alone;
there is no flake8 step, no ruff, and no `.flake8` file anywhere in the tree.
So `py_compile` is not a second opinion here, it is the ONLY thing that reads
the Python a documentation site actually renders — which makes item 7 more
load-bearing on this fork than on the template, where a linter at least
existed and was merely excluding `docs/*/`.

This module holds the CI step to its name, the corpus to being non-empty, and
every docs module to compiling.
"""
from __future__ import annotations

import py_compile
import subprocess
import sys

import pytest

from conftest import REPO_ROOT

CI = (REPO_ROOT / ".github" / "workflows" / "ci.yml").read_text()
DOCS_PY = sorted(REPO_ROOT.glob("docs/**/*.py"))


def test_the_sweep_step_exists_by_name():
    """Item 7's detect. The step name is what a reader of a red run sees."""
    assert "name: py_compile sweep of docs/" in CI
    assert "python3 -m py_compile" in CI


def test_the_sweep_refuses_an_empty_corpus():
    """Note 88, in the workflow itself: a sweep of nothing is not a pass."""
    step = CI.split("name: py_compile sweep of docs/", 1)[1].split("- name:", 1)[0]
    assert 'if [ "$count" -eq 0 ]' in step
    assert "::error::" in step, "an empty corpus must fail the run, not warn"


def test_the_docs_corpus_is_not_empty():
    print(f"docs corpus: {len(DOCS_PY)} Python file(s)")
    assert len(DOCS_PY) >= 1, "nothing under docs/ to sweep"


def test_every_docs_module_compiles():
    """Run here too, so a local run catches it before CI does."""
    broken = []
    for path in DOCS_PY:
        try:
            py_compile.compile(str(path), cfile=str(path) + "c", doraise=True)
        except py_compile.PyCompileError as exc:
            broken.append(f"{path.relative_to(REPO_ROOT)}: {exc.msg.splitlines()[0]}")
        finally:
            (path.parent / (path.name + "c")).unlink(missing_ok=True)
    assert broken == [], broken
    assert len(DOCS_PY) >= 1


def test_there_is_no_python_linter_in_ci_so_the_sweep_is_the_gate():
    """The reason the sweep exists HERE, which is not the template's reason.

    The template's premise is a `.flake8` that excludes `docs/*/`. This fork
    has no flake8, no ruff and no lint config at all, so the premise to pin
    is the absence itself. If a linter is ever added, this goes red and the
    next seat gets to decide whether the sweep is still the only gate or has
    become the second opinion — either is fine, but it should be a decision.
    """
    configs = [p.name for p in (
        REPO_ROOT / ".flake8", REPO_ROOT / "setup.cfg", REPO_ROOT / "tox.ini",
        REPO_ROOT / "ruff.toml", REPO_ROOT / ".ruff.toml",
    ) if p.exists()]
    assert configs == [], (
        f"a lint config appeared ({configs}) — re-read item 7's premise"
    )

    pyproject = (REPO_ROOT / "pyproject.toml").read_text()
    assert "[tool.ruff" not in pyproject and "[tool.flake8" not in pyproject

    # COMMENTS STRIPPED FIRST, and this test needed it on its very first run
    # (item 13, exactly as written): the py_compile step's own comment
    # explains that there is no flake8 here, so a raw grep matched the prose
    # documenting the absence of the thing it was hunting and reported the
    # defect it was describing. The better the comment, the more reliably a
    # raw grep lies about it.
    lint_job = CI.split("lint:", 1)[1].split("site-tests:", 1)[0]
    lint_code = "\n".join(
        line for line in lint_job.splitlines()
        if not line.lstrip().startswith("#")
    )
    for linter in ("flake8", "ruff", "pylint"):
        assert linter not in lint_code, (
            f"{linter} appeared in CI's lint job — the sweep is no longer the "
            "only reader of docs/"
        )


def test_py_compile_catches_a_broken_docs_file():
    """The teeth, measured rather than believed, needing only the interpreter."""
    probe = REPO_ROOT / "docs" / "_pycompile_probe_tmp.py"
    probe.write_text("def broken(:\n    pass\n")
    try:
        compiled = subprocess.run([sys.executable, "-m", "py_compile", str(probe)],
                                  cwd=REPO_ROOT, capture_output=True, text=True)
    finally:
        probe.unlink(missing_ok=True)
        for cached in (REPO_ROOT / "docs").glob("__pycache__/_pycompile_probe_tmp*"):
            cached.unlink(missing_ok=True)

    assert compiled.returncode != 0 and "SyntaxError" in compiled.stderr


def test_the_sweep_command_itself_would_fail_on_that_file():
    """Not just py_compile — the exact `find | xargs` shape CI runs.

    A step that swept the file but swallowed the exit code would still be
    green, which is the family this whole item belongs to.

    TWO GUARDS, both added after ops' 2026-09-05 sweep for tests that shell
    out to tools CI's test job may not install:

    * the tools this shape needs are checked for FIRST and the test SKIPS
      with the reason if any is missing — never passes;
    * a non-zero exit is not enough. If `python3` were absent, `xargs` would
      fail for that reason and a bare `returncode != 0` would go green
      having measured nothing. The assertion is on the SyntaxError.
    """
    import shutil

    for tool in ("bash", "find", "xargs", "python3"):
        if shutil.which(tool) is None:
            pytest.skip(f"{tool} is not on PATH here — CI's runner has it; "
                        "this shape cannot be measured on this machine")

    probe = REPO_ROOT / "docs" / "_sweep_probe_tmp.py"
    probe.write_text("def broken(:\n    pass\n")
    try:
        swept = subprocess.run(
            ["bash", "-c",
             "find docs -name '*.py' -print0 | xargs -0 python3 -m py_compile"],
            cwd=REPO_ROOT, capture_output=True, text=True)
    finally:
        probe.unlink(missing_ok=True)
        for cached in (REPO_ROOT / "docs").glob("__pycache__/_sweep_probe_tmp*"):
            cached.unlink(missing_ok=True)
        for cached in REPO_ROOT.glob("docs/**/__pycache__/_sweep_probe_tmp*"):
            cached.unlink(missing_ok=True)

    assert swept.returncode != 0, (
        "the sweep command exited 0 with a syntactically broken file in "
        "docs/ — the pipe is swallowing the failure"
    )
    assert "SyntaxError" in (swept.stderr + swept.stdout), (
        "the sweep failed, but not because of the broken file — a missing "
        "tool would fail the same way and this test would be green for the "
        f"wrong reason. Got: {(swept.stderr or swept.stdout)[:200]!r}"
    )


def test_no_page_module_emits_a_second_h1():
    """Item 7's rider: a page emitting its own `Title(order=1)` under
    markdown.py's order=2 renders a double heading.

    Asserted structurally rather than by grep, because a page NOT rendered
    through markdown.py is entitled to its own order=1. The invariant is one
    h1 per page (tests/test_pages.py holds that on the rendered document);
    here the markdown lane's wrapper is held to order=2 so the two cannot
    both claim it.
    """
    markdown = (REPO_ROOT / "pages" / "markdown.py").read_text()
    assert "dmc.Title(metadata.name, order=2" in markdown, (
        "the markdown wrapper's heading level moved — every docs page's "
        "heading structure moved with it"
    )
    for page in ("changelog.py", "api.py", "traffic.py", "control_board.py"):
        # Comments stripped first (item 13): these pages' raw source contains
        # "markdown.py" in comments explaining how they differ from it, so a
        # file-scoped grep reports the defect it is describing.
        src = "\n".join(
            line for line in (REPO_ROOT / "pages" / page).read_text().splitlines()
            if not line.lstrip().startswith("#")
        )
        if "order=1" in src:
            imports_markdown = any(
                line.startswith(("import ", "from "))
                and "pages.markdown" in line.replace("/", ".")
                for line in src.splitlines()
            )
            assert not imports_markdown, (
                f"pages/{page} emits order=1 AND renders through markdown.py"
            )
