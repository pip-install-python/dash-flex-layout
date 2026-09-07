"""The navigation contract (item 16) — uniform where it must be, free where it may.

Owner's brief of 2026-08-30 (DESIGN-navigation-uniformity): the sidebar's
sections come from frontmatter against CATEGORY_ORDER; the network is ONE
registry rendered as the top bar's Other Apps menu; Resources is one
constant; Admin is owner-only and absent from the tree otherwise; every
icon-only control has a name; no `dcc.*` where DMC has the component. Each
pin here is one line of that brief, adapted to this fork's own page set
(no /backend-comparison here — the six topic docs stand in for it).
"""

from __future__ import annotations

import re
from pathlib import Path

import pytest

REPO = Path(__file__).resolve().parent.parent
ALLOWED_DCC = {"Location", "Store", "Interval", "Upload", "Graph"}


def _calls(src: str, name: str):
    """Yield the source text of every `name(` call, parens balanced."""
    for m in re.finditer(re.escape(name) + r"\(", src):
        depth, i = 0, m.start()
        while i < len(src):
            if src[i] == "(":
                depth += 1
            elif src[i] == ")":
                depth -= 1
                if depth == 0:
                    yield src[m.start():i + 1]
                    break
            i += 1


# ------------------------------------------------------------- a11y --


@pytest.mark.parametrize("control", ["dmc.Burger", "dmc.ActionIcon"])
def test_every_icon_only_control_in_components_has_a_name(control):
    """Every Burger/ActionIcon in components/ carries aria-label."""
    unlabelled = []
    for path in sorted((REPO / "components").glob("*.py")):
        for call in _calls(path.read_text(), control):
            if "aria-label" not in call:
                unlabelled.append(f"{path.name}: {call[:60]}…")
    assert unlabelled == [], unlabelled


def test_code_highlight_copy_button_has_a_name():
    src = (REPO / "lib" / "directives" / "source.py").read_text()
    assert "copyLabel=" in src and "copiedLabel=" in src


def test_no_dcc_where_dmc_has_the_component():
    """Fleet-wide rule: `dcc.` only for Location, Store, Interval, Upload,
    Graph (no DMC equivalent)."""
    offenders = []
    for folder in ("pages", "components"):
        for path in sorted((REPO / folder).glob("*.py")):
            code = "\n".join(line for line in path.read_text().splitlines()
                             if not line.lstrip().startswith("#"))
            for m in re.finditer(r"\bdcc\.([A-Za-z]+)", code):
                if m.group(1) not in ALLOWED_DCC:
                    offenders.append(f"{folder}/{path.name}: dcc.{m.group(1)}")
    assert offenders == [], offenders


def test_the_traffic_page_uses_a_date_picker_not_a_dropdown():
    src = (REPO / "pages" / "traffic.py").read_text()
    assert "dcc.Dropdown" not in src
    assert "dmc.DatePickerInput" in src and 'valueFormat="YYYY-MM-DD"' in src
    assert "presets=" in src and "minDate=" in src and "maxDate=" in src


# --------------------------------------------------------- registry --


def test_other_apps_menu_is_the_registrys_primary_set(app_module):
    """The PRIMARY applications only — never the docs subdomains — from
    the registry, no duplicates, self omitted, short labels (the domain)."""
    from components.header import create_other_apps_menu
    from lib.constants import BASE_URL
    from lib.network_directory import AFFILIATED, PEERS, PRIMARY, other_apps_for

    menu = create_other_apps_menu()
    items = menu.children[1].children
    hrefs = [i.href for i in items]
    expected = [e["url"] for e in other_apps_for(BASE_URL)]
    assert hrefs == expected
    assert set(h.rstrip("/") for h in hrefs) == PRIMARY - {BASE_URL.rstrip("/")}
    assert {"https://2plot.ai", "https://2plot.dev", "https://2plot.media",
            "https://piratesbargain.com", "https://ai-agent.buzz"} == set(PRIMARY)
    assert PRIMARY <= {e["url"].rstrip("/") for e in PEERS + AFFILIATED}, "PRIMARY names a URL the registry lacks"
    assert not any(".2plot.dev" in h for h in hrefs), "a docs subdomain leaked into the menu"
    assert len(set(hrefs)) == len(hrefs), "a host is listed twice"
    for item in items:
        label = item.children
        assert "." in label and " " not in label and "—" not in label, label
        assert item.target == "_blank"


