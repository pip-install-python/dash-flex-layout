from dash import html
import flexlayout_dash as dfl

model = {
    "global": {"tabEnableClose": False, "tabEnableFloat": True},
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Panel 1", "id": "gs-panel-1"}],
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Panel 2", "id": "gs-panel-2"}],
            },
        ],
    },
}


def _panel(text):
    return html.Div(text, style={"padding": "16px"})


# Set the height on the component itself (its `style` is applied to the dock
# container). The component sets `position: relative` internally, so FlexLayout's
# absolutely-positioned layout stays contained within this box.
component = dfl.DashFlexLayout(
    id="gs-dock",
    model=model,
    useStateForModel=True,
    style={"height": "360px"},
    children=[
        dfl.Tab(id="gs-panel-1", children=[_panel("Drag this tab onto the other panel, or grab the splitter between them.")]),
        dfl.Tab(id="gs-panel-2", children=[_panel("Second panel.")]),
    ],
)
