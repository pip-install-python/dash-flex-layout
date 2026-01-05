"""
Theme Integration

Demonstrates DashDock's Liquid Glass themes inspired by Apple's WWDC 2025 design language.
"""

import dash
from dash import html, callback, Input, Output
import dash_flex_layout
import dash_mantine_components as dmc
from dash_iconify import DashIconify

dash.register_page(__name__, path='/theming', name='Theme Integration')


# ============================================================================
# THEME CONFIGURATION
# ============================================================================

THEMES = [
    {"value": "light", "label": "Light"},
    {"value": "dark", "label": "Dark"},
    {"value": "liquid-glass-light", "label": "Glass Light"},
    {"value": "liquid-glass-dark", "label": "Glass Dark"},
]


def get_container_style(theme):
    """Return container style based on theme."""
    if "liquid-glass" in theme:
        return {
            "background": "linear-gradient(135deg, rgb(88, 88, 88) 0%, rgb(35, 35, 38) 50%, rgb(28, 28, 28) 100%)",
            "borderRadius": "20px",
            "padding": "4px",
        }
    elif "dark" in theme:
        return {
            "background": "#1a1a1a",
            "borderRadius": "12px",
            "padding": "4px",
        }
    else:
        return {
            "background": "#f0f0f0",
            "borderRadius": "12px",
            "padding": "4px",
        }


# ============================================================================
# MODEL CONFIGURATION
# ============================================================================

model = {
    "global": {
        "tabEnableClose": True,
        "tabEnableFloat": True,
        "tabEnableMaximize": True,
        "tabEnableRenderOnDemand": False,
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 200,
            "children": [
                {"type": "tab", "name": "Controls", "id": "controls-panel"}
            ]
        }
    ],
    "layout": {
        "type": "row",
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 60,
                "children": [
                    {"type": "tab", "name": "Chart Preview", "id": "chart-panel"},
                ]
            },
            {
                "type": "tabset",
                "weight": 40,
                "children": [
                    {"type": "tab", "name": "Theme Info", "id": "info-panel"},
                ]
            }
        ]
    }
}


# ============================================================================
# PANEL CONTENTS
# ============================================================================

chart_data = [
    {"month": "Jan", "sales": 1200},
    {"month": "Feb", "sales": 1900},
    {"month": "Mar", "sales": 1600},
    {"month": "Apr", "sales": 2100},
    {"month": "May", "sales": 1800},
    {"month": "Jun", "sales": 2400},
]

panel_contents = [
    dash_flex_layout.Tab(id="controls-panel", children=[
        dmc.Stack([
            dmc.Title("Quick Controls", order=5),
            dmc.Text("Interactive settings", size="xs", c="dimmed"),
            dmc.Divider(my="xs"),
            dmc.Select(
                id="chart-type-select",
                label="Chart Type",
                data=[
                    {"value": "bar", "label": "Bar Chart"},
                    {"value": "line", "label": "Line Chart"},
                ],
                value="bar",
                size="xs",
            ),
            dmc.ColorInput(
                id="chart-color-input",
                label="Chart Color",
                value="#228be6",
                format="hex",
                size="xs",
            ),
        ], gap="sm", p="md")
    ]),

    dash_flex_layout.Tab(id="chart-panel", children=[
        dmc.Box(p="md", h="100%", children=[
            html.Div(id="chart-container", children=[
                dmc.BarChart(
                    id="preview-chart",
                    h=280,
                    data=chart_data,
                    dataKey="month",
                    series=[{"name": "sales", "color": "#228be6"}],
                )
            ]),
        ])
    ]),

    dash_flex_layout.Tab(id="info-panel", children=[
        dmc.Stack([
            dmc.Group([
                DashIconify(icon="mdi:palette", width=24),
                dmc.Title("Theme Info", order=4),
            ], gap="xs"),
            dmc.Text("Current Theme:", size="sm", c="dimmed"),
            dmc.Code(id="current-theme-code", children="liquid-glass-dark"),
            dmc.Divider(my="sm"),
            dmc.Text("Liquid Glass Features:", fw=600, size="sm"),
            dmc.List([
                dmc.ListItem("Backdrop blur (16px)"),
                dmc.ListItem("Transparent backgrounds"),
                dmc.ListItem("Gradient overlays"),
                dmc.ListItem("Layered shadows"),
            ], size="sm", spacing="xs"),
        ], p="md", gap="sm")
    ]),
]


# ============================================================================
# MAIN LAYOUT
# ============================================================================

