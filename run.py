"""flexlayout-dash documentation site.

A lean, Flask-only Dash app that renders the markdown docs under ``docs/`` and
serves AI/LLM + SEO surfaces (/llms.txt, /<page>/llms.txt, /robots.txt,
/sitemap.xml) via dash-improve-my-llms >= 2.6.1.

Deployed at https://flexlayout.2plot.dev as a 2plot network satellite:

  * directory — lib/network_directory.py  -> cross-host peer graph
  * ads       — lib/ad_client.py          -> 2plot.dev/api/ad-network/serve
  * traffic   — lib/analytics_tracker.py + lib/traffic_rollup.py
                + lib/satellite_reporter.py -> 2plot.ai/api/satellite/traffic
                (hourly signed rollup + a ~60s presence ping)
  * health    — lib/health.py             -> /healthz for the hub's sweep
  * gate      — lib/auth.py + lib/access.py + lib/gate_layouts.py
                -> the interactive sign-in gate, OFF until env says otherwise

Ads, traffic reporting and Clerk are all DORMANT without their environment
keys, so a plain ``python run.py`` is just the docs — no outbound calls, no
secrets needed. Shipped DARK: PAGE_DEFAULT_TIER=public means every page is
public and the gate is wiring only. Flipping that env is the whole switch;
rolling back is flipping it again, with no code revert anywhere.

Run with:  python run.py   ->  http://localhost:8055
"""
import os
import sys

from dotenv import load_dotenv

# MUST run before the first-party imports below: lib/ad_client.py reads
# AD_SERVER_URL / AD_APP_ID at *import* time, so a .env loaded any later is
# silently ignored for exactly those values. (Same trap dash-email hit.)
# See .env.example for every key this app reads.
load_dotenv()

# ----------------------------------------------------------------------------
# THE FORK POINT — claim this app's network identity before any hub-facing
# module imports.
# ----------------------------------------------------------------------------
# Every module that names this app (satellite_reporter, ad_client, hub_client,
# bulletin) carries its own fallback default, and after a template sync those
# defaults DISAGREE: lib/satellite_reporter.py is byte-identical to the
# boilerplate's, so its fallback says "boilerplate", while this fork's other
# modules say "flexlayout". An unset SATELLITE_APP_KEY would therefore file
# this site's traffic under the TEMPLATE's hub row — found live on pannellum,
# 2026-08-21, and the same class as the flows-reported-as-boilerplate
# contamination in the hub's history.
#
# This repo previously closed the gap by editing the reporter's own default,
# which is what made it a pre-presence LOCAL FORK that could not be re-synced.
# The identity claim lives HERE now and the reporter stays byte-copyable
# (`shasum` against the boilerplate's is the acceptance check).
#
# setdefault, not assignment: a real env value (Render dashboard, .env — just
# loaded above) always wins; this line only closes the unset gap.
# FORKS CHANGE THIS ONE STRING.
os.environ.setdefault("SATELLITE_APP_KEY", "flexlayout")

# NOTE: no sys.path manipulation. This file sits in the repo root beside the
# built `flexlayout_dash/` package, so the live `.. exec::` examples import it
# directly. (It needed a path insert while the site lived in documentation/.)

import dash
from dash import Dash, Input, Output, clientside_callback

from components.appshell import create_appshell
from lib import bulletin, network_directory
from lib.analytics_tracker import tracker
from lib.constants import (
    BASE_URL,
    OG_IMAGE_ALT,
    OG_IMAGE_HEIGHT,
    OG_IMAGE_URL,
    OG_IMAGE_WIDTH,
    PUBLISHER,
    SAME_AS,
    SITE_BRAND,
    SITE_DESCRIPTION,
    require_owned_base_url,
)
from lib.health import register_health_route
from lib.satellite_reporter import start_reporter

# AI/LLM Integration & SEO — dash-improve-my-llms (Flask adapter).
from dash_improve_my_llms import (
    add_llms_routes,
    LLMSConfig,
    RobotsConfig,
    register_page_metadata,
)

# ----------------------------------------------------------------------------
# Dependency floor — enforced, not advised.
# ----------------------------------------------------------------------------
# This was a comment in requirements.txt first. That is not enough: an IDE run
# configuration pointing at another project's virtualenv starts this app quite
# happily against whatever versions that environment holds, serves visibly
# older behaviour, and nothing anywhere says so. Diagnosing it from the outside
# costs hours — the browser, the cache and the process all look innocent,
# because they are.
#
# Set ALLOW_STALE_DEPS=1 to downgrade to a warning if you are deliberately
# testing an older release.
ALLOW_STALE_DEPS = os.environ.get("ALLOW_STALE_DEPS", "0") == "1"

