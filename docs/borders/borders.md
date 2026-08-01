---
name: Borders & Sidebars
description: Collapsible left, right, and bottom edge panels.
endpoint: /borders
icon: mdi:dock-left
---

.. llms_copy::Borders & Sidebars

.. toc::

## Border panels

Borders are collapsible panels docked to the edges of the layout — think VS Code's
Explorer, Search, and Terminal. They live in the top-level `borders` list, each with a
`location` of `"left"`, `"right"`, or `"bottom"` (there is no top border).

Border tabs start collapsed; click a tab name on an edge to slide the panel open, and
click again to collapse it.

.. exec::docs.borders.example

## Notes

- `size` sets the panel's width (left/right) or height (bottom) in pixels.
- `borderSize` / `borderMinSize` in `global` set defaults across all borders.
- Each border can hold multiple tabs (the left border above stacks Explorer and Search).
