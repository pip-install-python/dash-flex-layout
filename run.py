"""flexlayout-dash documentation site.

A lean, Flask-only Dash app that renders the markdown docs under ``docs/`` and
serves AI/LLM + SEO surfaces (/llms.txt, /<page>/llms.txt, /robots.txt,
/sitemap.xml) via dash-improve-my-llms 2.3.3.

Deployed at https://flexlayout.2plot.dev as a 2plot network satellite:

  * directory — lib/network_directory.py  -> cross-host peer graph
  * ads       — lib/ad_client.py          -> 2plot.dev/api/ad-network/serve
  * traffic   — lib/analytics_tracker.py + lib/traffic_rollup.py
                + lib/satellite_reporter.py -> 2plot.ai/api/satellite/traffic
  * health    — lib/health.py             -> /healthz for the hub's sweep

Ads and traffic reporting are DORMANT without their environment keys, so a
plain ``python run.py`` is just the docs — no outbound calls, no secrets
needed. There is no Clerk auth on this site: every page is public.

Run with:  python run.py   ->  http://localhost:8055
"""
import os

from dotenv import load_dotenv

# MUST run before the first-party imports below: lib/ad_client.py reads
# AD_SERVER_URL / AD_APP_ID at *import* time, so a .env loaded any later is
# silently ignored for exactly those values. (Same trap dash-email hit.)
# See .env.example for every key this app reads.
load_dotenv()

# NOTE: no sys.path manipulation. This file sits in the repo root beside the
# built `flexlayout_dash/` package, so the live `.. exec::` examples import it
# directly. (It needed a path insert while the site lived in documentation/.)

import dash
from dash import Dash, Input, Output, clientside_callback

from components.appshell import create_appshell
from lib import bulletin, network_directory, page_tiers
from lib.analytics_tracker import tracker
from lib.constants import (
    BASE_URL,
    SITE_BRAND,
    SITE_DESCRIPTION,
    require_owned_base_url,
)
from lib.health import register_health_route
from lib.satellite_reporter import start_reporter

# AI/LLM Integration & SEO — dash-improve-my-llms 2.3.3 (Flask adapter).
from dash_improve_my_llms import (
    add_llms_routes,
    LLMSConfig,
    RobotsConfig,
    register_page_metadata,
)

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
    disallowed_paths=[],
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


# Tiered corpus documents (dash-improve-my-llms >= 2.4.0). Pseudo-paths:
# they never enter dash.page_registry, so they cannot leak into listings —
# registering them here gives this satellite the same tier knobs as the rest
# of the fleet (LLMS_SMALL_TIER / LLMS_FULL_TIER; unset = the default tier,
# i.e. public), so the 402 experiment can tighten the full corpus per
# satellite by flipping an env var. This site wires no access control, so
# the tiers are recorded (lib/page_tiers.py), not enforced — instrument
# first, price later. Inert on older package versions.
page_tiers.register("/llms-small.txt", os.environ.get("LLMS_SMALL_TIER"))
page_tiers.register("/llms-full.txt", os.environ.get("LLMS_FULL_TIER"))

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


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port="8055")