def test_resources_are_third_party_only():
    """The sidebar's Resources holds dmc and the upstream project only;
    the owner's own links (this repo, Discord, YouTube) are top bar +
    footer, never here. UPSTREAM may legitimately live on GitHub (this
    fork's FlexLayout entry does) — the banned check is on the OWNER's own
    constants, not the bare substring "github.com"."""
    from lib.constants import DISCORD_URL, GITHUB_URL, YOUTUBE_URL, resources

    items = resources()
    assert items[0]["label"] == "dmc" and items[0]["url"] == "https://www.dash-mantine-components.com/"
    urls = [r["url"] for r in items]
    for banned in (GITHUB_URL, DISCORD_URL, YOUTUBE_URL,
                   "community.plotly.com", "https://2plot.dev"):
        assert not any(banned in u for u in urls), banned
    assert not any("discord" in u or "youtube" in u for u in urls)
    # this fork's freedom: FlexLayout is the upstream project it wraps
    assert items[1]["label"] == "FlexLayout (React)"
    assert items[1]["url"] == "https://github.com/caplin/FlexLayout"


def test_github_icon_and_same_as_share_one_constant(app_module):
    from components.header import create_header

    from lib.constants import GITHUB_URL, SAME_AS

    assert GITHUB_URL in SAME_AS
    assert GITHUB_URL.startswith("https://github.com/pip-install-python/")
    assert GITHUB_URL.count("/") == 4, "the REPOSITORY, not the profile"
    assert GITHUB_URL in str(create_header([]))


# ---------------------------------------------------------- sidebar --


def test_sections_follow_category_order_and_never_hold_admin(app_module):
    import dash

    from components.navbar import sections_for
    from lib.constants import CATEGORY_ORDER

    data = list(dash.page_registry.values())
    sections = sections_for(data)
    titles = [t for t, _ in sections]
    known = [t for t in titles if t in CATEGORY_ORDER]
    assert known == [c for c in CATEGORY_ORDER if c in titles], titles
    for _, entries in sections:
        assert not any(e["path"].startswith("/admin/") for e in entries)
        assert not any(e["path"] in ("/", "/changelog", "/api") for e in entries)
    # every one of this fork's docs pages declares a category
    assert "Documentation" not in titles, "a docs page lost its category: frontmatter"


def test_frontmatter_order_sorts_within_a_section(app_module):
    import dash

    from components.navbar import sections_for

    for title, entries in sections_for(dash.page_registry.values()):
        orders = [int(e.get("order") or 1000) for e in entries]
        assert orders == sorted(orders), (title, orders)


def test_anonymous_tree_has_no_admin_href(app_module, monkeypatch):
    """Hidden, not blocked. The startup tree carries only an empty Admin
    placeholder; the callback returns nothing to a non-admin."""
    import dash

    from components.navbar import create_content, render_admin_section

    tree = str(create_content(dash.page_registry.values()))
    assert "/admin/" not in tree
    assert "navbar-admin-desktop" in tree
    monkeypatch.delenv("ALLOW_UNGATED_ADMIN", raising=False)
    assert render_admin_section("navbar-admin-desktop") == (None, None)


def test_admin_tree_lists_every_admin_page(app_module, monkeypatch):
    from components.navbar import render_admin_section

    monkeypatch.setenv("ALLOW_UNGATED_ADMIN", "1")
    desktop, mobile = render_admin_section("navbar-admin-desktop")
    text = str(desktop)
    assert "/admin/control-board" in text and "/admin/traffic" in text
    assert str(mobile) == text