# 2.6.1 is the floor because 2.6.0's universal prerender ships the block with a
# literal `hidden` attribute, so every visibility-respecting consumer (HTML-to-
# text extractors, plausibly crawler content-weighting) reads "Loading..."
# instead of the page's prose — the outside-audit finding of 2026-08-22. THIS
# HOST served exactly that on 2026-08-22; tests/test_pages.py now pins the
# visible shape so it cannot come back.
LLMS_PKG_FLOOR = (2, 6, 1)


def _version(text: str) -> tuple:
    """("2.6.1rc0") -> (2, 6, 1). Trailing rc/dev segments are dropped."""
    parts = []
    for chunk in text.split(".")[:3]:
        digits = ""
        for char in chunk:
            if not char.isdigit():
                break
            digits += char
        if not digits:
            break
        parts.append(int(digits))
    return tuple(parts)


def _llms_pkg_version() -> str:
    import dash_improve_my_llms

    return getattr(dash_improve_my_llms, "__version__", "0")


LLMS_PKG_VERSION = _llms_pkg_version()

if LLMS_PKG_FLOOR > _version(LLMS_PKG_VERSION):
    detail = (
        f"dash-improve-my-llms {LLMS_PKG_VERSION} is below the "
        f"{'.'.join(str(n) for n in LLMS_PKG_FLOOR)} floor in requirements.txt. "
        "Below 2.6.1 the universal prerender ships `hidden`, so every "
        "visibility-respecting consumer (text extractors, arguably crawler "
        "content-weighting) reads 'Loading...' instead of the page's prose. "
        "Below 2.6.0 the sitemap goes back to lying: `lastmod=` is accepted "
        "into **kwargs and SILENTLY IGNORED, so every date docs/*/*.md stamps "
        "is swallowed and <lastmod> reverts to invented build dates. Below "
        "2.5.1 the Tier-B SEO standard unwinds too: `configure_seo` does not "
        "exist, the crawler <title> drops back to the bare page name, and "
        "/favicon.ico serves the app shell instead of an icon.\n"
        f"    running from: {sys.executable}\n"
        "    fix: point your run configuration at this project's own .venv, "
        "or reinstall with `pip install -r requirements.txt`.\n"
        "    (set ALLOW_STALE_DEPS=1 to start anyway)"
    )
    if not ALLOW_STALE_DEPS:
        raise RuntimeError("\n[flexlayout] " + detail)
    print("[flexlayout] WARNING: " + detail)

# Imported after the floor on purpose: on a pre-2.5.0 package this name does
# not exist, and the floor's diagnosis above beats a bare ImportError. The
# fallback exists only for ALLOW_STALE_DEPS=1.
try:
    from dash_improve_my_llms import configure_seo
except ImportError:  # pragma: no cover — ALLOW_STALE_DEPS with a pre-2.5.0 package

    def configure_seo(**_kwargs) -> None:
        print("[flexlayout] WARNING: configure_seo unavailable (pre-2.5.0 "
              "package) — crawler identity tags and root icons not emitted.")


# ----------------------------------------------------------------------------
# Clerk satellite auth. MUST run BEFORE Dash(...) — register_clerk_auth
# installs @dash.hooks callbacks that fire during app construction, so calling
# it afterwards silently does nothing. Fully optional: a no-op with no CLERK_*
# keys, which is the default and what a local `python run.py` gets.
# See lib/auth.py, whose two boot warnings (an unset or non-URL
# CLERK_SATELLITE_SIGN_IN_REDIRECT) are the deploy acceptance check by their
# ABSENCE.
# ----------------------------------------------------------------------------
from lib import auth as _auth  # noqa: E402

CLERK_ENABLED = _auth.register()

app = Dash(
    __name__,
    suppress_callback_exceptions=True,
    use_pages=True,
    update_title=None,
    prevent_initial_callbacks=True,
    # Declares ONLY what Dash omits: og:site_name/og:url, the og:image:*
    # auxiliaries, the manifest + apple-touch-icon + theme-color. Everything
    # per-page (og:title, og:image, twitter:*, description) is Dash's, from
    # register_page — see the comment block inside the template.
    index_string=open("templates/index.html").read(),
    # The prerender rewrites <title> per route, so for registered pages this
    # is only the fallback — but it is also `resolve_site_title`'s second
    # candidate (2.3.4), behind the home page's registered name. One brand
    # constant on every surface; see lib/constants.py.
    title=SITE_BRAND,
)

