import json

from dash import html, dcc, callback, Input, Output
import flexlayout_dash as dfl

# With useStateForModel=False the layout round-trips through Dash, so you can
# read the live model from a callback. Drag a tab or move a splitter and watch
# the JSON update below.
model = {
    "global": {"tabEnableClose": False, "tabEnableFloat": True},
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Left", "id": "callbacks-left"}],
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Right", "id": "callbacks-right"}],
            },
        ],
    },
}


def _panel(text):
    return html.Div(text, style={"padding": "16px"})


component = html.Div(
    [
        dfl.DashFlexLayout(
            id="callbacks-dock",
            model=model,
            useStateForModel=False,
            style={"height": "320px"},
            children=[
                dfl.Tab(id="callbacks-left", children=[_panel("Rearrange these panels…")]),
                dfl.Tab(id="callbacks-right", children=[_panel("…and the model JSON below updates live.")]),
            ],
        ),
        html.P("Live model (read via Input('callbacks-dock', 'model')):",
               style={"fontWeight": 600, "marginTop": "12px"}),
        dcc.Markdown(id="callbacks-model-json"),
    ]
)


@callback(
    Output("callbacks-model-json", "children"),
    Input("callbacks-dock", "model"),
)
def show_model(model):
    text = json.dumps(model, indent=2)
    if len(text) > 1400:
        text = text[:1400] + "\n  ... (truncated)"
    return f"```json\n{text}\n```"