def test_search_lists_only_sidebar_pages(app_module):
    import dash

    from components.navbar import search_data

    values = [d["value"] for d in search_data(dash.page_registry.values())]
    assert values and not any(v.startswith("/admin/") for v in values)
    assert "/" not in values and "/changelog" not in values


# ---------------------------------------------------------- footer --


def test_footer_is_the_contract(app_module):
    from datetime import datetime

    from components.footer import create_footer
    from lib.constants import DISCORD_URL, GITHUB_PROFILE_URL, GITHUB_URL, YOUTUBE_SUBSCRIBE_URL

    text = str(create_footer())
    assert f"© {datetime.now().year} Pip Install Python LLC" in text
    for href in (GITHUB_PROFILE_URL, DISCORD_URL, YOUTUBE_SUBSCRIBE_URL):
        assert href in text
    assert GITHUB_URL not in text, "the repo link is the top bar's; the footer links the profile"
    assert "/changelog" not in text, "the sidebar's single Changelog link is the one"
    # FLIPPED BY 1.6.44 item 15, and the flip is the item landing. This
    # assertion was CORRECT while the pages did not exist: linking /terms and
    # /privacy from every page while nothing served them is precisely the
    # soft-404 defect item 11 exists to catch, and Dash answers 200 for both
    # so no crawl would ever have found it. Now that both are registered
    # pages, the footer is the right place for them and their ABSENCE would
    # be the defect.
    assert "/terms" in text and "/privacy" in text, (
        "the Legal links left the footer — either put them back or "
        "unregister the pages; a site with a privacy page nobody can reach "
        "from a page is not much better than one without"
    )


# ------------------------------------------------------- changelog --


def test_changelog_page_is_the_file(app_module, client):
    from pages.changelog import parse_changelog

    versions = parse_changelog()
    newest = re.search(r"^## \[([^\]]+)\]", (REPO / "CHANGELOG.md").read_text(), re.M).group(1)
    assert versions and versions[0]["version"] == newest
    doc = client.get("/changelog/llms.txt", user_agent="Mozilla/5.0 (compatible; Googlebot/2.1)")
    assert doc.status == 200
    assert doc.text.startswith("# Changelog") and "\n# Changelog" not in doc.text, "the file's H1 was not deduplicated"
    assert f"## [{newest}]" in doc.text
    page = client.get("/changelog", user_agent="Mozilla/5.0 (compatible; Googlebot/2.1)")
    assert page.status == 200 and newest in page.text


# ------------------------------------------------------------- api --


def test_api_reference_reads_a_real_dash_package():
    """flexlayout_dash IS the API_PACKAGES entry — read the real installed
    package rather than a fixture, since this fork ships one."""
    from lib import api_reference

    comps = api_reference.load_package("flexlayout_dash")
    names = [c["name"] for c in comps]
    assert names == ["DashFlexLayout", "Tab"], "sorted, exported only"
    layout = comps[0]
    props = {p["name"]: p for p in layout["props"]}
    assert "setProps" not in props
    assert props["children"]["required"]
    assert layout["props"][0]["name"] == "id"
    md = api_reference.as_markdown(["flexlayout_dash"])
    assert "### DashFlexLayout" in md and "### Tab" in md


def test_api_page_renders_one_table_per_component():
    from pages.api import build_page

    text = str(build_page(["flexlayout_dash"]))
    assert "api-table-DashFlexLayout" in text and "api-table-Tab" in text


def test_api_page_is_registered_for_this_forks_own_package(app_module):
    import dash

    from lib.constants import API_PACKAGES

    assert API_PACKAGES == ["flexlayout_dash"], "this fork documents its own package"
    assert "/api" in [p["path"] for p in dash.page_registry.values()]


def test_missing_package_is_reported_not_raised():
    from lib import api_reference

    out = api_reference.load_packages(["no_such_dash_package_xyz"])
    assert out[0]["components"] == [] and "error" in out[0]


