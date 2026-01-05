"""
Advanced Layouts Page - IDE-Style Layouts

Demonstrates advanced DashDock configurations including border panels.
"""

import dash
from dash import html, dcc
import dash_flex_layout
import dash_mantine_components as dmc
from dash_iconify import DashIconify

dash.register_page(__name__, path='/advanced', name='Advanced Layouts')

# IDE-style layout with borders
ide_model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        "tabSetEnableMaximize": True,
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 200,
            "selected": 0,
            "children": [
                {"type": "tab", "name": "Explorer", "id": "explorer"},
                {"type": "tab", "name": "Search", "id": "search"},
            ]
        },
        {
            "type": "border",
            "location": "bottom",
            "size": 150,
            "selected": 0,
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
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 60,
                "selected": 0,
                "children": [
                    {"type": "tab", "name": "Editor", "id": "editor"},
                    {"type": "tab", "name": "Preview", "id": "preview"},
                ]
            },
            {
                "type": "tabset",
                "weight": 40,
                "children": [
                    {"type": "tab", "name": "Outline", "id": "outline"},
                ]
            }
        ]
    }
}

# File tree mock data
file_tree = [
    {"icon": "mdi:folder", "name": "src", "color": "yellow"},
    {"icon": "mdi:file-code", "name": "app.py", "color": "blue"},
    {"icon": "mdi:file-code", "name": "utils.py", "color": "blue"},
    {"icon": "mdi:folder", "name": "pages", "color": "yellow"},
    {"icon": "mdi:file-document", "name": "README.md", "color": "gray"},
]

