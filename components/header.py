import dash_mantine_components as dmc
from dash import Output, Input, State, clientside_callback
from dash_iconify import DashIconify

from components.navbar import search_data
from lib.constants import API_PACKAGES, BASE_URL, GITHUB_URL, HEADER_HEIGHT


def create_clerk_avatar():
    """Clerk avatar / sign-in control, sat beside the colour-scheme toggle.

    Returns None when Clerk is not configured, so local development and any
    deploy without the keys renders the header exactly as before rather than
    erroring on a missing component. `lib/auth.py` registers Clerk with
    `headless=True`, meaning the package injects NO UI of its own — without
    this widget there is no way to sign in even though Clerk initialises.
    The package renders `#clerk-login-button` inside it; since
    dash-clerk-auth 0.9.2 that button's own handler is satellite-safe, so it
    needs nothing from us.
    """
    from lib.auth import clerk_enabled

    if not clerk_enabled():
        return None
    from dash_clerk_auth import create_clerk_menu

    return create_clerk_menu(show_dropdown=True, dropdown_align="right")


def create_link(icon, href, label):
    """Create an external link icon button.

    ``label`` is REQUIRED: an icon-only link has no accessible name, so
    screen readers announce it as "link" and AI agents can't tell what it
    does — the exact Lighthouse/Agentic-Browsing failure measured on the
    fleet 2026-08-21. The label lands on both the anchor and the button.

    NEVER pass ``title=`` to a DMC component instead: DMC 2.8's ActionIcon
    and Anchor accept ``aria-*`` wildcards but REJECT ``title``, raising
    TypeError during app construction — the whole site fails to boot rather
    than rendering a wrong tooltip. Use dmc.Tooltip for hover text.
    """
    return dmc.Anchor(
        dmc.ActionIcon(
            DashIconify(icon=icon, width=22),
            variant="subtle",
            size="lg",
            color="gray",
            **{"aria-label": label},
        ),
        href=href,
        target="_blank",
        **{"aria-label": label},
    )


def create_backend_badge():
    """This host's backend, as a small header badge.

    DIVERGENCES.md §2: this fork carries no `lib/backend.py` and no
    pluggable backend selection at all — it is Flask-only by construction,
    hardcoded in run.py's `register_health_route(app, "flask")` call. So
    unlike a multi-backend fork, there is nothing to DETECT here; the
    badge just states the one fact truthfully rather than being absent
    (item 16: "backend badge (absent — add it, Flask-only is fine)").
    """
    return dmc.Badge(
        "Flask",
        variant="light",
        color="gray",
        radius="sm",
        styles={"root": {"textTransform": "none", "fontWeight": 600}},
        **{"aria-label": "Served by the Flask backend"},
    )


def create_other_apps_menu():
    """*Other Apps* — the network, from ONE registry (item 16).

    A hover menu in the top bar (the 2plot.dev shape the owner named as the
    reference), populated from lib.network_directory: the PRIMARY entries
    of PEERS + AFFILIATED, this app omitted, labelled by domain. The
    sidebar carries no network section any more — this is the only place
    the network is listed, so it cannot be listed twice.
    """
    from lib.network_directory import other_apps_for

    return dmc.Menu(
        [
            dmc.MenuTarget(
                dmc.Button(
                    "Other Apps",
                    variant="subtle",
                    color="gray",
                    size="sm",
                    leftSection=DashIconify(icon="svg-spinners:blocks-scale", width=18),
                    visibleFrom="md",
                    id="other-apps-menu-target",
                )
            ),
            dmc.MenuDropdown(
                [
                    dmc.MenuItem(
                        entry["label"],
                        leftSection=DashIconify(icon=entry["icon"], width=16),
                        href=entry["url"],
                        target="_blank",
                    )
                    for entry in other_apps_for(BASE_URL)
                ],
                id="other-apps-menu",
                # Solid, themed panel: near-transparent with washed-out
                # items in dark mode otherwise.
                styles={"dropdown": {
                    "backgroundColor": "var(--mantine-color-body)",
                    "border": "1px solid var(--mantine-color-default-border)",
                    "boxShadow": "var(--mantine-shadow-md)",
                }},
            ),
        ],
        trigger="hover",
        openDelay=100,
        closeDelay=200,
    )


def _package_version():
    """The documented component package's version, or None."""
    if not API_PACKAGES:
        return None
    try:
        from importlib.metadata import version

        return version(API_PACKAGES[0].replace("_", "-"))
    except Exception:
        try:
            import importlib

            return getattr(importlib.import_module(API_PACKAGES[0]), "__version__", None)
        except Exception:
            return None


def create_version_badge():
    """`v<version>` of the documented package, when the fork declares one."""
    v = _package_version()
    if not v:
        return None
    return dmc.Badge(
        f"v{v}",
        variant="light",
        color="gray",
        radius="sm",
        styles={"root": {"textTransform": "none", "fontWeight": 600}},
        **{"aria-label": f"{API_PACKAGES[0]} version {v}"},
    )