# ----------------------------------------------------------------------------
# AI/LLM & SEO configuration
# ----------------------------------------------------------------------------
# The public origin, used for canonical URLs, sitemap.xml and llms.txt. The
# package's prerender writes the canonical tag from this value, so it is what
# consolidates hits on the *.onrender.com host onto the custom domain rather
# than letting them compete. Defined in lib/constants.py (FLEXLAYOUT_BASE_URL
# env override, mirrored in render.yaml); the guard refuses to boot a
# production deploy whose canonical points at a platform hostname.
app._base_url = BASE_URL
require_owned_base_url()

# Block training crawlers; allow AI-search citations and traditional search.
#
# The flag was False while this comment already claimed otherwise — an
# inherited mismatch, fixed 2026-07-31. It is now True, which is the network
# default and only became safe in 2.3.3: earlier releases had the Anthropic
# taxonomy wrong and blocking training also blocked the legacy aliases that
# claude.ai uses to fetch a page a user pasted. 2.3.3 separates them, so
# GPTBot/ClaudeBot/CCBot are disallowed while Claude-User, Claude-SearchBot,
# ChatGPT-User and OAI-SearchBot stay allowed.
#
# Net effect: this site can still be cited and fetched on demand by assistants,
# but is not bulk-scraped into a training set.
app._robots_config = RobotsConfig(
    block_ai_training=True,
    allow_ai_search=True,
    allow_traditional=True,
    crawl_delay=10,
    # The owner-only control board. `mark_hidden("/admin/control-board")` in
    # pages/control_board.py already keeps it out of /sitemap.xml, out of the
    # MCP resource set, out of the prerender, and 404s crawler requests — but
    # MEASURED against dash-improve-my-llms 2.6.1, it does NOT write a robots
    # rule (the template's comment claiming otherwise overstates it). This is
    # the missing half, and it costs nothing: a crawler that never requests
    # the path never has to be 404'd. Note this is the ADMIN surface only —
    # gated documentation pages stay listed in robots and the sitemap by
    # network policy, because gating who may READ a page is not a reason to
    # hide that it exists.
    disallowed_paths=["/admin/"],
)

# `name` here is not a nav label — dash-improve-my-llms 2.3.4 resolves it into
# the /llms.txt H1 and the llms viewer's brand chip (`resolve_site_title`,
# home-page name first, `app.title` second, generic values like the "Home"
# that docs/home/home.md registers under are skipped). It is the site's
# published identity, so it is SITE_BRAND and nothing else; the package name
# lives in the description. 2.2+ MERGES, so the home page's llms_doc from
# pages/markdown.py stays untouched. See lib/constants.py.
register_page_metadata(
    path="/",
    name=SITE_BRAND,
    description=SITE_DESCRIPTION,
    # The docs pages are TechArticles (pages/markdown.py); the front door is
    # the thing itself. No `lastmod`: the home page declares none — network
    # standard, and it is the one page whose content is a rolling summary
    # rather than a dated document.
    schema_type="SoftwareApplication",
)

# ============================================================================
# Site identity for the CRAWLER document (dash-improve-my-llms 2.5.0+).
# ============================================================================
# Until 2.5.0 the generated crawler HTML carried the page's content signals and
# none of its identity: browsers got the icon links, og:image and a twitter
# card from templates/index.html while Googlebot got zero of any of them, on
# every host in the network — so search showed the generic globe. One
# declaration covers every crawler surface, and it also claims /favicon.ico
# (Google's fallback), which Dash's page catch-all was answering with the app
# shell. Content may differ between the crawler document and the browser
# document; identity may not.
#
# THE ICON LIST IS THIS SITE'S OWN, and deliberately shorter than the
# template's. flexlayout.2plot.dev draws its own mark
# (scripts/make_brand_assets.py) into a four-file set — favicon.ico,
# favicon-192, favicon-512, apple-touch-icon — not the template's eight-file
# realfavicongenerator layout. Copying the template's list verbatim would
# publish five hrefs that 404 here (android-chrome-*, favicon-16x16/32x32/
# 96x96): a head full of broken icon links looks fixed and is worse than
# declaring fewer. The rule is every emitted href RESOLVES and the declaration
# is SET-EQUAL to what 2.6's autodiscovery finds — tests/test_seo_icons.py
# pins both, and pins that these are the same paths templates/index.html
# links, so the two heads agree.
configure_seo(
    icons=[
        "/assets/favicon/favicon.ico",
        {"href": "/assets/favicon/favicon-192.png", "sizes": "192x192"},
        {"href": "/assets/favicon/favicon-512.png", "sizes": "512x512"},
        {"href": "/assets/favicon/apple-touch-icon.png",
         "rel": "apple-touch-icon", "sizes": "180x180"},
    ],
    social_image=OG_IMAGE_URL,
    social_image_alt=OG_IMAGE_ALT,
    social_image_width=OG_IMAGE_WIDTH,
    social_image_height=OG_IMAGE_HEIGHT,
    publisher=PUBLISHER,
    same_as=SAME_AS,
)

