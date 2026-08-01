import dash_mantine_components as dmc
from dash_iconify import DashIconify

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


def create_navbar_drawer(data):
    """Create mobile drawer navigation"""
    return dmc.Drawer(
        id="components-navbar-drawer",
        overlayProps={"opacity": 0.55, "blur": 3},
        zIndex=1500,
        offset=8,
        radius="md",
        withCloseButton=True,
        size="280px",
        children=create_content(data),
        trapFocus=False,
        position="left",
    )
