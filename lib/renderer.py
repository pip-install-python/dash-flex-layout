"""Markdown renderer with markdown2dash's inline-element DOM bug fixed.

The bug (markdown2dash 0.1.2, `src/renderer.py`)
------------------------------------------------
Its inline renderers return `dmc.Text`, which renders a **`<p>`**::

    def strong(self, text):    return dmc.Text(text, fw="bold", display="inline")
    def emphasis(self, text):  return dmc.Text(text, fs="italic", display="inline")
    def strikethrough(self, t): return dmc.Text(t, td="line-through")

and `paragraph()` returns `dmc.Text(text)` — also a `<p>`. So any paragraph
containing `**bold**`, `*italic*` or `~~struck~~` nests a `<p>` inside a `<p>`,
which is invalid HTML. React says so on every page load::

    Warning: validateDOMNesting(...): <p> cannot appear as a descendant of <p>.

`display="inline"` makes it *look* right, but the element is still a `<p>`; the
CSS is treating the symptom. On this site it fired on `/`, `/basic`,
`/callbacks` and `/getting-started` — the blockquote hit on `/` was the same
cause, a `**bold**` span inside the quoted paragraph, not the blockquote itself.

`dmc.Text` has a `span` prop that renders a `<span>` instead, which is what
these three should have used. That is the whole fix.

This is upstream and version-pinned to markdown2dash, so **every site built on
the boilerplate has it**. Fixing it here rather than upstream keeps the change
local; the rendering is visually identical, because `display="inline"` was
already forcing inline layout.

`create_parser` hard-codes `renderer=DashRenderer()` with no injection point,
so this module re-implements it around the patched subclass. Keep the plugin
list in step with `markdown2dash.src.parser.create_parser` on upgrade — and
re-check whether the upstream fix landed, in which case delete this file.
"""
from __future__ import annotations

from typing import List, Optional

import mistune
from markdown2dash.src.renderer import DashRenderer
from mistune.directives import RSTDirective


class PatchedDashRenderer(DashRenderer):
    """DashRenderer with inline elements emitting `<span>` rather than `<p>`.

    Each override delegates to `super()` first so the upstream `@class_name`
    decorator still stamps its className, then flips the returned component to
    a span. Re-implementing the bodies would silently drop that class the next
    time upstream changed it.
    """

    @staticmethod
    def _inline(component):
        component.span = True
        # `display="inline"` was the workaround for being a block <p>. A <span>
        # is already inline, and leaving it set would override any `display`
        # a consumer sets in CSS.
        if getattr(component, "display", None) == "inline":
            component.display = None
        return component

    def strong(self, text):
        return self._inline(super().strong(text))

    def emphasis(self, text):
        return self._inline(super().emphasis(text))

    def strikethrough(self, text):
        return self._inline(super().strikethrough(text))


def create_parser(directives: Optional[List] = None):
    """Drop-in replacement for `markdown2dash.create_parser`.

    Mirrors the upstream implementation exactly apart from the renderer class.
    """
    directives = directives or []
    return mistune.create_markdown(
        renderer=PatchedDashRenderer(),
        plugins=[
            "mark",
            "spoiler",
            "strikethrough",
            "table",
            "task_lists",
            RSTDirective(directives),
        ],
    )