def test_reference_page_and_api_page_are_complementary_not_duplicate():
    """This fork's own resolution of the ops question: /reference is
    hand-written narrative (usage guidance, the model schema) that embeds
    `.. kwargs::` prop tables inline; /api is the auto-generated raw prop
    dump from metadata.json. Both stay registered — /api supplements
    /reference, it does not replace it."""
    import dash

    paths = {p["path"] for p in dash.page_registry.values()}
    assert "/reference" in paths and "/api" in paths


# ------------------------------------------------------- fix-forward --


def test_the_aside_collapses_on_pages_without_a_toc(app_module):
    """/changelog, home, /api and the admin pages render full width; the
    six topic docs (each with `.. toc::`) keep the aside column."""
    from lib.aside import aside_config, has_aside

    assert has_aside("/getting-started") and has_aside("/basic")
    for path in ("/changelog", "/", "/admin/traffic", "/api"):
        assert not has_aside(path), path
        assert aside_config(path)["collapsed"]["desktop"] is True
    assert aside_config("/getting-started")["collapsed"]["desktop"] is False
    assert aside_config(None)["collapsed"]["mobile"] is True


def test_the_mobile_drawer_is_always_mounted(app_module):
    """The burger must not depend on a mount-on-open transition, and
    #navbar-admin-mobile must exist on every load."""
    from components.navbar import create_navbar_drawer

    drawer = create_navbar_drawer([])
    assert drawer.keepMounted is True
    assert "navbar-admin-mobile" in str(drawer)


def test_code_blocks_cannot_widen_the_page():
    """The overflow rule lives in the stylesheet, for every container a
    code block can sit in — never a per-page fix."""
    css = (REPO / "assets" / "main.css").read_text()
    for selector in (".mantine-List-itemWrapper", ".mantine-List-itemLabel",
                     ".mantine-Timeline-itemBody", ".mantine-CodeHighlight-root",
                     ".mantine-CodeHighlightTabs-root", ".mantine-AppShell-main pre",
                     "table.m2d-block-kwargs", "code.m2d-codespan"):
        assert selector in css, selector
    # and the changelog's rows let an unbreakable code token wrap
    src = (REPO / "pages" / "changelog.py").read_text()
    assert '"overflowWrap": "anywhere"' in src and '"minWidth": 0' in src
    wrappers = css[css.index(".mantine-List-itemWrapper"):]
    assert "min-width: 0" in wrappers[:400]
    pre_rule = css[css.index(".mantine-AppShell-main pre"):]
    assert "overflow-x: auto" in pre_rule[:200]
    assert "overflow-wrap: anywhere" in css[css.index("code.m2d-codespan"):][:200]


def test_other_apps_dropdown_is_solid_and_every_primary_app_has_an_icon(app_module):
    from components.header import create_other_apps_menu
    from lib.network_directory import ICONS, PRIMARY

    dropdown = create_other_apps_menu().children[1]
    assert dropdown.styles["dropdown"]["backgroundColor"]
    for url in PRIMARY:
        assert ICONS.get(url) not in (None, "mdi:web"), f"{url} has no icon"


# ------------------------------------------------------------- item 18 --


def test_battery_hidden_paths_match_the_registry(app_module, client):
    """Subset-plus-reality-check, NOT equality (item 18 amendment). Every
    registered admin page must be listed (equality alone would still catch
    that half); anything EXTRA in the tuple beyond the registered admin
    pages must be verified as GENUINELY hidden (404 on the crawler lane),
    not assumed. Equality would delete a real hidden surface that is not
    under /admin/ (a canary, a retired page's llms.txt); subset alone
    loses the stale-canary detection that caught this fork's own drift:
    HIDDEN_DOC_PATHS still named two placeholder paths that were never
    real pages while /admin/traffic (a real page item 16 added) was
    unlisted."""
    import dash

    from scripts.network_smoke import HIDDEN_DOC_PATHS

    admin = {p["path"] for p in dash.page_registry.values() if p["path"].startswith("/admin/")}
    required = {f"{p}/llms.txt" for p in admin}
    listed = set(HIDDEN_DOC_PATHS)

    missing = required - listed
    assert not missing, f"registered admin pages missing from HIDDEN_DOC_PATHS: {missing}"

    extras = listed - required
    for path in extras:
        resp = client.get(path, user_agent="Mozilla/5.0 (compatible; Googlebot/2.1)")
        assert resp.status == 404, (
            f"HIDDEN_DOC_PATHS lists {path!r} as hidden but the crawler lane "
            f"answered {resp.status} — a stale canary the registry can't catch "
            "because it names no real page"
        )


