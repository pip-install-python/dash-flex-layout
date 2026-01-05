"""
Home Page - DashDock Introduction

Overview of DashDock features and quick start guide.
"""

import dash
from dash import html
import dash_mantine_components as dmc
from dash_iconify import DashIconify

dash.register_page(__name__, path='/', name='Home')

features = [
    {
        "icon": "mdi:dock-window",
        "title": "Dockable Windows",
        "description": "Create IDE-like layouts with drag-and-drop panel arrangement"
    },
    {
        "icon": "mdi:resize",
        "title": "Resizable Panels",
        "description": "Dynamically resize panels by dragging splitters"
    },
    {
        "icon": "mdi:tab",
        "title": "Tab Management",
        "description": "Organize content in tabs with drag-and-drop reordering"
    },
    {
        "icon": "mdi:palette",
        "title": "Theme Integration",
        "description": "Seamless light/dark mode with Dash Mantine Components"
    },
    {
        "icon": "mdi:window-maximize",
        "title": "Maximize & Float",
        "description": "Maximize tabsets or float individual tabs as windows"
    },
    {
        "icon": "mdi:react",
        "title": "Dash 3 Compatible",
        "description": "Works with both Dash 2 and Dash 3 applications"
    },
]

layout = dmc.Container([
    dmc.Stack([
        # Header
        dmc.Center(
            dmc.Stack([
                dmc.Group([
                    DashIconify(icon="mdi:dock-window", width=50, color="blue"),
                    dmc.Title("DashDock", order=1),
                ], gap="md"),
                dmc.Text(
                    "A flexible docking layout component for Plotly Dash",
                    size="xl",
                    c="dimmed"
                ),
            ], align="center", gap="xs"),
            py="xl"
        ),

        # Quick Start
        dmc.Paper([
            dmc.Title("Quick Start", order=2, mb="md"),
            dmc.CodeHighlight(
                language="python",
                code='''import dash
from dash import html
import dash_flex_layout
import dash_mantine_components as dmc

app = dash.Dash(__name__, external_stylesheets=[dmc.styles.ALL])

model = {
    "global": {"tabEnableClose": False},
    "layout": {
        "type": "row",
        "children": [
            {"type": "tabset", "children": [
                {"type": "tab", "name": "Panel 1", "id": "panel-1"}
            ]},
            {"type": "tabset", "children": [
                {"type": "tab", "name": "Panel 2", "id": "panel-2"}
            ]}
        ]
    }
}

tabs = [
    dash_dock.Tab(id="panel-1", children=[html.H3("Panel 1")]),
    dash_dock.Tab(id="panel-2", children=[html.H3("Panel 2")]),
]

app.layout = dmc.MantineProvider(
    html.Div([
        dash_dock.DashDock(
            id='dock',
            model=model,
            children=tabs,
            useStateForModel=True
        )
    ], style={"height": "500px"})
)

if __name__ == '__main__':
    app.run(debug=True)'''
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Features Grid
        dmc.Title("Features", order=2, mt="xl"),
        dmc.SimpleGrid(
            cols={"base": 1, "sm": 2, "lg": 3},
            spacing="lg",
            children=[
                dmc.Paper([
                    dmc.Group([
                        DashIconify(icon=feature["icon"], width=30, color="blue"),
                        dmc.Title(feature["title"], order=4),
                    ], gap="sm"),
                    dmc.Text(feature["description"], c="dimmed", mt="xs"),
                ], p="md", withBorder=True, radius="md")
                for feature in features
            ]
        ),

        # Navigation
        dmc.Title("Examples", order=2, mt="xl"),
        dmc.SimpleGrid(
            cols={"base": 1, "sm": 2},
            spacing="lg",
            children=[
                dmc.Anchor(
                    dmc.Paper([
                        dmc.Group([
                            DashIconify(icon="mdi:dock-window", width=24),
                            dmc.Text("Basic Usage", fw=500),
                        ]),
                        dmc.Text("Simple layout with tabs and panels", c="dimmed", size="sm"),
                    ], p="md", withBorder=True, radius="md", style={"cursor": "pointer"}),
                    href="/basic",
                    underline="never",
                    c="inherit"
                ),
                dmc.Anchor(
                    dmc.Paper([
                        dmc.Group([
                            DashIconify(icon="mdi:view-dashboard", width=24),
                            dmc.Text("Advanced Layouts", fw=500),
                        ]),
                        dmc.Text("IDE-style layouts with borders", c="dimmed", size="sm"),
                    ], p="md", withBorder=True, radius="md", style={"cursor": "pointer"}),
                    href="/advanced",
                    underline="never",
                    c="inherit"
                ),
                dmc.Anchor(
                    dmc.Paper([
                        dmc.Group([
                            DashIconify(icon="mdi:palette", width=24),
                            dmc.Text("Theme Integration", fw=500),
                        ]),
                        dmc.Text("Mantine theme and dark mode", c="dimmed", size="sm"),
                    ], p="md", withBorder=True, radius="md", style={"cursor": "pointer"}),
                    href="/theming",
                    underline="never",
                    c="inherit"
                ),
                dmc.Anchor(
                    dmc.Paper([
                        dmc.Group([
                            DashIconify(icon="mdi:function", width=24),
                            dmc.Text("Callbacks & Interactivity", fw=500),
                        ]),
                        dmc.Text("Dash callbacks with DashDock", c="dimmed", size="sm"),
                    ], p="md", withBorder=True, radius="md", style={"cursor": "pointer"}),
                    href="/callbacks",
                    underline="never",
                    c="inherit"
                ),
            ]
        ),
    ], gap="lg"),
], size="lg", py="xl")