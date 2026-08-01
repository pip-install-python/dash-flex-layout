from dash import html
import flexlayout_dash as dfl

# A nested layout: a left column (Editor over Output) beside a right tabset
# that holds three tabs.
model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        "tabSetEnableMaximize": True,
    },
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "column",
                "weight": 60,
                "children": [
                    {
                        "type": "tabset",
                        "weight": 60,
                        "children": [{"type": "tab", "name": "Editor", "id": "basic-editor"}],
                    },
                    {
                        "type": "tabset",
                        "weight": 40,
                        "children": [{"type": "tab", "name": "Output", "id": "basic-output"}],
                    },
                ],
            },
            {
                "type": "tabset",
                "weight": 40,
                "children": [
                    {"type": "tab", "name": "Tab A", "id": "basic-a"},
                    {"type": "tab", "name": "Tab B", "id": "basic-b"},
                    {"type": "tab", "name": "Tab C", "id": "basic-c"},
                ],
            },
        ],
    },
}


def _panel(text):
    return html.Div(text, style={"padding": "16px"})


component = dfl.DashFlexLayout(
    id="basic-dock",
    model=model,
    useStateForModel=True,
    style={"height": "440px"},
    children=[
        dfl.Tab(id="basic-editor", children=[_panel("Editor — top-left tabset. Maximize this tabset with the ⛶ button.")]),
        dfl.Tab(id="basic-output", children=[_panel("Output — bottom-left tabset.")]),
        dfl.Tab(id="basic-a", children=[_panel("Tab A — the right tabset stacks three tabs.")]),
        dfl.Tab(id="basic-b", children=[_panel("Tab B.")]),
        dfl.Tab(id="basic-c", children=[_panel("Tab C.")]),
    ],
)
