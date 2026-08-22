---
name: Basic Layouts
description: Rows, columns, nested splits, and multi-tab tabsets.
endpoint: /basic
icon: mdi:view-split-vertical
lastmod: 2026-08-01
---

.. llms_copy::Basic Layouts

.. toc::

### Rows, columns, and tabsets

Build layouts by nesting three node types inside `layout`:

- **`row`** — lays its children out left-to-right
- **`column`** — lays its children out top-to-bottom
- **`tabset`** — a group of one or more `tab`s with a tab strip

`weight` controls how much space each child takes relative to its siblings.

The example below puts a **column** (Editor over Output) next to a **tabset** holding
three tabs. Drag tabs between tabsets, drag the splitters, or maximize a tabset with the
⛶ button.

.. exec::docs.basic.example

### Notes

- A `tabset` can hold many `tab`s — they share one tab strip.
- Nest `row` and `column` to any depth for IDE-style layouts.
- `tabSetEnableMaximize` (in `global`) adds the maximize button shown above.
