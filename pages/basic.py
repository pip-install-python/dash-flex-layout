"""
Basic Usage Page - Simple DashDock Examples

Demonstrates basic DashDock setup with simple tab layouts.
"""

import dash
from dash import html
import dash_flex_layout
import dash_mantine_components as dmc
from dash_iconify import DashIconify

dash.register_page(__name__, path='/basic', name='Basic Usage')

# Simple two-panel layout
simple_model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": False,
    },
    "layout": {
        "type": "row",
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Left Panel", "id": "left-panel"}
                ]
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Right Panel", "id": "right-panel"}
                ]
            }
        ]
    }
}

simple_tabs = [
    dash_flex_layout.Tab(id="left-panel", children=[
        dmc.Stack([
            dmc.Title("Left Panel", order=3),
            dmc.Text("This is the left panel content."),
            dmc.Text("Drag the splitter between panels to resize.", c="dimmed"),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="right-panel", children=[
        dmc.Stack([
            dmc.Title("Right Panel", order=3),
            dmc.Text("This is the right panel content."),
            dmc.Text("Try dragging tabs between panels.", c="dimmed"),
        ], p="md")
    ]),
]

# Multiple tabs layout
multi_tab_model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
    },
    "layout": {
        "type": "row",
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 100,
                "selected": 0,
                "children": [
                    {"type": "tab", "name": "Tab 1", "id": "tab-1"},
                    {"type": "tab", "name": "Tab 2", "id": "tab-2"},
                    {"type": "tab", "name": "Tab 3", "id": "tab-3"},
                ]
            }
        ]
    }
}

multi_tabs = [
    dash_flex_layout.Tab(id="tab-1", children=[
        dmc.Stack([
            dmc.Title("Tab 1 Content", order=3),
            dmc.Text("First tab content. Click on other tabs to switch."),
            dmc.Badge("Active Tab", color="green"),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="tab-2", children=[
        dmc.Stack([
            dmc.Title("Tab 2 Content", order=3),
            dmc.Text("Second tab content."),
            dmc.Badge("Tab 2", color="blue"),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="tab-3", children=[
        dmc.Stack([
            dmc.Title("Tab 3 Content", order=3),
            dmc.Text("Third tab content."),
            dmc.Badge("Tab 3", color="violet"),
        ], p="md")
    ]),
]

# Vertical layout (column)
vertical_model = {
    "global": {
        "tabEnableClose": False,
    },
    "layout": {
        "type": "column",
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 40,
                "children": [
                    {"type": "tab", "name": "Top Panel", "id": "top-panel"}
                ]
            },
            {
                "type": "tabset",
                "weight": 60,
                "children": [
                    {"type": "tab", "name": "Bottom Panel", "id": "bottom-panel"}
                ]
            }
        ]
    }
}

vertical_tabs = [
    dash_flex_layout.Tab(id="top-panel", children=[
        dmc.Stack([
            dmc.Title("Top Panel", order=3),
            dmc.Text("Panels stacked vertically using type: 'column'"),
        ], p="md")
    ]),
    dash_flex_layout.Tab(id="bottom-panel", children=[
        dmc.Stack([
            dmc.Title("Bottom Panel", order=3),
            dmc.Text("This panel takes 60% of the vertical space."),
        ], p="md")
    ]),
]

layout = dmc.Container([
    dmc.Stack([
        dmc.Title("Basic Usage", order=1),
        dmc.Text("Simple examples demonstrating DashDock fundamentals.", c="dimmed", size="lg"),

        # Example 1: Simple Two-Panel
        dmc.Paper([
            dmc.Title("Two-Panel Layout", order=3, mb="sm"),
            dmc.Text("A basic horizontal split with two panels.", mb="md", c="dimmed"),
            html.Div(
                dash_flex_layout.DashFlexLayout(
                    id='simple-dock',
                    model=simple_model,
                    children=simple_tabs,
                    useStateForModel=True,
                ),
                style={"height": "300px", "border": "1px solid var(--mantine-color-gray-3)"}
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Example 2: Multiple Tabs
        dmc.Paper([
            dmc.Title("Multiple Tabs", order=3, mb="sm"),
            dmc.Text("Multiple tabs in a single tabset. Click to switch, drag to reorder.", mb="md", c="dimmed"),
            html.Div(
                dash_flex_layout.DashFlexLayout(
                    id='multi-tab-dock',
                    model=multi_tab_model,
                    children=multi_tabs,
                    useStateForModel=True,
                ),
                style={"height": "300px", "border": "1px solid var(--mantine-color-gray-3)"}
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Example 3: Vertical Layout
        dmc.Paper([
            dmc.Title("Vertical Layout", order=3, mb="sm"),
            dmc.Text("Panels arranged vertically using 'column' type.", mb="md", c="dimmed"),
            html.Div(
                dash_flex_layout.DashFlexLayout(
                    id='vertical-dock',
                    model=vertical_model,
                    children=vertical_tabs,
                    useStateForModel=True,
                ),
                style={"height": "400px", "border": "1px solid var(--mantine-color-gray-3)"}
            ),
        ], p="lg", withBorder=True, radius="md"),

        # Code Example
        dmc.Paper([
            dmc.Title("Code Example", order=3, mb="sm"),
            dmc.CodeHighlight(
                language="python",
                code='''# Basic two-panel layout
model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": False,
    },
    "layout": {
        "type": "row",
        "weight": 100,
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Left Panel", "id": "left-panel"}
                ]
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [
                    {"type": "tab", "name": "Right Panel", "id": "right-panel"}
                ]
            }
        ]
    }
}

tabs = [
    dash_flex_layout.Tab(id="left-panel", children=[html.H3("Left")]),
    dash_flex_layout.Tab(id="right-panel", children=[html.H3("Right")]),
]

dash_flex_layout.DashFlexLayout(
    id='dock',
    model=model,
    children=tabs,
    useStateForModel=True
)'''
            ),
        ], p="lg", withBorder=True, radius="md"),

    ], gap="xl"),
], size="lg", py="xl")