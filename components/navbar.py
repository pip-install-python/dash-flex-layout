import dash_mantine_components as dmc
from dash_iconify import DashIconify

from lib.constants import HEADER_HEIGHT

excluded_links = [
    "/404",
]


def create_nav_link(icon, text, href, external=False):
    """Create a styled navigation link with icon"""
    return dmc.Anchor(
        dmc.Group(
            [
                DashIconify(icon=icon, width=18),
                dmc.Text(text, size="sm", fw=500),
            ],
            gap="sm",
        ),
        href=href,
        target="_blank" if external else None,
        className="navbar-link",
        underline=False,
    )


def create_nav_section(title, links):
    """Create a navigation section with a title and links"""
    return dmc.Stack(
        [
            dmc.Text(
                title,
                size="xs",
                fw=700,
                tt="uppercase",
                c="dimmed",
                mb="xs",
            ),
            dmc.Stack(links, gap="xs"),
        ],
        gap="sm",
    )


def create_content(data):
    """Create navbar content with organized sections"""

    # Desired order for the documentation pages. Names must match each doc's
    # `name:` frontmatter; any page not listed here is appended afterwards.
    page_order = [
        "Getting Started",
        "Component Reference",
        "Basic Layouts",
        "Borders & Sidebars",
        "Theming",
        "Callbacks",
    ]

    # Map page names to nav links (skip Home and excluded paths)
    page_dict = {}
    for entry in data:
        if entry["path"] not in excluded_links and entry["path"] != "/":
            link = create_nav_link(
                entry.get("icon", "fluent:document-24-regular"),
                entry["name"],
                entry["path"],
            )
            page_dict[entry["name"]] = link

    page_links = [page_dict[name] for name in page_order if name in page_dict]
    for name, link in page_dict.items():
        if name not in page_order:
            page_links.append(link)

    return dmc.ScrollArea(
        offsetScrollbars=True,
        type="scroll",
        style={"height": "100%"},
        children=dmc.Stack(
            [
                create_nav_link("fluent:home-24-regular", "Home", "/"),

                dmc.Divider(mt="xs", mb="xs"),
                create_nav_section("Documentation", page_links),

                dmc.Divider(mt="md", mb="sm"),
                create_nav_section(
                    "Resources",
                    [
                        create_nav_link(
                            "radix-icons:github-logo",
                            "GitHub",
                            "https://github.com/pip-install-python/dash-flex-layout",
                            external=True,
                        ),
                        create_nav_link(
                            "simple-icons:pypi",
                            "PyPI",
                            "https://pypi.org/project/flexlayout-dash/",
                            external=True,
                        ),
                        create_nav_link(
                            "mdi:layers-outline",
                            "FlexLayout (React)",
                            "https://github.com/caplin/FlexLayout",
                            external=True,
                        ),
                        create_nav_link(
                            "ic:baseline-design-services",
                            "Dash Mantine Components",
                            "https://www.dash-mantine-components.com/",
                            external=True,
                        ),
                        create_nav_link(
                            "fluent-mdl2:forum",
                            "Dash Community",
                            "https://community.plotly.com/",
                            external=True,
                        ),
                    ],
                ),
            ],
            gap="xs",
            p="md",
        ),
    )


def create_navbar(data):
    """Create the main application navbar"""
    return dmc.AppShellNavbar(
        children=create_content(data),
        style={"borderRight": "1px solid var(--mantine-color-gray-3)"},
    )


def create_mobile_content(data):
    """Drawer body: a sticky search field above the scrolling nav sections.

    The header's search Select is `visibleFrom="sm"`, so phones otherwise have
    no way to jump straight to a page. This is that missing entry point.
    """
    return dmc.Stack(
        [
            dmc.Box(
                dmc.Select(
                    id="mobile-select-component",
                    placeholder="Search pages...",
                    searchable=True,
                    clearable=True,
                    size="md",
                    nothingFoundMessage="No pages found",
                    leftSection=DashIconify(icon="mingcute:search-3-line", width=18),
                    data=[
                        {"label": component["name"], "value": component["path"]}
                        for component in data
                        if component["name"] not in ["Home", "Not found 404"]
                    ],
                    comboboxProps={"zIndex": 2000},
                ),
                p="md",
                pb="xs",
            ),
            dmc.Divider(),
            # flex/minHeight give the ScrollArea a definite box to scroll inside.
            dmc.Box(create_content(data), style={"flex": 1, "minHeight": 0}),
        ],
        gap=0,
        className="mobile-nav",
        style={"height": "100%"},
    )


def create_navbar_drawer(data):
    """Mobile navigation: a solid, full-height side panel.

    Runs from the bottom of the fixed header to the bottom of the viewport —
    no floating card, no close-button header row. The hamburger toggles it and
    the header stays visible (and tappable) above the overlay.

    NOTE the DMC floor this depends on: below dash-mantine-components 2.8.0
    these identical props render as a floating card instead of a docked panel.
    requirements.txt pins >=2.8.0 for exactly this reason.
    """
    return dmc.Drawer(
        id="components-navbar-drawer",
        overlayProps={"opacity": 0.55, "blur": 3},
        zIndex=1500,
        withCloseButton=False,  # removes the whole Drawer header row
        size="300px",
        padding=0,
        children=create_mobile_content(data),
        trapFocus=False,
        position="left",
        styles={
            # Dock below the fixed header. dvh (not vh) so a collapsing mobile
            # URL bar doesn't leave a dead gap at the bottom.
            "inner": {
                "top": HEADER_HEIGHT,
                "height": f"calc(100dvh - {HEADER_HEIGHT}px)",
            },
            # Overlay starts below the header too, keeping the hamburger tappable.
            "overlay": {"top": HEADER_HEIGHT},
            # Solid panel: fill the inner, square corners.
            "content": {
                "height": "100%",
                "maxHeight": "100%",
                "borderRadius": 0,
                "display": "flex",
                "flexDirection": "column",
            },
            # Definite height so create_content's ScrollArea can actually scroll.
            "body": {"flex": 1, "minHeight": 0, "height": "100%", "padding": 0},
        },
    )
