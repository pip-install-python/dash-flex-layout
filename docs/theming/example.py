from dash import html
import flexlayout_dash as dfl

# DashFlexLayout watches the document's `data-mantine-color-scheme` attribute,
# so it follows the site's light/dark toggle (top-right) automatically — no
# extra wiring. You can also force it with the `colorScheme` prop.
model = {
    "global": {"tabEnableClose": False, "tabEnableFloat": True},
    "layout": {
        "type": "row",
        "children": [
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Light/Dark", "id": "theming-a"}],
            },
            {
                "type": "tabset",
                "weight": 50,
                "children": [{"type": "tab", "name": "Follows Mantine", "id": "theming-b"}],
            },
        ],
    },
}


def _panel(children):
    return html.Div(children, style={"padding": "16px"})


component = dfl.DashFlexLayout(
    id="theming-dock",
    model=model,
    useStateForModel=True,
    style={"height": "340px"},
    children=[
        dfl.Tab(id="theming-a", children=[_panel("Toggle the sun/moon switch in the header — this dock restyles to match.")]),
        dfl.Tab(id="theming-b", children=[_panel("The component reads `data-mantine-color-scheme` from <html> via a MutationObserver.")]),
    ],
)
