---
name: "Home"
description: "IDE-style dockable, resizable and floatable window panels for Plotly Dash — drag tabs between tabsets, split panes, collapse edge sidebars, and pop tabs into their own window."
endpoint: "/"
package: flexlayout_dash
category: "Start here"
icon: "tabler:home"
---

.. llms_copy::Home

# flexlayout-dash — resizable panel layouts for Dash

> **IDE-style dockable, resizable, and floatable window panels for Plotly Dash.**

`flexlayout-dash` wraps [FlexLayout-React](https://github.com/caplin/FlexLayout) to give
your Dash apps drag-and-drop tabs, splittable panes, collapsible border sidebars, and
pop-out windows — with seamless Dash Mantine Components light/dark theming and full
callback support via portal-based rendering.

Drag a tab onto another panel, or onto an edge, and the dock rearranges. Nothing
re-mounts, so callbacks inside a panel keep running.

.. exec::docs.home.example

---

## Install

```bash
pip install flexlayout-dash
```

```python
import flexlayout_dash as dfl
```

> The Python import name is `flexlayout_dash` (as of 1.1.0); the PyPI package is `flexlayout-dash`.

---

## Documentation

- **[Getting Started](/getting-started)** — your first dockable layout in a few lines.
- **[Component Reference](/reference)** — every prop on `DashFlexLayout` and `Tab`.
- **[Basic Layouts](/basic)** — rows, columns, nested splits, and multi-tab tabsets.
- **[Borders & Sidebars](/borders)** — collapsible left/right/bottom panels.
- **[Theming](/theming)** — automatic Mantine light/dark integration.
- **[Callbacks](/callbacks)** — reading layout state and driving content from callbacks.

---

## Why flexlayout-dash?

- **Dockable & draggable** — rearrange tabs between tabsets by dragging.
- **Resizable & floatable** — drag splitters; pop tabs out into floating windows.
- **Border sidebars** — VS Code-style collapsible panels on the edges.
- **Theme-aware** — follows `data-mantine-color-scheme` automatically.
- **Callback-friendly** — portal-based rendering keeps tab content mounted so your
  Dash callbacks keep working.
- **One build, no tiers** — no tab limit, no licence key, MIT licensed.
