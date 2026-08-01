import os

# ---------------------------------------------------------------------------
# Site identity — one string, every surface
# ---------------------------------------------------------------------------
# The network standard (2plot.ai, 2plot.dev and the documentation boilerplate
# all ship it): a site states what it is, in the same words, on every surface
# an agent or a reader can reach. The surfaces this brand has to reach, and
# what serves each:
#
#   Dash(title=SITE_BRAND)              -> <title>, and the fallback identity
#   register_page_metadata(path="/",    -> the /llms.txt H1 and the llms
#       name=SITE_BRAND)                   viewer's brand chip, both via
#                                          dash-improve-my-llms 2.3.4's
#                                          `resolve_site_title`
#   docs/home/home.md's opening `# `    -> the home page's own prose
#
# tests/test_site_identity.py pins all of them to this constant, because the
# failure is silent: `resolve_site_title` SKIPS generic candidates ("Home",
# "Index", Dash's default "Dash") rather than publishing them, so a site that
# never states its identity falls through to whatever is left and nothing
# looks broken. This host shipped both halves of that failure before the
# standard: no `Dash(title=)` at all, and docs/home/home.md registered as
# "Home" — so the root /llms.txt H1 read "# Home" and the viewer chip "Dash".
#
# Naming rules, from the network standard:
#   - the PACKAGE NAME belongs in the description, not in the brand;
#   - "Pip Install Python" is the byline (who made it), never the site name.
SITE_BRAND = "flexlayout-dash — resizable panel layouts for Dash"

SITE_DESCRIPTION = (
    "flexlayout-dash — IDE-style dockable, resizable and floatable window "
    "panels for Plotly Dash. Wraps FlexLayout-React with portal-based "
    "rendering, so drag-and-drop tabs, split panes, collapsible edge borders "
    "and pop-out windows all keep ordinary Dash callbacks working. "
    "By Pip Install Python."
)

# The brand without its tagline, for the places that prefix something else and
# would otherwise run past every platform's truncation point.
SITE_SHORT_NAME = "flexlayout-dash"

# Prefixed to every per-page title (`pages/markdown.py`), and therefore NOT
# only a browser-tab string: Dash passes the page title straight into
# `og:title` and `twitter:title` (dash/_pages.py `_page_meta_tags`), so this
# is the headline on every share card the site produces. Network convention:
# the SHORT site name, then a pipe — derived rather than retyped so the two
# cannot drift apart; tests/test_site_identity.py pins the relationship.
PAGE_TITLE_PREFIX = f"{SITE_SHORT_NAME} | "

PRIMARY_COLOR = "indigo"
# Reported by /healthz to the 2plot.ai pulse sweep. Keep in sync with
# package.json — scripts/check_release.py enforces it.
APP_VERSION = "1.2.0"

# ---------------------------------------------------------------------------
# Public origin
# ---------------------------------------------------------------------------
# Drives <link rel="canonical"> on every page, the absolute URLs in
# sitemap.xml, and the "this app" entry in /llms.txt. The default IS this
# site's real domain (unlike the boilerplate, whose default is a footgun for
# forks); override only for a preview/staging host. Mirrored by
# FLEXLAYOUT_BASE_URL in render.yaml.
BASE_URL = os.environ.get(
    "FLEXLAYOUT_BASE_URL", "https://flexlayout.2plot.dev"
).rstrip("/")


def require_owned_base_url(base_url: str = BASE_URL) -> None:
    """Fail fast in production when BASE_URL is a platform hostname.

    ``*.onrender.com`` etc. still resolve after a custom domain is attached,
    so canonicals pointing there split link equity across two hostnames for as
    long as nobody notices. Only enforced when a hosting platform is detected
    (Render sets ``RENDER``; ``APP_ENV=production`` works anywhere else), so
    local development and the test suite are unaffected.
    """
    in_production = bool(os.environ.get("RENDER") or os.environ.get("APP_ENV") == "production")
    if not in_production:
        return
    for platform_host in ("onrender.com", "herokuapp.com", "railway.app", "fly.dev"):
        if platform_host in base_url:
            raise RuntimeError(
                f"FLEXLAYOUT_BASE_URL={base_url!r} is a platform-generated "
                "hostname. Canonical tags, sitemap.xml and llms.txt would all "
                "point at it instead of the custom domain, splitting link "
                "equity across two hosts. Set it to the public domain."
            )