ide_tabs = [
    dash_flex_layout.Tab(id="explorer", children=[
        dmc.Stack([
            dmc.Text("EXPLORER", size="xs", fw=700, c="dimmed"),
            dmc.Stack([
                dmc.Group([
                    DashIconify(icon=f["icon"], width=16, color=f["color"]),
                    dmc.Text(f["name"], size="sm"),
                ], gap="xs")
                for f in file_tree
            ], gap="xs"),
        ], p="sm", gap="md")
    ]),
    dash_flex_layout.Tab(id="search", children=[
        dmc.Stack([
            dmc.TextInput(placeholder="Search...", leftSection=DashIconify(icon="mdi:magnify")),
            dmc.Text("No results", c="dimmed", size="sm"),
        ], p="sm")
    ]),
    dash_flex_layout.Tab(id="editor", children=[
        dmc.Stack([
            dmc.Group([
                DashIconify(icon="mdi:file-code", width=20),
                dmc.Text("app.py", fw=500),
            ]),
            dmc.CodeHighlight(
                language="python",
                code='''def hello_world():
    """A simple function."""
    print("Hello, World!")
    return True

if __name__ == "__main__":
    hello_world()''',
            ),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="preview", children=[
        dmc.Stack([
            dmc.Title("Preview", order=4),
            dmc.Text("Live preview of your content would appear here.", c="dimmed"),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="outline", children=[
        dmc.Stack([
            dmc.Text("OUTLINE", size="xs", fw=700, c="dimmed"),
            dmc.NavLink(label="hello_world()", leftSection=DashIconify(icon="mdi:function")),
            dmc.NavLink(label="__main__", leftSection=DashIconify(icon="mdi:code-braces")),
        ], p="sm")
    ]),
    dash_flex_layout.Tab(id="terminal", children=[
        html.Div([
            html.Pre(
                "$ python app.py\nHello, World!\n$ ",
                style={
                    "backgroundColor": "#1e1e1e",
                    "color": "#00ff00",
                    "padding": "10px",
                    "margin": "0",
                    "fontFamily": "monospace",
                    "height": "100%",
                    "overflow": "auto"
                }
            )
        ], style={"height": "100%"})
    ]),
    dash_flex_layout.Tab(id="output", children=[
        dmc.Stack([
            dmc.Text("OUTPUT", size="xs", fw=700, c="dimmed"),
            dmc.Text("Build completed successfully.", size="sm"),
        ], p="sm")
    ]),
    dash_flex_layout.Tab(id="properties", children=[
        dmc.Stack([
            dmc.Text("PROPERTIES", size="xs", fw=700, c="dimmed"),
            dmc.Stack([
                dmc.Group([dmc.Text("Name:", fw=500, size="sm"), dmc.Text("app.py", size="sm")]),
                dmc.Group([dmc.Text("Type:", fw=500, size="sm"), dmc.Text("Python", size="sm")]),
                dmc.Group([dmc.Text("Size:", fw=500, size="sm"), dmc.Text("1.2 KB", size="sm")]),
            ], gap="xs"),
        ], p="sm", gap="md")
    ]),
]

# Dashboard layout
dashboard_model = {
    "global": {
        "tabEnableClose": False,
    },
    "layout": {
        "type": "row",
        "weight": 100,
        "children": [
            {
                "type": "column",
                "weight": 70,
                "children": [
                    {
                        "type": "tabset",
                        "weight": 60,
                        "children": [
                            {"type": "tab", "name": "Chart", "id": "chart"}
                        ]
                    },
                    {
                        "type": "row",
                        "weight": 40,
                        "children": [
                            {
                                "type": "tabset",
                                "weight": 50,
                                "children": [
                                    {"type": "tab", "name": "Stats A", "id": "stats-a"}
                                ]
                            },
                            {
                                "type": "tabset",
                                "weight": 50,
                                "children": [
                                    {"type": "tab", "name": "Stats B", "id": "stats-b"}
                                ]
                            }
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

dashboard_tabs = [
    dash_flex_layout.Tab(id="chart", children=[
        dmc.LineChart(
            h=250,
            dataKey="month",
            data=[
                {"month": "Jan", "sales": 10},
                {"month": "Feb", "sales": 15},
                {"month": "Mar", "sales": 12},
                {"month": "Apr", "sales": 18},
                {"month": "May", "sales": 22},
            ],
            series=[{"name": "sales", "color": "blue.6"}],
            withLegend=True,
        )
    ]),
    dash_flex_layout.Tab(id="stats-a", children=[
        dmc.Stack([
            dmc.Text("Revenue", c="dimmed", size="sm"),
            dmc.Title("$24,500", order=2),
            dmc.Badge("+12%", color="green"),
        ], align="center", p="md")
    ]),
    dash_flex_layout.Tab(id="stats-b", children=[
        dmc.Stack([
            dmc.Text("Users", c="dimmed", size="sm"),
            dmc.Title("1,234", order=2),
            dmc.Badge("+8%", color="green"),
        ], align="center", p="md")
    ]),
    dash_flex_layout.Tab(id="filters", children=[
        dmc.Stack([
            dmc.Title("Filters", order=4),
            dmc.Select(
                label="Date Range",
                data=["Last 7 days", "Last 30 days", "Last 90 days"],
                value="Last 30 days",
            ),
            dmc.MultiSelect(
                label="Categories",
                data=["Electronics", "Clothing", "Food", "Other"],
                value=["Electronics"],
            ),
            dmc.Button("Apply Filters", fullWidth=True),
        ], p="md", gap="md")
    ]),
    dash_flex_layout.Tab(id="details", children=[
        dmc.Stack([
            dmc.Title("Details", order=4),
            dmc.Text("Select an item to view details.", c="dimmed"),
        ], p="md")
    ]),
]

layout = dmc.Container([
    dmc.Stack([
        dmc.Title("Advanced Layouts", order=1),
        dmc.Text("Complex layouts with borders and nested panels.", c="dimmed", size="lg"),

        # IDE Layout
        dmc.Paper([
            dmc.Title("IDE-Style Layout", order=3, mb="sm"),
            dmc.Text("Full IDE layout with explorer, editor, and terminal.", mb="md", c="dimmed"),
            html.Div(
                dash_flex_layout.DashFlexLayout(
                    id='ide-dock',
                    model=ide_model,
                    children=ide_tabs,
                    useStateForModel=True,
                ),
                style={"height": "500px", "border": "1px solid var(--mantine-color-gray-3)"}
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Dashboard Layout
        dmc.Paper([
            dmc.Title("Dashboard Layout", order=3, mb="sm"),
            dmc.Text("Nested row/column layout for dashboards.", mb="md", c="dimmed"),
            html.Div(
                dash_flex_layout.DashFlexLayout(
                    id='dashboard-dock',
                    model=dashboard_model,
                    children=dashboard_tabs,
                    useStateForModel=True,
                ),
                style={"height": "400px", "border": "1px solid var(--mantine-color-gray-3)"}
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Border Panels Info
        dmc.Paper([
            dmc.Title("Border Panels", order=3, mb="sm"),
            dmc.Text("Border panels are collapsible sidebars that can be placed on three sides:", mb="md"),
            dmc.CodeHighlight(
                language="python",
                code='''"borders": [
    {
        "type": "border",
        "location": "left",    # left, right, or bottom
        "size": 200,           # Width/height in pixels
        "selected": 0,         # Initially selected tab
        "children": [
            {"type": "tab", "name": "Explorer", "id": "explorer"}
        ]
    }
]'''
            ),
        ], p="lg", withBorder=True, radius="md"),

    ], gap="xl"),
], size="lg", py="xl")