def test_api_reference_falls_back_to_the_committed_extract_then_docstrings(tmp_path, monkeypatch):
    """metadata.json -> api_metadata.json (committed, stamped) ->
    docstrings (hook-based packages ship no metadata at all). This fork's
    own /api only ever exercises the first road (flexlayout_dash ships a
    real metadata.json); this proves the other two, ported wholesale into
    lib/api_reference.py, actually work rather than being dead code."""
    import json
    import sys

    from lib import api_reference

    # docstring-only package (modelviewer's shape)
    comps = api_reference.load_package("tests.fixtures.docstring_dash_pkg")
    assert [c["name"] for c in comps] == ["DocWidget"]
    props = {p["name"]: p for p in comps[0]["props"]}
    assert props["value"]["required"] and props["size"]["default"] == "'md'"
    assert props["id"]["description"].startswith("The ID")
    assert "setProps" not in props
    # slim extract wins over docstrings and carries the generated stamp
    pkg_dir = tmp_path / "slim_pkg"
    pkg_dir.mkdir()
    (pkg_dir / "__init__.py").write_text("class Only:\n    pass\n")
    (pkg_dir / api_reference.SLIM_METADATA).write_text(json.dumps({"generated": "2026-08-30", "components": [
        {"name": "Only", "description": "d", "props": [{"name": "id", "type": "string", "required": False, "default": "", "description": "x"}]}]}))
    monkeypatch.syspath_prepend(str(tmp_path))
    sys.modules.pop("slim_pkg", None)
    assert api_reference.load_package("slim_pkg")[0]["name"] == "Only"
    assert api_reference.slim_generated_on("slim_pkg") == "2026-08-30"
    assert api_reference.slim_generated_on("tests.fixtures.docstring_dash_pkg") is None


def test_api_markdown_escapes_pipes_in_every_cell():
    from lib import api_reference

    rows = [{"package": "x", "components": [{"name": "C", "description": "", "props": [
        {"name": "a|b", "type": "a | b", "required": False, "default": "x|y", "description": "d|e\nf"}]}]}]
    import unittest.mock as um
    with um.patch.object(api_reference, "load_packages", return_value=rows):
        md = api_reference.as_markdown(["x"])
    assert "a\\|b" in md and "x\\|y" in md and "d\\|e f" in md


def test_every_test_client_user_names_headers():
    """A bare test client sends `Werkzeug/x.y` — crawler lane at dimll >= 2.8
    — so a mark_hidden page 404s and an every-page-200 loop goes red at the
    floor bump (exactly the scripts/smoke_test.py defect item 18's checks
    2/3 pass found and fixed on this fork). Any file that drives
    `.test_client()` must pass a User-Agent.

    `headers=` alone is NOT evidence: tests/test_llms_routes.py had a
    `headers={"CF-IPCountry": "FR"}` call that satisfied a bare `"headers="
    in src` check while naming no lane at all — a false negative found
    while tightening this pin (item 18 amendment). Look specifically for
    something UA-shaped."""
    offenders = []
    for folder in ("tests", "scripts"):
        for path in sorted((REPO / folder).glob("*.py")):
            src = path.read_text()
            names_ua = ("User-Agent" in src or "HTTP_USER_AGENT" in src
                       or "user_agent=" in src)
            if ".test_client()" in src and not names_ua:
                offenders.append(f"{folder}/{path.name}")
    assert offenders == [], offenders
