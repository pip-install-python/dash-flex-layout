"""
DashFlexLayout Example Application

A multi-page Dash application demonstrating DashFlexLayout component functionality.
Uses DMC AppShell for proper layout management.

Run with: python app.py
"""

import dash
from dash import Dash, html, page_container, clientside_callback, Input, Output
import dash_mantine_components as dmc
from dash_iconify import DashIconify
from dash import _dash_renderer

# Set React version for Dash 3 compatibility
_dash_renderer._set_react_version("18.2.0")

# Initialize the Dash app with multi-page support
app = Dash(
    __name__,
    use_pages=True,
    suppress_callback_exceptions=True,
    external_stylesheets=[dmc.styles.ALL, dmc.styles.CHARTS]
)

# Logo
logo = "https://github.com/user-attachments/assets/c1ff143b-4365-4fd1-880f-3e97aab5c302"

# Navigation links
nav_links = [
    {"label": "Home", "href": "/", "icon": "mdi:home"},
    {"label": "Basic Usage", "href": "/basic", "icon": "mdi:dock-window"},
    {"label": "Advanced Layouts", "href": "/advanced", "icon": "mdi:view-dashboard"},
    {"label": "Theme Integration", "href": "/theming", "icon": "mdi:palette"},
    {"label": "Callbacks", "href": "/callbacks", "icon": "mdi:function"},
]

# Theme toggle switch
theme_toggle = dmc.Switch(
    offLabel=DashIconify(icon="radix-icons:sun", width=15, color=dmc.DEFAULT_THEME["colors"]["yellow"][8]),
    onLabel=DashIconify(icon="radix-icons:moon", width=15, color=dmc.DEFAULT_THEME["colors"]["yellow"][6]),
    id="color-scheme-toggle",
    persistence=True,
    color="grey",
)

# Main app layout using AppShell
app.layout = dmc.MantineProvider(
    dmc.AppShell(
        [
            dmc.AppShellHeader(
                dmc.Group(
                    [
                        # Logo and title
                        dmc.Group([
                            DashIconify(icon="mdi:dock-window", width=30, color="var(--mantine-color-blue-6)"),
                            dmc.Title("DashFlexLayout", order=3, c="blue"),
                        ], gap="xs"),
                        # Navigation links
                        dmc.Group([
                            *[
                                dmc.Anchor(
                                    dmc.Group([
                                        DashIconify(icon=link["icon"], width=16),
                                        dmc.Text(link["label"], size="sm"),
                                    ], gap=4),
                                    href=link["href"],
                                    underline="never",
                                    c="inherit",
                                )
                                for link in nav_links
                            ],
                        ], gap="md", visibleFrom="sm"),
                        # Theme toggle
                        theme_toggle,
                    ],
                    justify="space-between",
                    h="100%",
                    px="md",
                    style={"flex": 1},
                )
            ),
            dmc.AppShellMain(
                dmc.ScrollArea(
                    page_container,
                    h="calc(100vh - 60px)",
                    type="auto",
                )
            ),
        ],
        header={"height": 60},
        padding="md",
    )
)

# Clientside callback for theme toggle
clientside_callback(
    """
    (switchOn) => {
       document.documentElement.setAttribute('data-mantine-color-scheme', switchOn ? 'dark' : 'light');
       return window.dash_clientside.no_update
    }
    """,
    Output("color-scheme-toggle", "id"),
    Input("color-scheme-toggle", "checked"),
)

if __name__ == '__main__':
    app.run(debug=True, port=8954)