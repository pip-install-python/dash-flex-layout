"""Home-page demo: a three-panel dock with a collapsible left border.

Deliberately the shape a reader recognises from an editor — a sidebar, a main
area, and a console underneath — so the first thing on the page is the thing the
package does. Every panel is draggable; the left border collapses.
"""
import dash_mantine_components as dmc
from dash import html

import flexlayout_dash as dfl

model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
        # The border starts open so the sidebar is visible without a click.
        "borderAutoSelectTabWhenOpen": True,
    },
    "borders": [
        {
            "type": "border",
            "location": "left",
            "size": 200,
            "selected": 0,
            "children": [{"type": "tab", "name": "Explorer", "id": "home-explorer"}],
        }
    ],
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
                        "weight": 65,
                        "children": [
                            {"type": "tab", "name": "app.py", "id": "home-editor"},
                            {"type": "tab", "name": "README.md", "id": "home-readme"},
                        ],
                    },
                    {
                        "type": "tabset",
                        "weight": 35,
                        "children": [
                            {"type": "tab", "name": "Console", "id": "home-console"}
                        ],
                    },
                ],
            },
            {
                "type": "tabset",
                "weight": 30,
                "children": [{"type": "tab", "name": "Preview", "id": "home-preview"}],
            },
        ],
    },
}


def _panel(*children):
    return dmc.Box(children, p="md", style={"height": "100%", "overflow": "auto"})


def _code(text):
    return dmc.Code(text, block=True, style={"fontSize": "0.8rem"})


component = dfl.DashFlexLayout(
    id="home-dock",
    model=model,
    useStateForModel=True,
    # The dock has no intrinsic height — this is required, and it goes on the
    # component itself, never on a wrapper.
    style={"height": "460px"},
    children=[
        dfl.Tab(
            id="home-explorer",
            children=_panel(
                dmc.Text("EXPLORER", size="xs", fw=700, c="dimmed", mb="xs"),
                dmc.Stack(
                    [
                        dmc.Text("📁 src", size="sm"),
                        dmc.Text("📄 app.py", size="sm", ml="md"),
                        dmc.Text("📄 README.md", size="sm", ml="md"),
                    ],
                    gap=4,
                ),
                dmc.Text(
                    "Collapse this sidebar with the border tab on the left edge.",
                    size="xs", c="dimmed", mt="md",
                ),
            ),
        ),
        dfl.Tab(
            id="home-editor",
            children=_panel(
                _code(
                    "import flexlayout_dash as dfl\n\n"
                    "dfl.DashFlexLayout(\n"
                    '    id="dock",\n'
                    "    model=model,\n"
                    '    style={"height": "600px"},\n'
                    "    children=[dfl.Tab(id=..., children=...)],\n"
                    ")"
                )
            ),
        ),
        dfl.Tab(
            id="home-readme",
            children=_panel(
                dmc.Text("Two tabs share this tabset.", size="sm"),
                dmc.Text(
                    "Drag either one onto another panel — or onto an edge — and the "
                    "dock re-splits around it.",
                    size="sm", c="dimmed", mt="xs",
                ),
            ),
        ),
        dfl.Tab(
            id="home-console",
            children=_panel(
                _code("$ pip install flexlayout-dash\nSuccessfully installed flexlayout-dash")
            ),
        ),
        dfl.Tab(
            id="home-preview",
            children=_panel(
                dmc.Text("Preview", fw=600, mb="xs"),
                dmc.Text(
                    "Each panel is an ordinary Dash subtree rendered through a React "
                    "portal, so callbacks inside it keep firing — even while the tab "
                    "is hidden behind another.",
                    size="sm",
                ),
                html.Div(
                    dmc.Badge("MIT · unlimited tabs", variant="light"),
                    style={"marginTop": "12px"},
                ),
            ),
        ),
    ],
)