# ----------------------------------------------------------------------------
# Cross-host network directory
# ----------------------------------------------------------------------------
# Publishes the peer graph: <link rel="related"> tags in <head>, a `## Network`
# section in /llms.txt, and followed links in the prerendered body. An agent
# landing here otherwise sees one library with nothing saying the rest of the
# network exists — sitemap.xml cannot express it, being single-origin by design.
#
# MUST run before add_llms_routes, which is what renders the directory.
# `peers_for()` inside strips this app from its own peer list.
network_directory.apply(app._base_url)

# ----------------------------------------------------------------------------
# Visitor analytics — MUST be registered BEFORE add_llms_routes.
# ----------------------------------------------------------------------------
# Flask runs `before_request` hooks in REGISTRATION order, and the package's bot
# middleware answers AI-search crawlers itself and short-circuits the request.
# A hook registered after it never runs for exactly the crawler traffic a docs
# site most wants counted, and the bot_hits reported to 2plot.ai would be
# quietly too low. (FastAPI is the mirror image — Starlette runs the
# last-added middleware outermost — but this site is Flask-only.)
@app.server.before_request
def _track_visitor():
    from flask import request

    try:
        # Headers are passed so the tracker can read the REAL client IP and
        # country from the proxy. Behind Render, remote_addr is the proxy, so
        # every visitor would otherwise look like one single visitor.
        tracker.track_visit(
            request.path,
            request.headers.get("User-Agent", ""),
            headers=dict(request.headers),
        )
    except Exception:  # noqa: BLE001 — analytics must never break a page view
        pass


# ============================================================================
# Access control (dash-improve-my-llms 2.3+). Reads the tiers the pages just
# declared, so it must run after they are registered and before the routes are
# attached. The policy and the reasoning live in lib/access.py.
# ============================================================================

from lib import access as _access  # noqa: E402
from lib import page_tiers as _page_tiers  # noqa: E402
from lib import page_visibility as _page_visibility  # noqa: E402

# Tiered corpus documents (dash-improve-my-llms >= 2.4.0). Pseudo-paths: they
# never enter dash.page_registry, so they cannot leak into listings —
# registering them here gives this satellite the same tier knobs as the rest of
# the fleet, so the 402 experiment can tighten the full corpus per satellite by
# flipping an env var. The explicit `or "public"` matters: these registered
# under the PAGE_DEFAULT_TIER fallback before, which meant flipping that env to
# gate the *interactive* site would silently gate the corpus documents too.
# Their tier is now always a deliberate setting, never an ambient default.
_page_tiers.register("/llms-small.txt",
                     os.environ.get("LLMS_SMALL_TIER") or "public")
_page_tiers.register("/llms-full.txt",
                     os.environ.get("LLMS_FULL_TIER") or "public")

# The home page registers through pages/markdown.py like every other doc, so
# its frontmatter could pin a tier — but under PAGE_DEFAULT_TIER=auth an
# unpinned front door would silently inherit the gate. Pin it here, in code,
# where it cannot be edited away by a frontmatter change: the funnel's front
# door stays public, always.
_page_tiers.register("/", "public")

# force= when either gate env is present: with every tier still public the
# auto-detect would skip the wiring, but a host that flips by env needs the
# verdict plumbing (and the prerender's use of it) live during the dark launch,
# not on the flip. This is the ordering rule from the plan — enforcement is
# verified live BEFORE the env flip, never after.
ACCESS_ENABLED = _access.configure(
    force=bool(os.environ.get("PAGE_DEFAULT_TIER")
               or os.environ.get("LLMS_PUBLIC_DEFAULT"))
)

# Wire up /llms.txt, /<page>/llms.txt, /robots.txt, /sitemap.xml, the bot
# middleware and the universal prerender (which owns the canonical link and
# per-page <title> on the CRAWLER path; the browser path's site-level tags
# live in templates/index.html — see the rule documented there).
# Works on the Flask backend with no extra gating.
add_llms_routes(app, LLMSConfig(warn_missing_llms_doc=True))

# The hub's announcement feed, rendered in the llms.txt viewer's header
# (lib/bulletin.py). A function that returns whether it wired, and a boot
# line that says so — never four commentable lines: the boilerplate shipped
# exactly that, commented out for weeks against a hub endpoint that was
# already serving, and an announcement that never appears is not a symptom
# anyone notices. tests/test_bulletin.py fails if this call is commented out.
print(
    f"[flexlayout] network bulletin: "
    f"{'wired -> ' + (bulletin.url() or '') if bulletin.configure() else 'off (NETWORK_BULLETIN_URL unset)'}"
)

