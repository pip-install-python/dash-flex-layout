---
name: Component Reference
description: Every prop on DashFlexLayout and Tab, plus the model schema.
endpoint: /reference
icon: mdi:book-open-variant
lastmod: 2026-08-01
---

.. llms_copy::Component Reference

.. toc::

### DashFlexLayout

The main container. Pass a `model` (the layout tree) and a list of `Tab` children.

.. kwargs::flexlayout_dash.DashFlexLayout

### Tab

A content wrapper. Its `id` must match a `tab` `id` in the model.

.. kwargs::flexlayout_dash.Tab

### Model schema

The `model` is FlexLayout's JSON. Its top-level keys are:

- **`global`** — default behaviours applied to every tab/tabset, e.g.
  `tabEnableClose`, `tabEnableFloat`, `tabEnableRenderOnDemand`, `splitterSize`,
  `borderSize`, `tabSetEnableMaximize`.
- **`borders`** — optional collapsible edge panels; each has a
  `location` of `"left"`, `"right"`, or `"bottom"` (see [Borders & Sidebars](/borders)).
- **`layout`** — the panel tree built from nodes:
  - `row` / `column` — split containers (children laid out horizontally / vertically)
  - `tabset` — a group of tabs with a tab strip
  - `tab` — a single tab (`name`, `id`, and optional per-tab overrides)

```python
model = {
    "global": {"tabEnableClose": False, "tabEnableFloat": True},
    "borders": [
        {"type": "border", "location": "left", "size": 220, "children": [
            {"type": "tab", "name": "Explorer", "id": "explorer"},
        ]},
    ],
    "layout": {
        "type": "row",
        "children": [
            {"type": "tabset", "weight": 50, "children": [
                {"type": "tab", "name": "Panel 1", "id": "panel-1"},
            ]},
            {"type": "tabset", "weight": 50, "children": [
                {"type": "tab", "name": "Panel 2", "id": "panel-2"},
            ]},
        ],
    },
}
```

> Tip: set `"tabEnableRenderOnDemand": False` in `global` to keep every tab mounted —
> important when tab content drives Dash callbacks.
