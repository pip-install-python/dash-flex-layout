"""`.. exec::` reaches the machine lane — the fourth empty-page mechanism,
this fork's own instance (item 18 amendment, 2026-08-31).

The shape is always the same — a markdown2dash directive that renders Dash
components (BlockExec) puts its output only in the React tree, while the
machine lane, the prerender and the crawler HTML are built from the
markdown SOURCE, where the directive line is silently dropped by
dash-improve-my-llms' own machine-lane rendering (it does not recognise
`.. exec::` and drops any `.. ` line it cannot handle). The page looks
perfect in a browser the entire time.

Measured HERE before the fix: `/basic/llms.txt` was 1256 bytes and read
"...maximize a tabset with the button." straight into "### Notes" — the
entire live-demo source between them (all of docs/basic/example.py) gone.
All SIX of this fork's `.. exec::` directives had the same shape: unfenced,
no `.. source::` pairing, no `:code: false` flag — so all six now expand.

A NOTE ON HOW THIS FILE IS WRITTEN. Every content pin here is
mutation-checked, and the fixtures carry the NEGATIVE cases (fenced,
differently-targeted) rather than only the happy one — the discipline the
item's own drop insisted on after finding pins elsewhere that could not go
red (a heading asserted instead of rows, a substring counted instead of an
element).
"""

from __future__ import annotations

import re
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parent.parent


# --------------------------------------------------------------- unit --


UNPAIRED = """# Page

Some prose.

.. exec::docs.basic.example

More prose.
"""

# `:code: false` is the author saying "this module is plumbing for an
# embed, not documentation". Rendering it into the machine lane publishes
# what the browser lane deliberately hides — and silently, because the
# browser keeps looking right.
HIDDEN = """# Page

.. exec::docs.basic.example
    :code: false

More prose.
"""

PAIRED = """# Page

.. exec::docs.basic.example

Source code:

.. source::docs/basic/example.py
"""

# The case that makes the dedupe safe: a `.. source::` IS present, but for
# a DIFFERENT target. Deduping on "any source nearby" would swallow
# exactly the unpaired directive the rule exists to catch.
DIFFERENT_TARGET = """# Page

.. exec::docs.basic.example

.. source::docs/borders/example.py
"""

FENCED = """# Page

Here is how you write one:

```markdown
.. exec::docs.basic.example
```

That was documentation.
"""


def _expand(text: str) -> str:
    """The real pipeline order (pages/markdown.py): exec runs BEFORE
    source. `_expand_exec_directives`'s dedupe scan looks for
    `.. source::` lines naming its own target in the RAW text it
    receives — if source ran first, every `.. source::` line would
    already be a fenced block and dedupe would find nothing, silently
    doubling every hand-paired page's source. pages.markdown registers a
    page at import, so it cannot be imported until the app exists — every
    caller here takes the `app_module` fixture first."""
    from pages.markdown import _expand_exec_directives, _expand_source_directives

    return _expand_source_directives(_expand_exec_directives(text))


def _needle() -> str:
    """A real line from the module, read at run time.

    Never a literal: a hardcoded expectation drifts out of the file it
    claims to be about and the pin quietly starts proving nothing.

    Fork-invariant shape: first top-level `def`, ELSE first top-level
    assignment (this fork's own example.py files open with `model = {`,
    not a `def`). Multi-line-string openers are skipped.
    """
    src = (REPO / "docs" / "basic" / "example.py").read_text()
    lines = src.split("\n")
    for line in lines:
        if line.startswith("def "):
            return line
    for line in lines:
        if re.match(r"^\w+\s*=", line) and not re.search(r'=\s*("""|\'\'\')', line):
            return line
    pytest.fail("no top-level def or assignment in the module to anchor the pin on")


def test_the_needle_is_really_in_the_module():
    """Non-vacuity for every assertion below."""
    assert _needle() == "def _panel(text):"


def test_an_unpaired_exec_renders_its_module_source(app_module):
    out = _expand(UNPAIRED)
    assert _needle() in out, "the exec'd component's code never reached the prose"
    assert "```python" in out
    assert ".. exec::" not in out, "the raw directive line survived into the prose"


