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

# The network standard's spelling of the same value. `run.py` and the ported
# tests read APP_TITLE; SITE_BRAND is this fork's older name and stays because
# lib/, docs/ and tests/ already reference it. Derived, never retyped — two
# spellings of one brand must not be able to drift.
APP_TITLE = SITE_BRAND

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
APP_VERSION = "2.0.0"

# ---------------------------------------------------------------------------
# Public origin
# ---------------------------------------------------------------------------
# Drives <link rel="canonical"> on every page, the absolute URLs in
# sitemap.xml, and the "this app" entry in /llms.txt. The default IS this
# site's real domain (unlike the boilerplate, whose default is a footgun for
# forks); override only for a preview/staging host.
#
# TWO env names, deliberately ("Found on the email pass" §4): APP_BASE_URL is
# the network-shared spelling that every host's scripts/ and tests/ can rely
# on; FLEXLAYOUT_BASE_URL is this repo's legacy alias, still set on the live
# service. Accept the shared name first, the legacy one second — and
# render.yaml sets BOTH, because removing one of two names from a live
# service is how a satellite quietly deindexes itself.
BASE_URL = (
    os.environ.get("APP_BASE_URL")
    or os.environ.get("FLEXLAYOUT_BASE_URL")
    or "https://flexlayout.2plot.dev"
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
# Publisher identity for the CRAWLER document (dash-improve-my-llms 2.5+)
# ---------------------------------------------------------------------------
# `configure_seo(publisher=, same_as=)` in run.py writes these into the
# crawler HTML's JSON-LD, where they are the machine-readable half of the same
# claim templates/index.html makes for browsers. `same_as` is the identity
# loop a docs satellite closes: this subdomain, the package's GitHub repo and
# its PyPI project all pointing at each other is the strongest available
# statement that flexlayout.2plot.dev is flexlayout-dash's canonical docs
# home. The other two legs (PyPI `project_urls`, the README pointing back
# here) are a per-package checklist item, not code.
PUBLISHER = "Pip Install Python LLC"
SAME_AS = [
    "https://github.com/pip-install-python/dash-flex-layout",
    "https://pypi.org/project/flexlayout-dash/",
]

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

# The FLEET PROBE spelling (1.6.44 item 4). Every file that fetches a host —
# workflows, batteries, link audits — sends an ENGINE token followed by this
# suffix, so the far side can read "2plot machinery, and which engine it was
# pretending to be". Suppression is still the tracker's job, not the UA's:
# the suffix carries INTERNAL_UA_TOKEN, so the write-time drop applies
# unchanged. What the `/probe` spelling adds is legibility on the far side's
# log, not a second mechanism.
PROBE_UA_SUFFIX = f"{INTERNAL_UA_TOKEN}/probe"


def probe_ua(engine: str, caller: str = "") -> str:
    """A fleet probe UA: ``engine`` token, ``PROBE_UA_SUFFIX``, then ``caller``.

    ``engine`` is required and must be a real vendor-or-engine token; a probe
    with no engine token is classified crawler-lane at dimll >= 2.8 whatever
    it meant, which silently swaps the document under a browser-lane check.

    ``caller`` names which probe this is — ``"network-smoke"``,
    ``"link-audit"`` — for whoever reads the far side's log, exactly as
    ``internal_ua()``'s suffix does. It is not part of the contract: only the
    token is. Measured on this fork's resolved package, a caller tag moves
    neither lane nor vendor on any of the three engines
    (``tests/test_internal_traffic.py`` re-measures it rather than asserting
    the claim).
    """
    engine = (engine or "").strip()
    if not engine:
        raise ValueError(
            "probe_ua() needs a vendor-or-engine token: a UA carrying only "
            "the internal suffix classifies crawler-lane and changes which "
            "document the probe is answered with"
        )
    caller = (caller or "").strip()
    ua = f"{engine} {PROBE_UA_SUFFIX}"
    return f"{ua} {caller}" if caller else ua


def internal_ua(caller: str = "") -> str:
    """``INTERNAL_UA`` with a caller suffix, e.g. ``"ad-client"``.

    The suffix is for reading logs on the far side; only the token matters to
    the contract, and it stays intact whatever the suffix says.
    """
    caller = (caller or "").strip()
    return f"{INTERNAL_UA} {caller}" if caller else INTERNAL_UA


# 2plot network links, surfaced in the README and the docs footer/header.
# GITHUB_URL is the REPOSITORY (the top bar's icon and JSON-LD `sameAs`);
# GITHUB_PROFILE_URL below is the owner (the footer's icon) — muischeduler
# shipped the icon pointing at the profile while its `sameAs` named the
# repo, two truths, one of them wrong (item 16, 2026-08-30).
GITHUB_URL = "https://github.com/pip-install-python/dash-flex-layout"
# Network-wide community links (item 16, 2026-08-30 owner decision) —
# identical on every host; this fork previously carried its own vanity
# Discord invite and a personal YouTube channel, neither of which anyone
# maintained. DMC_URL is Resources' first entry.
DISCORD_URL = "https://discord.gg/e5s5uHWUHH"
YOUTUBE_URL = "https://www.youtube.com/@2plotai"
YOUTUBE_SUBSCRIBE_URL = YOUTUBE_URL + "?sub_confirmation=1"
DMC_URL = "https://www.dash-mantine-components.com/"

# The owner's profile — the FOOTER's GitHub link (the repo is the top bar's).
GITHUB_PROFILE_URL = "https://github.com/pip-install-python"

# ---------------------------------------------------------------------------
# Navigation contract (item 16, 2026-08-30) — the parts of the sidebar/top
# bar that are IDENTICAL on every host come from template code
# (components/navbar.py, components/header.py, components/footer.py) and
# these constants; the app's own sections come from each doc's frontmatter
# (`category:` + `order:`). A fork edits THIS block and its docs'
# frontmatter, never the components/ files.
# ---------------------------------------------------------------------------

# The app's own sections, in sidebar order — this fork's six topic pages,
# each its own category (the muischeduler shape the owner named as
# reference: one short category per topic, not one big "Documentation"
# bucket). Categories not listed here follow these, alphabetically.
CATEGORY_ORDER = [
    "Getting Started",
    "Basic Layouts",
    "Borders & Sidebars",
    "Theming",
    "Callbacks",
    "Reference",
]

# The upstream project this component wraps — rendered as the last
# Resources link. FlexLayout-React is the library flexlayout-dash ports;
# linking it is the "for a component built on an upstream project" rule
# from the design brief.
UPSTREAM = {"name": "FlexLayout (React)", "url": "https://github.com/caplin/FlexLayout"}

# The component package /api documents. One package, the one this whole
# site exists to document; the version badge in the header reads its
# installed __version__.
API_PACKAGES = ["flexlayout_dash"]


def resources() -> list:
    """The sidebar's Resources section: THIRD-PARTY ONLY (owner, 2026-08-30).
    `dmc` and the upstream project this component wraps — never the owner's
    own links (repo, Discord, YouTube), which live in the top bar and the
    footer; no community.plotly.com; no 2plot.dev (the network is the Other
    Apps menu, not a sidebar link)."""
    items = [
        {"label": "dmc", "url": DMC_URL, "icon": "ic:baseline-design-services"},
    ]
    if UPSTREAM:
        items.append({"label": UPSTREAM["name"], "url": UPSTREAM["url"],
                      "icon": UPSTREAM.get("icon", "mdi:layers-outline")})
    return items

# Height of the fixed AppShell header, in px. Consumed by AppShell(header=...),
# components/header.py's Group, and the mobile drawer, which docks itself
# directly below the header. Change it here only — a drawer that disagrees
# with the real header height either floats over it or leaves a dead band.
HEADER_HEIGHT = 70

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