# ---------------------------------------------------------------------------
# The social card
# ---------------------------------------------------------------------------
# Served from the 2plot CDN rather than this app's own /assets, deliberately:
# a link preview is fetched by Facebook, Twitter/X, Slack, Discord and
# LinkedIn — none of which wait for a free-tier container to wake from sleep.
# The CDN answers immediately whether or not this site is cold.
#
# Dash builds `og:image` and `twitter:image` for every page from
# `register_page(image_url=...)` and emits `content=""` when it finds nothing
# (dash/_pages.py) — an EMPTY og:image unfurls worse than no tag at all,
# because scrapers treat the empty value as the declared image and render a
# blank card. So `image_url=OG_IMAGE_URL` is passed at EVERY register_page in
# pages/markdown.py; a single missing one reintroduces the blank card on that
# page.
#
# Rendered by `scripts/make_social_card.py --domain flexlayout.2plot.dev`
# (1200x630 = 1.91:1, the Open Graph ideal) and uploaded BY HAND to the
# Cloudflare bucket — there is no automated path to it. THE ORDER MATTERS:
# verify the CDN object answers 200 with real 1200x630 IHDR pixels BEFORE any
# deploy serves this URL in og:image; a 404 card is worse than none.
# `scripts/smoke_live.py` re-checks the real pixels after every deploy.
OG_IMAGE_URL = "https://cdn.2plot.ai/github_assets/flexlayout.2plot.dev.png"
OG_IMAGE_WIDTH = 1200
OG_IMAGE_HEIGHT = 630
OG_IMAGE_TYPE = "image/png"
OG_IMAGE_ALT = SITE_BRAND

# ---------------------------------------------------------------------------
# The network's internal-traffic contract
# ---------------------------------------------------------------------------
# The analytics point of truth is https://2plot.ai/docs/satellite-analytics
# ("Internal traffic"): any request whose User-Agent contains
# INTERNAL_UA_TOKEN is 2plot network machinery talking to itself — the hub's
# hourly health sweep, CI smoke batteries, the 4x-daily heartbeat, this app's
# own server-to-server calls to the hub. It is counted NOWHERE.
#
# Two halves, and both are required for the contract to hold:
#
#   inbound  — every tracker drops a token-carrying request at WRITE time,
#              before device detection and before bot classification, so it
#              never reaches the ledger the rollup is built from;
#   outbound — every call this host makes to another network host sends
#              INTERNAL_UA, so the far side can apply the same rule.
#
# The outbound half is the one a pre-standard satellite always misses:
# lib/ad_client.py fetching campaigns from 2plot.dev as bare
# `python-requests` gets classified as a bot by the hub's tracker, so this
# satellite's readers inflate 2plot.dev's bot_hits. The signed rollup POST in
# lib/satellite_reporter.py has the same shape.
#
# The token string must stay byte-identical across the network; it mirrors
# 2plotai/lib/constants.py, pip-docs+/lib/constants.py and the boilerplate's.
INTERNAL_UA_TOKEN = "2plot-internal"
INTERNAL_UA = "2plot-internal/1.0 (+https://2plot.ai/docs/satellite-analytics)"


def internal_ua(caller: str = "") -> str:
    """``INTERNAL_UA`` with a caller suffix, e.g. ``"ad-client"``.

    The suffix is for reading logs on the far side; only the token matters to
    the contract, and it stays intact whatever the suffix says.
    """
    caller = (caller or "").strip()
    return f"{INTERNAL_UA} {caller}" if caller else INTERNAL_UA


# 2plot network links, surfaced in the README and the docs footer/header.
GITHUB_URL = "https://github.com/pip-install-python/dash-flex-layout"
DISCORD_URL = "https://discord.gg/WEnZR35mrK"
YOUTUBE_URL = "https://www.youtube.com/channel/UC6Bmo0t0ZUpU_xKBYW0bJuQ"

# Populated by pages/markdown.py as documentation files load. Used by the
# "Copy for LLM" button to surface each page's raw markdown.
NAME_CONTENT_MAP = {}

# Mantine style props excluded from auto-generated `.. kwargs::` tables so the
# tables show only the component's own props, not the shared style-prop surface.
PROPS_TO_EXCLUDE = [
    "unstyled",
    "m", "my", "mx", "mt", "mb", "ms", "me", "ml", "mr",
    "p", "py", "px", "pt", "pb", "ps", "pe", "pl", "pr",
    "bg", "c", "opacity",
    "ff", "fz", "fw", "lts", "ta", "lh", "fs", "tt", "td",
    "w", "miw", "maw", "h", "mih", "mah",
    "bgsz", "bgp", "bgr", "bga",
    "pos", "top", "left", "bottom", "right", "inset",
    "display", "flex",
]