def create_search(data):
    """Searchable dropdown for page navigation — the sidebar's pages and
    nothing else (never /admin/*, never hidden-tier; components/navbar
    decides)."""
    return dmc.Select(
        id="select-component",
        placeholder="Search pages...",
        searchable=True,
        clearable=True,
        w=240,
        size="sm",
        nothingFoundMessage="No pages found",
        leftSection=DashIconify(icon="mingcute:search-3-line", width=18),
        data=search_data(data),
        visibleFrom="sm",
        comboboxProps={"zIndex": 2000},
        **{"aria-label": "Search pages"},
        styles={
            "input": {
                "borderColor": "var(--mantine-color-gray-4)",
            }
        },
    )


def create_header(data):
    """Create application header with logo, search, and theme toggle"""
    return dmc.AppShellHeader(
        dmc.Group(
            [
                # Left section: Hamburger (mobile) + Burger (desktop collapse) + Logo
                dmc.Group(
                    [
                        dmc.ActionIcon(
                            DashIconify(icon="radix-icons:hamburger-menu", width=22),
                            id="drawer-hamburger-button",
                            variant="subtle",
                            size="lg",
                            color="gray",
                            hiddenFrom="md",
                            **{"aria-label": "Open navigation menu"},
                        ),
                        # Desktop-only burger: collapses/expands the AppShell navbar
                        # on md-xl screens. Default opened=True so users see the X
                        # state on first load (navbar visible).
                        #
                        # aria-label because Mantine's Burger renders a button
                        # with no text and adds no name of its own — the
                        # hamburger beside it and the icon links opposite all
                        # carry one, and this was the last icon-only control on
                        # the site announcing itself as just "button".
                        dmc.Burger(
                            id="desktop-navbar-toggle",
                            opened=True,
                            size="sm",
                            visibleFrom="md",
                            **{"aria-label": "Show or hide the documentation sidebar"},
                        ),
                        # The home link's accessible name comes from the
                        # aria-label, NOT the wordmark text: below xs the
                        # wordmark is display:none (visibleFrom), which
                        # REMOVES it from the accessibility tree — without
                        # the label the home link would have no name at all
                        # on phones, since the dock glyph beside it is
                        # decorative. Two forks hit this independently;
                        # visibleFrom (rather than dropping the node) also
                        # keeps the title element in the DOM for anything
                        # that targets it by id.
                        dmc.Anchor(
                            dmc.Group(
                                [
                                    DashIconify(
                                        icon="mdi:dock-window",
                                        width=30,
                                        color="var(--mantine-color-indigo-6)",
                                    ),
                                    dmc.Text(
                                        "flexlayout-dash",
                                        size="lg",
                                        fw=700,
                                        c="indigo",
                                        id="dash-docs-title",
                                        visibleFrom="xs",
                                    ),
                                ],
                                gap="sm",
                            ),
                            href="/",
                            underline=False,
                            **{"aria-label": "flexlayout-dash — home"},
                        ),
                    ],
                    gap="md",
                ),

                # Right section: backend badge + version + search + Other Apps
                # + PyPI + GitHub + theme toggle + Clerk avatar (when on)
                dmc.Group(
                    [
                        dmc.Box(create_backend_badge(), visibleFrom="sm"),
                        dmc.Box(create_version_badge(), visibleFrom="sm"),
                        create_search(data),
                        create_other_apps_menu(),
                        create_link(
                            "simple-icons:pypi",
                            "https://pypi.org/project/flexlayout-dash/",
                            "flexlayout-dash on PyPI",
                        ),
                        create_link(
                            "radix-icons:github-logo",
                            GITHUB_URL,
                            "View the source on GitHub",
                        ),
                        dmc.ActionIcon(
                            [
                                DashIconify(
                                    icon="radix-icons:sun",
                                    width=22,
                                    id="light-theme-icon",
                                ),
                                DashIconify(
                                    icon="radix-icons:moon",
                                    width=22,
                                    id="dark-theme-icon",
                                ),
                            ],
                            variant="subtle",
                            color="yellow",
                            id="color-scheme-toggle",
                            size="lg",
                            **{"aria-label": "Toggle light / dark color scheme"},
                        ),
                        create_clerk_avatar(),
                    ],
                    gap="sm",
                ),
            ],
            justify="space-between",
            h=HEADER_HEIGHT,
            px="xl",
        ),
    )


clientside_callback(
    """
    function(value) {
        if (value) {
            return value
        }
    }
    """,
    Output("url", "href"),
    Input("select-component", "value"),
)

# Mobile drawer search → navigate (the header Select is hidden below `sm`).
clientside_callback(
    """
    function(value) {
        if (value) {
            return value
        }
        return window.dash_clientside.no_update
    }
    """,
    Output("url", "href", allow_duplicate=True),
    Input("mobile-select-component", "value"),
    prevent_initial_call=True,
)

# The overlay no longer covers the header, so the hamburger stays reachable
# while the drawer is open — make a second tap close it. (The old callback
# returned a constant `true`, so the button could only ever open it.)
clientside_callback(
    """function(n_clicks, opened) { return !opened }""",
    Output("components-navbar-drawer", "opened"),
    Input("drawer-hamburger-button", "n_clicks"),
    State("components-navbar-drawer", "opened"),
    prevent_initial_call=True,
)
