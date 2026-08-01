# Dash Flex Layout - Skills Guide

A comprehensive guide for using `dash-flex-layout` to create flexible, dockable layouts in Dash applications.

## Table of Contents

1. [Installation](#installation)
2. [Quick Start](#quick-start)
3. [Core Concepts](#core-concepts)
4. [Model Configuration](#model-configuration)
5. [Component Props](#component-props)
6. [Layout Types](#layout-types)
7. [Borders (Sidebars)](#borders-sidebars)
8. [Theming](#theming)
9. [Callbacks](#callbacks)
10. [Advanced Patterns](#advanced-patterns)
11. [Troubleshooting](#troubleshooting)

---

## Installation

```bash
pip install flexlayout-dash
```

**Requirements:**
- Python >= 3.7
- Dash >= 2.0
- dash-mantine-components (recommended for theming)

---

## Quick Start

```python
import dash
from dash import html
import flexlayout_dash as dfl
import dash_mantine_components as dmc

app = dash.Dash(__name__, external_stylesheets=[dmc.styles.ALL])

# Define the layout model
model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True
    },
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Panel 1", "id": "panel-1"}
                ]
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Panel 2", "id": "panel-2"}
                ]
            }
        ]
    }
}

# Define tab content
tabs = [
    dfl.Tab(id="panel-1", children=[html.H3("Panel 1 Content")]),
    dfl.Tab(id="panel-2", children=[html.H3("Panel 2 Content")]),
]

# App layout
app.layout = dmc.MantineProvider(
    html.Div([
        dfl.DashFlexLayout(
            id='flex-layout',
            model=model,
            children=tabs,
            useStateForModel=True
        )
    ], style={"height": "100vh"})
)

if __name__ == '__main__':
    app.run(debug=True)
```

---

## Core Concepts

### Components

| Component | Description |
|-----------|-------------|
| `DashFlexLayout` | Main container component that renders the dockable layout |
| `Tab` | Wrapper for content that goes inside each tab/panel |

### Architecture

```
DashFlexLayout
├── model (JSON configuration)
│   ├── global (settings)
│   ├── borders (optional sidebars)
│   └── layout (panel structure)
└── children (Tab components)
    ├── Tab(id="panel-1")
    ├── Tab(id="panel-2")
    └── ...
```

**Key Rule:** Each `Tab` component's `id` must match a tab `id` in the model configuration.

---

## Model Configuration

The model is a JSON object that defines the layout structure.

### Global Settings

```python
model = {
    "global": {
        # Tab behavior
        "tabEnableClose": False,        # Allow closing tabs
        "tabEnableFloat": True,         # Allow floating tabs as windows
        "tabEnableMaximize": True,      # Allow maximizing tabsets
        "tabEnableDrag": True,          # Allow dragging tabs
        "tabEnableRename": False,       # Allow renaming tabs

        # Render behavior
        "tabEnableRenderOnDemand": False,  # Keep all tabs mounted (important for callbacks!)

        # Tabset defaults
        "tabSetEnableMaximize": True,
        "tabSetEnableClose": False,
        "tabSetEnableDrop": True,

        # Splitter settings
        "splitterSize": 8,              # Splitter drag handle size
        "splitterExtra": 4,             # Extra splitter hit area

        # Border defaults
        "borderSize": 200,              # Default border panel size
        "borderMinSize": 100,           # Minimum border size
    },
    "layout": { ... }
}
```

### Layout Structure

```python
"layout": {
    "type": "row",           # "row" (horizontal) or "column" (vertical)
    "weight": 100,           # Relative size weight
    "children": [
        {
            "type": "tabset",    # Container for tabs
            "weight": 50,        # Takes 50% of parent
            "selected": 0,       # Initially selected tab index
            "children": [
                {
                    "type": "tab",
                    "name": "Tab Name",      # Display name
                    "id": "unique-id",       # Must match Tab component id
                    "component": "text",     # Component type (optional)
                    "enableClose": True,     # Override global setting
                    "enableFloat": True,     # Override global setting
                }
            ]
        }
    ]
}
```

---

## Component Props

### DashFlexLayout Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `id` | string | - | Unique identifier for callbacks |
| `model` | dict | **required** | Layout configuration object |
| `children` | list | **required** | List of `Tab` components |
| `headers` | dict | `{}` | Custom header components for tabs |
| `useStateForModel` | bool | `False` | Use internal state (recommended: `True`) |
| `style` | dict | `{}` | CSS styles for container |
| `colorScheme` | string | auto | `'light'` or `'dark'` theme |
| `realtimeResize` | bool | `False` | Resize during drag (can be choppy) |
| `supportsPopout` | bool | auto | Enable pop-out windows |
| `popoutURL` | string | `/assets/popout.html` | Pop-out window URL |
| `debugMode` | bool | `False` | Enable debug logging |

### Tab Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `id` | string | **required** | Must match tab id in model |
| `children` | list | - | Dash components to render |

---

## Layout Types

### Horizontal Split (Row)

```python
"layout": {
    "type": "row",
    "children": [
        {"type": "tabset", "weight": 30, "children": [...]},  # Left 30%
        {"type": "tabset", "weight": 70, "children": [...]},  # Right 70%
    ]
}
```

### Vertical Split (Column)

```python
"layout": {
    "type": "column",
    "children": [
        {"type": "tabset", "weight": 40, "children": [...]},  # Top 40%
        {"type": "tabset", "weight": 60, "children": [...]},  # Bottom 60%
    ]
}
```

### Nested Layout

```python
"layout": {
    "type": "row",
    "children": [
        {
            "type": "column",
            "weight": 60,
            "children": [
                {"type": "tabset", "weight": 70, "children": [...]},  # Top-left
                {"type": "tabset", "weight": 30, "children": [...]},  # Bottom-left
            ]
        },
        {"type": "tabset", "weight": 40, "children": [...]},  # Right sidebar
    ]
}
```

### Multiple Tabs in Tabset

```python
{
    "type": "tabset",
    "selected": 0,  # First tab selected
    "children": [
        {"type": "tab", "name": "Tab A", "id": "tab-a"},
        {"type": "tab", "name": "Tab B", "id": "tab-b"},
        {"type": "tab", "name": "Tab C", "id": "tab-c"},
    ]
}
```

---

## Borders (Sidebars)

Borders are collapsible sidebars on the edges of the layout.

```python
model = {
    "global": {...},
    "borders": [
        {
            "type": "border",
            "location": "left",      # "left", "right", or "bottom"
            "size": 250,             # Width/height in pixels
            "selected": 0,           # Initially selected tab
            "children": [
                {"type": "tab", "name": "Explorer", "id": "explorer"},
                {"type": "tab", "name": "Search", "id": "search"},
            ]
        },
        {
            "type": "border",
            "location": "bottom",
            "size": 150,
            "children": [
                {"type": "tab", "name": "Terminal", "id": "terminal"},
            ]
        }
    ],
    "layout": {...}
}
```

**Border Locations:**
- `"left"` - Left sidebar
- `"right"` - Right sidebar
- `"bottom"` - Bottom panel (no top border supported)

---

## Theming

### Automatic Theme Detection

DashFlexLayout automatically detects Mantine's color scheme:

```python
app.layout = dmc.MantineProvider(
    html.Div([
        # Theme toggle
        dmc.Switch(id="theme-toggle"),

        # Layout adapts automatically
        dfl.DashFlexLayout(
            id='layout',
            model=model,
            children=tabs,
        )
    ])
)
```

### CSS Classes

Apply custom themes using CSS classes:

| Class | Description |
|-------|-------------|
| `.dash-dock-container` | Main container |
| `.dash-dock-light` | Light theme applied |
| `.dash-dock-dark` | Dark theme applied |

### Custom Styling

```css
/* Custom dark theme */
.dash-dock-dark .flexlayout__tabset {
    background: #1a1a2e;
}

.dash-dock-dark .flexlayout__tab {
    background: #16213e;
    color: #eee;
}

/* Liquid Glass effect */
.dash-dock-liquid-glass-dark .flexlayout__tabset {
    background: rgba(30, 30, 35, 0.65);
    backdrop-filter: blur(16px) saturate(180%);
    border: 1px solid rgba(255, 255, 255, 0.1);
}
```

---

## Callbacks

### Reading Layout State

```python
from dash import callback, Input, Output
import json

@callback(
    Output('layout-display', 'children'),
    Input('flex-layout', 'model')
)
def show_layout(model):
    return json.dumps(model, indent=2)
```

### Important: Keep Tabs Mounted

For callbacks to work reliably, disable render-on-demand:

```python
model = {
    "global": {
        "tabEnableRenderOnDemand": False,  # IMPORTANT!
    },
    ...
}
```

### Callbacks Inside Tabs

```python
tabs = [
    dfl.Tab(id="controls", children=[
        dmc.Select(id="chart-type", data=["Line", "Bar"], value="Line"),
    ]),
    dfl.Tab(id="chart", children=[
        html.Div(id="chart-output")
    ]),
]

@callback(
    Output('chart-output', 'children'),
    Input('chart-type', 'value')
)
def update_chart(chart_type):
    return f"Selected: {chart_type}"
```

### Custom Tab Headers

```python
from dash_iconify import DashIconify

custom_headers = {
    "explorer": html.Div([
        DashIconify(icon="mdi:folder", width=16),
        " Explorer"
    ], style={"display": "flex", "alignItems": "center"}),

    "terminal": html.Div([
        DashIconify(icon="mdi:console", width=16),
        " Terminal"
    ], style={"display": "flex", "alignItems": "center"}),
}

dfl.DashFlexLayout(
    id='layout',
    model=model,
    children=tabs,
    headers=custom_headers,
)
```

---

## Advanced Patterns

### IDE-Style Layout

```python
ide_model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        "tabSetEnableMaximize": True,
        "tabEnableRenderOnDemand": False,
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 200,
            "children": [
                {"type": "tab", "name": "Explorer", "id": "explorer"},
                {"type": "tab", "name": "Search", "id": "search"},
            ]
        },
        {
            "type": "border",
            "location": "bottom",
            "size": 150,
            "children": [
                {"type": "tab", "name": "Terminal", "id": "terminal"},
                {"type": "tab", "name": "Output", "id": "output"},
            ]
        },
        {
            "type": "border",
            "location": "right",
            "size": 200,
            "children": [
                {"type": "tab", "name": "Properties", "id": "properties"},
            ]
        }
    ],
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 70,
                "children": [
                    {"type": "tab", "name": "Editor", "id": "editor"},
                    {"type": "tab", "name": "Preview", "id": "preview"},
                ]
            },
            {
                "type": "tabset",
                "weight": 30,
                "children": [
                    {"type": "tab", "name": "Outline", "id": "outline"},
                ]
            }
        ]
    }
}
```

### Dashboard Layout

```python
dashboard_model = {
    "global": {"tabEnableClose": False},
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "column",
                "weight": 70,
                "children": [
                    {
                        "type": "tabset",
                        "weight": 60,
                        "children": [
                            {"type": "tab", "name": "Main Chart", "id": "main-chart"}
                        ]
                    },
                    {
                        "type": "row",
                        "weight": 40,
                        "children": [
                            {"type": "tabset", "weight": 50, "children": [
                                {"type": "tab", "name": "KPI 1", "id": "kpi-1"}
                            ]},
                            {"type": "tabset", "weight": 50, "children": [
                                {"type": "tab", "name": "KPI 2", "id": "kpi-2"}
                            ]},
                        ]
                    }
                ]
            },
            {
                "type": "tabset",
                "weight": 30,
                "children": [
                    {"type": "tab", "name": "Filters", "id": "filters"},
                    {"type": "tab", "name": "Details", "id": "details"},
                ]
            }
        ]
    }
}
```

### Full Height Container

```python
app.layout = dmc.MantineProvider(
    html.Div([
        dfl.DashFlexLayout(
            id='layout',
            model=model,
            children=tabs,
            useStateForModel=True,
        )
    ], style={
        "height": "100vh",
        "width": "100%",
        "position": "absolute",
        "top": 0,
        "left": 0,
    })
)
```

---

## Troubleshooting

### Issue: Callbacks not firing

**Solution:** Set `tabEnableRenderOnDemand: False` in global settings to keep all tabs mounted.

### Issue: Tab content not showing

**Solution:** Ensure each `Tab` component's `id` exactly matches a tab `id` in the model.

```python
# Model
{"type": "tab", "name": "My Tab", "id": "my-tab"}

# Tab component
dfl.Tab(id="my-tab", children=[...])  # IDs must match!
```

### Issue: Layout not filling container

**Solution:** Set explicit height on parent container:

```python
html.Div([
    dfl.DashFlexLayout(...)
], style={"height": "500px"})  # Or "100vh" for full viewport
```

### Issue: Theme not updating

**Solution:** Ensure you're using `dmc.MantineProvider` and the theme toggle sets `data-mantine-color-scheme` on the HTML element.

### Issue: Choppy resizing

**Solution:** Keep `realtimeResize=False` (default) for smoother performance.

### Issue: Tab content resets or flashes on tab switch / splitter drag

**Solution:** Fixed in `flexlayout-dash>=1.1.0`. With `useStateForModel=False`, FlexLayout's own
internal changes used to round-trip through the `model` prop and recreate the layout model,
re-mounting every tab's content and resetting stateful children (canvases, editors, in-progress
drags). The component now skips re-creating the model for echoes of FlexLayout's internal changes,
so stateful tab children stay mounted; only a model written by your *own* Dash callbacks rebuilds
the layout. Upgrade if you see this. (Note: the import name is `flexlayout_dash` as of 1.1.0.)

---

## API Reference

### Model JSON Schema

```python
{
    "global": {
        # Tab settings
        "tabEnableClose": bool,
        "tabEnableFloat": bool,
        "tabEnableDrag": bool,
        "tabEnableMaximize": bool,
        "tabEnableRename": bool,
        "tabEnableRenderOnDemand": bool,
        "tabClassName": str,
        "tabIcon": str,

        # TabSet settings
        "tabSetEnableClose": bool,
        "tabSetEnableDrop": bool,
        "tabSetEnableMaximize": bool,
        "tabSetEnableDrag": bool,
        "tabSetEnableDivide": bool,
        "tabSetEnableTabStrip": bool,
        "tabSetClassNameTabStrip": str,
        "tabSetClassNameHeader": str,

        # Border settings
        "borderSize": int,
        "borderMinSize": int,
        "borderBarSize": int,
        "borderEnableDrop": bool,

        # Splitter settings
        "splitterSize": int,
        "splitterExtra": int,
        "enableEdgeDock": bool,
    },
    "borders": [
        {
            "type": "border",
            "location": "left" | "right" | "bottom",
            "size": int,
            "selected": int,
            "show": bool,
            "children": [...]
        }
    ],
    "layout": {
        "type": "row" | "column",
        "weight": int,
        "children": [
            {
                "type": "tabset",
                "weight": int,
                "selected": int,
                "maximized": bool,
                "children": [
                    {
                        "type": "tab",
                        "name": str,
                        "id": str,
                        "component": str,
                        "enableClose": bool,
                        "enableFloat": bool,
                        "enableDrag": bool,
                        "enableRename": bool,
                    }
                ]
            }
        ]
    }
}
```

---

## Resources

- [FlexLayout-React Documentation](https://github.com/caplin/FlexLayout)
- [Dash Documentation](https://dash.plotly.com/)
- [Dash Mantine Components](https://www.dash-mantine-components.com/)
- [GitHub Repository](https://github.com/pip-install-python/dash-flex-layout)

---

**License:** MIT | **Author:** [Pip Install Python](https://pip-install-python.com)