def test_a_code_false_directive_withholds_the_source_but_says_so(app_module):
    """The author's signal is honoured, and the gap is VISIBLE.

    Skipping silently would leave the same shape as the defect: a machine
    document with nothing where a component is. Broken, hidden and absent
    must not look alike.
    """
    out = _expand(HIDDEN)
    assert _needle() not in out, "`:code: false` source was published to the machine lane"
    assert "source withheld" in out and "example.py" in out, (
        "the withheld component left no trace at all"
    )
    # Line-exact, not a substring: the marker itself quotes `:code: false`,
    # so a substring assertion matches the pin's own output.
    assert not any(ln.strip() == ":code: false" for ln in out.split("\n")), (
        "the directive's option line was left behind as prose"
    )


def test_a_paired_exec_renders_once_not_twice(app_module):
    """The dedupe rule. Auto-expansion must not double what a hand-paired
    `.. source::` already provides."""
    out = _expand(PAIRED)
    assert out.count("# File: docs/basic/example.py") == 1, (
        "the hand-paired page shows its source twice"
    )
    assert _needle() in out
    assert ".. exec::" not in out


def test_a_source_for_a_different_target_does_not_dedupe(app_module):
    """The case that keeps the dedupe honest."""
    out = _expand(DIFFERENT_TARGET)
    assert out.count("# File: docs/basic/example.py") == 1, (
        "an unrelated `.. source::` suppressed the auto-render"
    )


def test_a_fenced_exec_stays_documentation(app_module):
    """Fence-awareness, carried over WITH the fix shape.

    A directive inside a ``` block teaches the syntax. Expanding it there
    injects a fence inside an open fence and closes it early — the same
    class of defect `_expand_source_directives` already guards against.
    """
    out = _expand(FENCED)
    assert ".. exec::docs.basic.example" in out, "documentation was expanded"
    assert _needle() not in out


def test_a_missing_exec_target_says_so_instead_of_vanishing(app_module):
    """Broken and empty must not look alike."""
    out = _expand(".. exec::docs.nope.missing_module\n")
    assert "<!-- Error" in out and "missing_module" in out


# --------------------------------------------------- the live registry --


def test_every_exec_in_this_repos_docs_reaches_the_machine_lane(client, app_module):
    """The pages themselves, not a fixture.

    Content, never a heading: the heading was present on the wire the whole
    time /basic served zero lines of the component it describes.
    """
    checked = 0
    for md in sorted((REPO / "docs").rglob("*.md")):
        fence = None
        for line in md.read_text().split("\n"):
            head = line.lstrip()[:3]
            if fence is None and head in ("```", "~~~"):
                fence = head
                continue
            if fence is not None and head == fence:
                fence = None
                continue
            if fence is not None:
                continue
            m = re.match(r"^\.\. exec::(.+?)$", line)
            if not m:
                continue
            target = REPO / (m.group(1).strip().replace(".", "/") + ".py")
            body = md.read_text()
            # `.strip("\"'")` — docs/home/home.md quotes its endpoint
            # (`endpoint: "/"`), and without stripping, the URL built is
            # `/"/"/llms.txt` — "llms.txt not available" reads as a
            # mechanism-4 leak on a page the fix already covers.
            endpoint = re.search(r"^endpoint:\s*(\S+)", body, re.M).group(1).strip("\"'")
            url = f"{endpoint.rstrip('/') or ''}/llms.txt" if endpoint != "/" else "/llms.txt"
            doc = client.get(url).text
            anchors = [
                ln for ln in target.read_text().split("\n")
                if ln.startswith("def ") or re.match(r"^\w+\s*=", ln)
            ]
            assert anchors, f"{target} has no anchor line to check"
            withheld = "source withheld" in doc and target.name in doc
            assert anchors[0] in doc or withheld, (
                f"{url} carries neither {target.name}'s code nor a withheld "
                f"marker for it — mechanism 4"
            )
            checked += 1
    assert checked >= 3, f"only {checked} exec directives walked; the sweep found nothing"


def test_the_exec_pin_goes_red_when_the_expansion_is_disabled(app_module, monkeypatch):
    """THE MUTATION CHECK. A lane pin that cannot fail certifies whatever is
    there — which is how this class survived on six other forks under a
    green suite."""
    import pages.markdown as md

    monkeypatch.setattr(md, "_EXEC_DIRECTIVE", re.compile(r"^(?!x)x$"))
    out = md._expand_exec_directives(UNPAIRED)
    assert _needle() not in out, (
        "disabling the expansion changed nothing — the pin above is vacuous"
    )
