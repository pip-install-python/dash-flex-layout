from dash import html
import flexlayout_dash as dfl

# Borders are collapsible panels docked to the edges. They start collapsed —
# click a border tab name to slide it open.
model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        "borderSize": 220,
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 220,
            "children": [
                {"type": "tab", "name": "Explorer", "id": "borders-explorer"},
                {"type": "tab", "name": "Search", "id": "borders-search"},
            ],
        },
        {
            "type": "border",
            "location": "right",
            "size": 220,
            "children": [{"type": "tab", "name": "Properties", "id": "borders-props"}],
        },
        {
            "type": "border",
            "location": "bottom",
            "size": 150,
            "children": [{"type": "tab", "name": "Terminal", "id": "borders-terminal"}],
        },
    ],
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 100,
                "children": [{"type": "tab", "name": "Editor", "id": "borders-editor"}],
            }
        ],
    },
}


def _panel(text):
    return html.Div(text, style={"padding": "16px"})


component = dfl.DashFlexLayout(
    id="borders-dock",
    model=model,
    useStateForModel=True,
    style={"height": "460px"},
    children=[
        dfl.Tab(id="borders-editor", children=[_panel("Editor (main area). Click Explorer / Search / Properties / Terminal on the edges to open a border panel.")]),
        dfl.Tab(id="borders-explorer", children=[_panel("Explorer — left border.")]),
        dfl.Tab(id="borders-search", children=[_panel("Search — left border.")]),
        dfl.Tab(id="borders-props", children=[_panel("Properties — right border.")]),
        dfl.Tab(id="borders-terminal", children=[_panel("Terminal — bottom border.")]),
    ],
)