app.layout = create_appshell(dash.page_registry.values())

# ----------------------------------------------------------------------------
# /healthz — the 2plot.ai hub sweeps this hourly for the network health panel.
# ----------------------------------------------------------------------------
# Served whether or not traffic reporting is enabled, which is what makes it a
# cleaner Render health check than `/`.
register_health_route(app, "flask")

# ----------------------------------------------------------------------------
# SPA pageview beacon — a LOCAL ADDITION, not part of the network template.
# ----------------------------------------------------------------------------
# A Dash multi-page app serves ONE HTML request per visit; every later page is a
# client-side route change that never reaches the server. The `before_request`
# hook above therefore sees entry pages only, which would report every session
# as single-page and leave median_session_s null forever.
#
# The site this replaced had such a beacon, so dropping it would have silently
# degraded these numbers. Bots do not run JS, so bot_hits stay request-only —
# which is correct. Mounted BEFORE add_llms_routes' catch-all would matter for
# /llms.txt paths; /api/pageview collides with nothing.
@app.server.post("/api/pageview")
def _pageview():
    from flask import jsonify, request

    data = request.get_json(silent=True) or {}
    path = data.get("path")
    if not isinstance(path, str) or not path.startswith("/") or len(path) > 200:
        return jsonify({"ok": False}), 400
    try:
        tracker.track_visit(path, request.headers.get("User-Agent", ""),
                            headers=dict(request.headers))
    except Exception:  # noqa: BLE001
        pass
    return jsonify({"ok": True})


# The browser half of the beacon. `prevent_initial_call=True` keeps the entry
# page out of it — that one already arrived as a real HTTP request and was
# counted by the before_request hook. `keepalive` so a navigation away does not
# cancel the report.
clientside_callback(
    """
    function(pathname) {
        if (pathname) {
            try {
                fetch('/api/pageview', {
                    method: 'POST',
                    keepalive: true,
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({path: pathname})
                }).catch(function(){});
            } catch (e) {}
        }
        return window.dash_clientside.no_update;
    }
    """,
    Output("satellite-pageview-beacon", "data"),
    Input("url", "pathname"),
    prevent_initial_call=True,
)


# ----------------------------------------------------------------------------
# Hourly signed traffic rollup -> https://2plot.ai/api/satellite/traffic
# ----------------------------------------------------------------------------
# No-op unless CROSS_APP_WEBHOOK_SECRET is set. Reports under the key from
# lib/satellite_reporter.app_key() ("flexlayout").
start_reporter()

server = app.server

# ============================================================================
# The person->agent handoff: /api/agent-key turns the browser's Clerk session
# into a portable ?key= for copied llms.txt URLs (lib/agent_key.py). Those URLs
# get pasted into Claude or ChatGPT, which fetch them with no cookie — so a
# gated document needs its authority in the URL or the agent gets the gate page
# instead of the docs. 204 for everyone until Clerk and the hub are configured,
# so it is safe to mount always.
# ============================================================================

from lib.agent_key import register_agent_key_route  # noqa: E402

register_agent_key_route(app, "flask")

# The gate's one-line state of the world. Read it in the deploy log: it names
# the default tier, how many pages sit above it, which way the machine-surface
# axis points, and whether the access wiring actually attached. The three
# ABSENCES beside it are the rest of the acceptance check — no [visibility]
# warning (lib/page_visibility.py: the disk is really mounted and
# PAGE_VISIBILITY_FILE really reached the service) and no [auth] warning
# (lib/auth.py: CLERK_SATELLITE_SIGN_IN_REDIRECT is set and is a URL).
_non_public = sum(1 for t in _page_tiers.registered().values() if t != "public")
print(
    f"[flexlayout] interactive gate: default tier "
    f"'{os.environ.get('PAGE_DEFAULT_TIER') or 'public'}', "
    f"{_non_public} non-public page(s), machine surfaces "
    f"{'GATED' if not _page_tiers.get_llms_public('/__probe__') else 'open'} "
    f"by default (LLMS_PUBLIC_DEFAULT), access wiring "
    f"{'ON' if ACCESS_ENABLED else 'off'}, Clerk "
    f"{'ON' if CLERK_ENABLED else 'off'}, control board at "
    f"/admin/control-board ({_page_visibility.override_count()} live "
    f"override(s)), dash-improve-my-llms {LLMS_PKG_VERSION}."
)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port="8055")