layout = dmc.Container([
    # Header
    dmc.Group([
        dmc.Title("Theme Integration", order=2),
        dmc.Badge(
            "Apple Liquid Glass",
            variant="gradient",
            gradient={"from": "grape", "to": "pink"},
        ),
    ], justify="space-between", mb="md"),

    # Info Alert
    dmc.Alert(
        [
            "Experience Apple's WWDC 2025 ",
            dmc.Text("Liquid Glass", fw=700, span=True),
            " design language. Select a theme below to see the glassmorphism effect.",
        ],
        title="Interactive Theme Demo",
        color="grape",
        icon=DashIconify(icon="mdi:palette-outline"),
        mb="md",
    ),

    # Theme Selector
    dmc.Paper([
        dmc.Group([
            dmc.Text("Select Theme", fw=600, size="sm"),
            dmc.SegmentedControl(
                id="theme-selector",
                data=THEMES,
                value="liquid-glass-dark",
                style={"flex": 1},
            ),
        ], gap="md"),
    ], withBorder=True, radius="md", p="md", mb="md"),

    # DashDock Preview
    html.Div(
        id="dock-preview-container",
        children=[
            dash_flex_layout.DashFlexLayout(
                id='theme-dock',
                model=model,
                children=panel_contents,
                useStateForModel=True,
            ),
        ],
        className="dash-dock-liquid-glass-dark",
        style={
            "height": "450px",
            "background": "linear-gradient(135deg, rgb(88, 88, 88) 0%, rgb(35, 35, 38) 50%, rgb(28, 28, 28) 100%)",
            "borderRadius": "20px",
            "padding": "4px",
        }
    ),

    # CSS Documentation
    dmc.Title("CSS Variables Reference", order=3, mt="xl", mb="md"),
    dmc.Text(
        "The Liquid Glass theme uses CSS variables for easy customization. "
        "Use rgba() for transparency - never opacity on glass elements.",
        size="sm",
        c="dimmed",
        mb="md",
    ),

    dmc.SimpleGrid(cols={"base": 1, "md": 2}, spacing="md", children=[
        dmc.Paper([
            dmc.Group([
                DashIconify(icon="mdi:white-balance-sunny", width=20),
                dmc.Text("Liquid Glass Light", fw=600, size="sm"),
            ], gap="xs", mb="sm"),
            dmc.Code(
                block=True,
                children=""".dash-dock-liquid-glass-light {
  --dashdock-glass-bg: rgba(255, 255, 255, 0.65);
  --dashdock-glass-border: rgba(0, 0, 0, 0.08);
  --dashdock-glass-blur: blur(16px) saturate(150%);
  backdrop-filter: var(--dashdock-glass-blur);
  border-radius: 16px;
}""",
                style={"fontSize": "11px"}
            ),
        ], withBorder=True, radius="md", p="md"),

        dmc.Paper([
            dmc.Group([
                DashIconify(icon="mdi:weather-night", width=20),
                dmc.Text("Liquid Glass Dark", fw=600, size="sm"),
            ], gap="xs", mb="sm"),
            dmc.Code(
                block=True,
                children=""".dash-dock-liquid-glass-dark {
  --dashdock-glass-bg: rgba(30, 30, 35, 0.65);
  --dashdock-glass-border: rgba(255, 255, 255, 0.1);
  --dashdock-glass-blur: blur(16px) saturate(180%);
  backdrop-filter: var(--dashdock-glass-blur);
  border-radius: 16px;
}""",
                style={"fontSize": "11px"}
            ),
        ], withBorder=True, radius="md", p="md"),
    ]),

    # Properties Table
    dmc.Title("Key Glass Properties", order=4, mt="xl", mb="md"),
    dmc.Table(
        striped=True,
        highlightOnHover=True,
        withTableBorder=True,
        withColumnBorders=True,
        data={
            "head": ["Property", "Purpose", "Light Value", "Dark Value"],
            "body": [
                ["backdrop-filter", "Frosted blur effect", "blur(16px) saturate(150%)", "blur(16px) saturate(180%)"],
                ["background", "Transparency", "rgba(255,255,255,0.65)", "rgba(30,30,35,0.65)"],
                ["border", "Edge definition", "rgba(0,0,0,0.08)", "rgba(255,255,255,0.1)"],
                ["border-radius", "Rounded corners", "16px", "16px"],
                ["box-shadow", "Depth + inner glow", "0 8px 32px rgba(0,0,0,0.1)", "0 8px 32px rgba(0,0,0,0.5)"],
            ],
        },
    ),

], size="xl", py="md")


# ============================================================================
# CALLBACKS
# ============================================================================

@callback(
    Output("dock-preview-container", "className"),
    Output("dock-preview-container", "style"),
    Output("current-theme-code", "children"),
    Input("theme-selector", "value"),
)
def update_theme(theme):
    class_name = f"dash-dock-{theme}"
    style = get_container_style(theme)
    style["height"] = "450px"
    return class_name, style, theme


@callback(
    Output("preview-chart", "series"),
    Input("chart-color-input", "value"),
)
def update_chart_color(color):
    return [{"name": "sales", "color": color or "#228be6"}]