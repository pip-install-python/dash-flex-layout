"""
Callbacks Page - Interactivity Examples

Demonstrates Dash callbacks with DashDock components.
"""

import dash
from dash import html, dcc, callback, Input, Output, State
import dash_flex_layout
import dash_mantine_components as dmc
from dash_iconify import DashIconify
import json

dash.register_page(__name__, path='/callbacks', name='Callbacks')

# Interactive model with tabEnableRenderOnDemand disabled to prevent unmounting
interactive_model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        "tabEnableRenderOnDemand": False,  # Keep all tabs mounted
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 250,
            "children": [
                {"type": "tab", "name": "Controls", "id": "controls"}
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
                    {"type": "tab", "name": "Chart", "id": "chart-view"},
                ]
            },
            {
                "type": "tabset",
                "weight": 40,
                "children": [
                    {"type": "tab", "name": "Data", "id": "data-view"},
                    {"type": "tab", "name": "Layout State", "id": "layout-state"},
                ]
            }
        ]
    }
}

# Tab content components
interactive_tabs = [
    dash_flex_layout.Tab(id="controls", children=[
        dmc.Stack([
            dmc.Title("Controls", order=4),
            dmc.Select(
                id="cb-chart-type",
                label="Chart Type",
                data=[
                    {"label": "Line Chart", "value": "line"},
                    {"label": "Bar Chart", "value": "bar"},
                    {"label": "Area Chart", "value": "area"},
                ],
                value="line",
            ),
            dmc.NumberInput(
                id="cb-data-points",
                label="Data Points",
                value=5,
                min=3,
                max=12,
            ),
            dmc.ColorPicker(
                id="cb-chart-color",
                format="hex",
                value="#228be6",
            ),
            dmc.Text("Chart Color", size="sm", c="dimmed"),
            dmc.Button("Generate Data", id="cb-generate-btn", fullWidth=True),
        ], p="md", gap="md")
    ]),
    # Chart Tab with static structure
    dash_flex_layout.Tab(id="chart-view", children=[
        dmc.Box(p="md", children=[
            html.Div(id="cb-chart-placeholder", children=[
                dmc.Stack([
                    DashIconify(icon="mdi:chart-line", width=50, color="gray"),
                    dmc.Text("Click 'Generate Data' to start", c="dimmed"),
                ], align="center", justify="center", h=250)
            ]),
            html.Div(id="cb-line-container", style={"display": "none"}, children=[
                dmc.LineChart(id="cb-line-chart", h=300, data=[], dataKey="month",
                              series=[{"name": "value", "color": "#228be6"}], withLegend=True)
            ]),
            html.Div(id="cb-bar-container", style={"display": "none"}, children=[
                dmc.BarChart(id="cb-bar-chart", h=300, data=[], dataKey="month",
                             series=[{"name": "value", "color": "#228be6"}], withLegend=True)
            ]),
            html.Div(id="cb-area-container", style={"display": "none"}, children=[
                dmc.AreaChart(id="cb-area-chart", h=300, data=[], dataKey="month",
                              series=[{"name": "value", "color": "#228be6"}], withLegend=True)
            ]),
        ])
    ]),
    # Data Tab
    dash_flex_layout.Tab(id="data-view", children=[
        dmc.Box(p="md", children=[
            dmc.Title("Data Preview", order=4),
            html.Pre(id="cb-data-preview", children="No data generated yet.",
                     style={"backgroundColor": "var(--mantine-color-gray-1)", "padding": "10px",
                            "borderRadius": "4px", "overflow": "auto", "maxHeight": "300px"})
        ])
    ]),
    # Layout State Tab
    dash_flex_layout.Tab(id="layout-state", children=[
        dmc.Stack([
            dmc.Title("Layout State", order=4),
            dmc.Text("The current DashDock model JSON:", c="dimmed", size="sm"),
            html.Pre(id="cb-layout-state", style={"backgroundColor": "var(--mantine-color-gray-1)",
                     "padding": "10px", "borderRadius": "4px", "overflow": "auto",
                     "maxHeight": "300px", "fontSize": "11px"})
        ], p="md")
    ]),
]

# Main layout
layout = html.Div([
    dcc.Store(id="cb-data-store", data=[], storage_type="session"),
    dmc.Container([
        dmc.Stack([
            dmc.Title("Callbacks & Interactivity", order=1),
            dmc.Text("Using Dash callbacks with DashDock components.", c="dimmed", size="lg"),

            # Interactive Example
            dmc.Paper([
                dmc.Title("Interactive Dashboard", order=3, mb="sm"),
                dmc.Text("Use controls on the left to update the chart.", mb="md", c="dimmed"),
                html.Div(
                    dash_flex_layout.DashFlexLayout(
                        id='interactive-dock',
                        model=interactive_model,
                        children=interactive_tabs,
                        useStateForModel=True,
                    ),
                    style={"height": "450px", "border": "1px solid var(--mantine-color-gray-3)"}
                ),
            ], p="lg", withBorder=True, radius="md"),

            # Tips
            dmc.Paper([
                dmc.Title("DashDock Callback Tips", order=3, mb="sm"),
                dmc.List([
                    dmc.ListItem([
                        html.Strong("Static Structure: "),
                        "Define all chart components in layout. Control visibility via style props."
                    ]),
                    dmc.ListItem([
                        html.Strong("Prop Updates: "),
                        "Update component data/style props instead of replacing children."
                    ]),
                    dmc.ListItem([
                        html.Strong("useStateForModel: "),
                        "Set to True for most cases to avoid excessive callback triggers."
                    ]),
                    dmc.ListItem([
                        html.Strong("tabEnableRenderOnDemand: "),
                        "Set to False in model to keep all tabs mounted."
                    ]),
                ]),
            ], p="lg", withBorder=True, radius="md"),

        ], gap="xl"),
    ], size="lg", py="xl"),
])


# Callbacks

@callback(
    Output('cb-data-store', 'data'),
    Input('cb-generate-btn', 'n_clicks'),
    State('cb-data-points', 'value'),
    prevent_initial_call=True
)
def generate_data(n_clicks, n_points):
    import random
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    return [{"month": months[i], "value": random.randint(10, 100)} for i in range(min(n_points or 5, 12))]


@callback(
    Output('cb-line-chart', 'data'),
    Output('cb-bar-chart', 'data'),
    Output('cb-area-chart', 'data'),
    Output('cb-line-chart', 'series'),
    Output('cb-bar-chart', 'series'),
    Output('cb-area-chart', 'series'),
    Output('cb-chart-placeholder', 'style'),
    Output('cb-line-container', 'style'),
    Output('cb-bar-container', 'style'),
    Output('cb-area-container', 'style'),
    Input('cb-data-store', 'data'),
    Input('cb-chart-type', 'value'),
    Input('cb-chart-color', 'value'),
)
def update_charts(data, chart_type, color):
    series = [{"name": "value", "color": color or "#228be6"}]
    show, hide = {"display": "block"}, {"display": "none"}

    if not data:
        return [], [], [], series, series, series, show, hide, hide, hide

    chart_type = chart_type or "line"
    return (
        data, data, data,
        series, series, series,
        hide,
        show if chart_type == "line" else hide,
        show if chart_type == "bar" else hide,
        show if chart_type == "area" else hide,
    )


@callback(Output('cb-data-preview', 'children'), Input('cb-data-store', 'data'))
def update_data_preview(data):
    return json.dumps(data, indent=2) if data else "No data generated yet."


@callback(Output('cb-layout-state', 'children'), Input('interactive-dock', 'model'))
def show_layout_state(model):
    return json.dumps(model, indent=2) if model else "No model data."