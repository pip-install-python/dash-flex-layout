"""
Visitor Analytics Tracker
Tracks visitor information including device type, bot detection, and geolocation.

This ledger is the raw material for two things:

1. the app's own record of who read the docs, and
2. the hourly rollup this app POSTs to 2plot.ai (``lib/satellite_reporter``),
   which is what the network ``/traffic`` dashboard charts.

Because the hub compares apps side by side, the fields written here match the
hub's own ledger exactly: ``{timestamp, path, device_type, user_agent,
bot_type?, ip_address?, location?}``. Crawler rows (``device_type == "bot"``)
additionally carry ``{vendor_key, vendor_class, verified, lane}`` since the
2.8.0 floor; human rows are unchanged.

Since the 2.8.0 floor the same file also holds a SECOND table, ``reads``: one
row per corpus document dash-improve-my-llms served, handed to
:meth:`record_read` through the package's ``on_document_read`` hook.
``visits`` is what the request hook saw; ``reads`` is what the package says
it served (tier, verdict, bytes, verified vendor). They are joined by
``lib/traffic_rollup.py`` and never summed into each other.

THERE IS ONE CLASSIFIER — ``dash_improve_my_llms.classify()``. This module
used to carry its own User-Agent lists: they filed ClaudeBot (Anthropic's
*training* crawler) under "search", still named the retired ``anthropic-ai``
/ ``claude-web`` tokens, knew nothing of newer vendors, and counted every
UA-less or library client (``httpx``, ``Go-http-client``) as a person. Every
host in the network reported those numbers. The lists are gone —
``is_bot`` / ``detect_bot_type`` keep their names (this fork's own tests call
them directly) and delegate to the package's registry. A token the registry
lacks and that matters for this fork's accounting is a pushback to the
package seat, never a list kept here.

Accuracy notes (these are the things that quietly wreck the numbers):

- **Client IP** comes from the proxy headers first (``CF-Connecting-IP``,
  ``X-Forwarded-For``, ...). Behind Cloudflare/Render, ``remote_addr`` is the
  *proxy*, so every visitor would collapse into one and geolocation would point
  at a datacenter.
- **Country** prefers Cloudflare's ``CF-IPCountry`` header — free, accurate and
  instant. The ip-api.com lookup is only a fallback (set
  ``ANALYTICS_GEO_LOOKUP=0`` to disable it entirely).
- **Writes are buffered, locked and pruned.** Multiple gunicorn/uvicorn workers
  share this file; without an ``flock`` around the read-modify-write they
  silently overwrite each other's hits. The buffer keeps a docs site from
  rewriting the whole file on every request, and retention keeps it bounded.
"""
import atexit
import json
import os
import threading
import hashlib
import hmac
import secrets
import time
from pathlib import Path
from datetime import datetime, timedelta
from functools import lru_cache


from dash_improve_my_llms import classify
from dash_improve_my_llms._ledger import EVENT_FIELDS

try:  # POSIX only — Windows dev boxes just run without the cross-process lock
    import fcntl
except ImportError:  # pragma: no cover
    fcntl = None


_REPO_ROOT = Path(__file__).resolve().parent.parent

# How many hits to hold in memory before touching disk, and the longest a hit
# may sit in the buffer. Both are tiny; the point is to turn "rewrite the file
# on every request" into "rewrite it a few times a minute".
FLUSH_EVERY = int(os.getenv("ANALYTICS_FLUSH_EVERY", "10"))
FLUSH_INTERVAL_S = float(os.getenv("ANALYTICS_FLUSH_INTERVAL_S", "30"))

# Retention. The hub keeps the durable history (every rollup we POST rides its
# heartbeat store), so this file only needs enough runway to build a rollup and
# show recent local history.
RETENTION_DAYS = int(os.getenv("ANALYTICS_RETENTION_DAYS", "45"))
MAX_VISITS = int(os.getenv("ANALYTICS_MAX_VISITS", "20000"))

# The read event carries the client address; it is dropped from the stored
# row unless the operator opts in. Off by default for the same reason the
# rest of this module prefers not to keep addresses it doesn't need.
KEEP_CLIENT_IP = os.getenv("ANALYTICS_KEEP_CLIENT_IP", "0") == "1"

# The keys a crawler row gains from classify(); a human row never carries
# them, so the v3 rollup sees human rows byte-for-byte as before.
_VENDOR_KEYS = ("vendor_key", "vendor_class", "verified", "lane")

_IP_HEADERS = (
    "cf-connecting-ip",     # Cloudflare
    "true-client-ip",       # Cloudflare Enterprise / Akamai
    "x-real-ip",            # nginx
    "x-forwarded-for",      # everything else (first hop = the client)
)

_PRIVATE_PREFIXES = ('10.', '172.', '192.168.', 'fe80:', 'fc00:', 'fd00:')


def analytics_path() -> Path:
    """Resolve the ledger path (env override, else repo root).

    Absolute on purpose: the old relative default wrote a *different* file
    depending on the process working directory, which split the numbers.
    """
    return Path(os.getenv("TRAFFIC_ANALYTICS_FILE")
                or _REPO_ROOT / "visitor_analytics.json")


def _lower_headers(headers) -> dict:
    """Normalise any header mapping (Flask, Starlette, dict) to lowercase."""
    if not headers:
        return {}
    try:
        return {str(k).lower(): v for k, v in headers.items()}
    except Exception:
        return {}


def client_ip(headers=None, fallback=None):
    """The real client address, reading proxy headers before ``remote_addr``."""
    lc = _lower_headers(headers)
    for name in _IP_HEADERS:
        raw = lc.get(name)
        if not raw:
            continue
        # X-Forwarded-For is "client, proxy1, proxy2" — the client is first.
        ip = str(raw).split(",")[0].strip()
        if ip:
            return ip
    return fallback


def header_country(headers=None):
    """ISO country code from Cloudflare's ``CF-IPCountry``, if present.

    ``XX`` (unknown) and ``T1`` (Tor) are not countries — treated as absent.
    """
    cc = (_lower_headers(headers).get("cf-ipcountry") or "").strip().upper()
    return cc if cc and cc not in ("XX", "T1") else None


# THE ip-api.com LOOKUP LIVED HERE UNTIL 1.6.44 ITEM 16, and its removal is
# the item. Every visitor's IP address was sent to a third party on a cache
# miss — a US company, over plain HTTP, with no agreement and nothing in the
# privacy prose saying so — to learn a country the edge was already telling
# us for free in `CF-IPCountry`. The lookup is gone, `requests` with it, and
# with them the whole class: this module now makes NO outbound call of any
# kind, so there is no code path by which reading these docs can tell anyone
# else that you did.
#
# What replaces it is strictly less: the location headers the edge already
# attaches, and nothing derived from the address itself.

LOCATION_HEADERS = (
    ("cf-ipcountry", "country_code"),
    ("cf-ipcity", "city"),
    ("cf-region", "region"),
    ("cf-region-code", "region_code"),
)

_geo_headers_seen: set = set()
_geo_headers_logged = False


def _location_from_headers(headers) -> dict:
    """``{country, country_code, city, region}`` from the EDGE's own headers.

    Only what the proxy volunteers about the request. No lookup, no address,
    no third party. An absent header is an absent field — never a guess, and
    never a default country, because a wrong country in a ledger is worse
    than no country at all.
    """
    global _geo_headers_logged

    lc = _lower_headers(headers)
    out: dict = {}
    for header, field in LOCATION_HEADERS:
        raw = lc.get(header)
        if raw is None:
            continue
        value = str(raw).strip()
        if not value:
            continue
        _geo_headers_seen.add(header)
        if field == "country_code":
            value = value.upper()
            if value in ("XX", "T1"):    # unknown, Tor — not countries
                continue
            out["country"] = value
        out[field] = value

    if out and not _geo_headers_logged:
        _geo_headers_logged = True
        print(f"[analytics] visitor-location headers seen: "
              f"{', '.join(sorted(_geo_headers_seen))}", flush=True)
    return out


def geo_headers_seen() -> list:
    """The visitor-location headers this process has received, sorted.

    Read by ``/healthz``'s geo block so "is the edge attaching them on this
    zone?" is answerable without reading a boot log.
    """
    return sorted(_geo_headers_seen)


def _visitor_salt() -> bytes:
    """The key for ``visitor_key``'s one-way hash.

    ``ANALYTICS_VISITOR_SALT`` when set. Otherwise a random salt generated
    once and kept beside the ledger — so it survives restarts exactly where
    the ledger does. On an ephemeral container filesystem it rotates on every
    deploy, and that is a property rather than a bug: the hashes stop being
    linkable across deploys, and a host that wanted them linkable was told to
    mount a disk.
    """
    env = os.getenv("ANALYTICS_VISITOR_SALT")
    if env:
        return env.encode()
    path = analytics_path().parent / ".visitor_salt"
    try:
        if path.exists():
            return path.read_bytes()
        salt = secrets.token_bytes(32)
        path.write_bytes(salt)
        return salt
    except Exception:
        # Unwritable directory: fall back to a process-lifetime salt rather
        # than to no salt. An unsalted hash of an IP is an IP.
        global _fallback_salt
        if _fallback_salt is None:
            _fallback_salt = secrets.token_bytes(32)
        return _fallback_salt


_fallback_salt = None


def visitor_key(ip_address, user_agent) -> str:
    """A keyed one-way hash identifying a visitor without storing them.

    HMAC, not a bare digest: the IPv4 space is small enough to enumerate, so
    an unkeyed hash of an address is a reversible encoding of the address.
    Truncated to 16 hex characters — enough to separate visitors within a
    day's ledger, not enough to be a durable identifier.
    """
    material = f"{ip_address or '?'}|{user_agent or '?'}".encode()
    return hmac.new(_visitor_salt(), material, hashlib.sha256).hexdigest()[:16]


class AnalyticsTracker:
    """Track visitor analytics to JSON file."""

    def __init__(self, data_file=None):
        self._data_file = Path(data_file) if data_file else None
        self._buffer = []
        self._reads_buffer = []
        self._buffer_lock = threading.Lock()
        self._last_flush = time.time()
        atexit.register(self.flush)

    @property
    def data_file(self) -> Path:
        return self._data_file or analytics_path()

    def _ensure_file_exists(self):
        """Create analytics file if it doesn't exist."""
        if not self.data_file.exists():
            self.data_file.parent.mkdir(parents=True, exist_ok=True)
            self.data_file.write_text(json.dumps({
                "visits": [],
                "reads": [],
                "stats": {
                    "desktop": 0,
                    "mobile": 0,
                    "tablet": 0,
                    "bot": 0,
                    "total": 0
                }
            }, indent=2))

    def detect_device_type(self, user_agent, classification=None):
        """Detect device type from user agent string.

        ``classification`` is an already-computed ``classify()`` result so a
        caller that needs the vendor keys too classifies exactly once.
        """
        # Bots first — including the EMPTY User-Agent, which the package puts
        # on the crawler lane (no browser sends none) and this method used to
        # file as a desktop human.
        c = classification if classification is not None else _classify(user_agent)
        if c["lane"] == "crawler":
            return "bot"

        user_agent = (user_agent or "").lower()

        # Check for tablet before mobile — iPads and most Android tablets also
        # carry a mobile token, so the mobile test would swallow them.
        if any(tablet in user_agent for tablet in ['ipad', 'tablet', 'kindle', 'silk']):
            return "tablet"

        if any(mobile in user_agent for mobile in ['mobile', 'android', 'iphone', 'ipod', 'blackberry', 'windows phone']):
            return "mobile"

        return "desktop"

    def is_bot(self, user_agent, client_ip=None):
        """Is this request on the crawler lane? Delegates to the package.

        Kept by name and signature for this fork's own tests — the body is
        the one classifier now. Contract change from the lists this
        replaced: an absent UA is a bot now, not a desktop visitor.
        """
        return _classify(user_agent, client_ip)["lane"] == "crawler"

    def detect_bot_type(self, user_agent, client_ip=None):
        """``training`` / ``search`` / ``traditional`` / ``unknown``, per the
        package's vendor registry — the same buckets robots.txt is rendered
        from, so what the site SAYS about a vendor and what it COUNTS agree."""
        return _classify(user_agent, client_ip)["bot_type"] or "unknown"

    def track_visit(self, path, user_agent, ip_address=None, headers=None):
        """Track a visitor.

        ``headers`` is optional but strongly recommended — it's what makes the
        client IP and country correct behind a proxy. See ``client_ip``.
        """
        # --- The network's internal-traffic contract, applied at WRITE time --
        #
        # https://2plot.ai/docs/satellite-analytics, "Internal traffic": a
        # request carrying INTERNAL_UA_TOKEN is 2plot machinery talking to
        # itself and is counted nowhere. This has to happen HERE, before
        # `detect_device_type`, and not in lib/traffic_rollup's read-time
        # filter, for two reasons:
        #
        #   1. classification would run first, and the health sweep and smoke
        #      batteries look like bots — they would land in `bot_hits` and be
        #      reported to the hub as crawler interest in these docs;
        #   2. the ledger is what a person reads on a local analytics view. A
        #      row that exists but is filtered on the way out is still a row
        #      somebody has to know to discount.
        #
        # The token is matched case-insensitively so a caller may capitalise
        # its suffix however it likes. /healthz is dropped here too — the
        # hub's hourly sweep is machinery whatever UA it sends.
        from lib.constants import INTERNAL_UA_TOKEN

        if INTERNAL_UA_TOKEN in (user_agent or "").lower():
            return
        if path == "/healthz":
            return

        # Skip internal Dash paths and static assets
        skip_paths = [
            '.css', '.js', '.png', '.jpg', '.ico', '.svg', '.woff', '.woff2', '.ttf', '.eot',
            '_dash', '_reload-hash', 'favicon', '/_dash-update-component',
            '/_dash-layout', '/_dash-dependencies', '/_dash-component-suites',
            '/assets/', '[]'  # Also skip malformed paths
        ]
        if any(skip in path for skip in skip_paths):
            return

        # Only track valid paths that start with /
        if not path or not path.startswith('/') or path.startswith('//'):
            return

        # Resolve the REAL address first: `verified` is computed against the
        # client, and behind Cloudflare/Render `ip_address` is the proxy.
        ip_address = client_ip(headers, ip_address)

        # Classify exactly once per request — lane, bucket and vendor come
        # from the same call, so a row can never disagree with itself.
        c = _classify(user_agent, ip_address)
        device_type = self.detect_device_type(user_agent, classification=c)

        visit_data = {
            "timestamp": datetime.now().isoformat(),
            "path": path,
            "device_type": device_type,
            "user_agent": user_agent or "Unknown",
        }

        # Crawler rows carry the vendor identity; human rows are unchanged
        # byte-for-byte (the v3 rollup's tests pin that shape).
        if device_type == "bot":
            visit_data["bot_type"] = c["bot_type"] or "unknown"
            for key in _VENDOR_KEYS:
                visit_data[key] = c.get(key)

        # THE ADDRESS IS NOT STORED (1.6.44 item 16). It is resolved above
        # because `verified` is computed against the real client, then used
        # for one more thing and discarded: `visitor_key` is a salted one-way
        # hash, which separates visitors in a day's ledger without keeping
        # anyone's address on disk. Nothing downstream can recover the input.
        visit_data["visitor_key"] = visitor_key(ip_address, user_agent)

        # Location comes from the edge's own headers and from nowhere else.
        # An absent header is an absent field: no lookup, no default country,
        # no third party. A visit with no location headers carries no
        # location at all, which is the honest row.
        location = _location_from_headers(headers)
        if location:
            visit_data["location"] = location

        self._enqueue(self._buffer, visit_data)

    def record_read(self, event):
        """Keep one read event from dash-improve-my-llms' ``on_document_read``.

        Registered once in ``run.py``. The package hands over every key in
        ``_ledger.EVENT_FIELDS`` for each corpus document it served — tier,
        lane, vendor, verified, policy, verdict, status, bytes — and does no
        I/O of its own. This is where the row is kept: the ``reads`` table of
        the same ledger, same buffer discipline, same lock, same retention.

        Called synchronously on the request path by the package, which also
        catches anything raised here (fail-open, warned once). Keep it cheap:
        it appends; the flush does the disk work.

        ``client_ip`` is dropped unless ``ANALYTICS_KEEP_CLIENT_IP=1``.

        Internal traffic is dropped here too — see the long note in
        :meth:`track_visit`. "Counted nowhere" includes the READ table; a
        contract kept on only the ``visits`` side is half a contract, and the
        half that was missing is why the network's own probes (the hub's
        health sweep, every satellite's link audit, every post-deploy
        battery) were the busiest reader of these docs.
        """
        if not isinstance(event, dict):
            return

        # Keyed on ``ua`` — the name ``EVENT_FIELDS`` uses. ``user_agent`` is
        # track_visit's PARAMETER name and does not exist in this event, so a
        # drop keyed on it would be a silent no-op: the exact failure mode this
        # check exists to prevent. Matched before the row is built, for
        # track_visit's reason 2 — a row filtered on the way out is still a
        # row somebody has to know to discount.
        #
        # A ``ua: None`` read is KEPT, deliberately. ``classify()`` has filed
        # UA-less requests in the crawler lane since 2.8.0, so an absent UA is
        # a real fetch by something that declined to identify itself, not
        # machinery. ``(… or "")`` is load-bearing: ``event.get("ua", "")``
        # returns None when the key is present-and-None and raises on
        # ``.lower()``.
        from lib.constants import INTERNAL_UA_TOKEN

        if INTERNAL_UA_TOKEN in (event.get("ua") or "").lower():
            return

        row = {k: event.get(k) for k in EVENT_FIELDS}
        if not KEEP_CLIENT_IP:
            row.pop("client_ip", None)
        row["kind"] = "read"
        self._enqueue(self._reads_buffer, row)

    def _enqueue(self, buffer, row):
        with self._buffer_lock:
            buffer.append(row)
            pending = len(self._buffer) + len(self._reads_buffer)
            due = (pending >= FLUSH_EVERY
                   or (time.time() - self._last_flush) >= FLUSH_INTERVAL_S)
        if due:
            self.flush()

    # ------------------------------------------------------------------ disk --

    def flush(self):
        """Write buffered hits to disk under a cross-process lock.

        Safe to call at any time (the satellite reporter calls it before
        building a rollup so the numbers include the current minute).
        """
        with self._buffer_lock:
            pending, self._buffer = self._buffer, []
            reads, self._reads_buffer = self._reads_buffer, []
            self._last_flush = time.time()
        if not pending and not reads:
            return
        try:
            self._write(pending, reads)
        except Exception:
            # Never lose the app over analytics; put the hits back so the next
            # flush can retry them.
            with self._buffer_lock:
                self._buffer = pending + self._buffer
                self._reads_buffer = reads + self._reads_buffer

    def _write(self, pending, reads=()):
        self._ensure_file_exists()
        path = self.data_file
        lock_path = path.with_suffix(path.suffix + ".lock")
        lock_fh = open(lock_path, "a+") if fcntl else None
        try:
            if lock_fh:
                fcntl.flock(lock_fh, fcntl.LOCK_EX)
            try:
                with open(path, 'r') as f:
                    data = json.load(f)
                if not isinstance(data, dict):
                    raise ValueError("ledger is not an object")
            except Exception:
                data = {"visits": [], "reads": [],
                        "stats": {"desktop": 0, "mobile": 0,
                                  "tablet": 0, "bot": 0, "total": 0}}

            visits = data.setdefault("visits", [])
            # A ledger written before the reads table existed has no
            # `reads` key at all; absence reads as empty.
            read_rows = data.setdefault("reads", [])
            stats = data.setdefault("stats", {})
            visits.extend(dict(v) for v in pending)
            for v in pending:
                dt = v["device_type"]
                stats[dt] = stats.get(dt, 0) + 1
                stats["total"] = stats.get("total", 0) + 1

            data["visits"] = _prune(visits)
            read_rows.extend(reads)
            # cap=False: reads are pruned by AGE only (item 21).
            data["reads"] = _prune(read_rows, stamp=_read_stamp, cap=False)

            # Atomic replace: a crash mid-write can't leave a truncated ledger.
            tmp = path.with_suffix(path.suffix + ".tmp")
            with open(tmp, 'w') as f:
                json.dump(data, f, indent=2)
            os.replace(tmp, path)
        finally:
            if lock_fh:
                try:
                    fcntl.flock(lock_fh, fcntl.LOCK_UN)
                finally:
                    lock_fh.close()


def _visit_stamp(v):
    return v.get("timestamp") or ""


def _read_stamp(r):
    """Read rows carry the package's epoch ``ts``; compare on the same ISO
    axis the visit rows use so one retention rule covers both tables."""
    ts = r.get("ts")
    try:
        return datetime.fromtimestamp(float(ts)).isoformat()
    except (TypeError, ValueError, OverflowError, OSError):
        return ""


def _prune(rows, stamp=_visit_stamp, cap=True):
    """Drop rows older than the retention window, then optionally cap.

    ``cap`` is the whole of 1.6.44 item 21. The retention window applies to
    both tables; the COUNT cap applies to ``visits`` only.

    Why the tables differ: a visit row is one page view and the cap is a
    size guard on a file that grows with traffic. A READ row is one corpus
    document served to one agent, and the read table is the evidence for
    "which vendors actually fetched these docs" — a busy crawl day can put
    thousands of rows in it legitimately, and capping by count silently
    discards the OLDEST rows inside the retention window, which is exactly
    the evidence somebody went looking for. Losing them is not a smaller
    version of the answer, it is a different answer.

    The choice of rule per table lives AT THE CALL SITE, which is why
    tests/test_read_ledger.py source-pins it by AST: a behavioural test
    cannot see a `cap=True` restored above it.
    """
    if RETENTION_DAYS > 0:
        cutoff = (datetime.now() - timedelta(days=RETENTION_DAYS)).isoformat()
        rows = [v for v in rows if stamp(v) >= cutoff]
    if cap and MAX_VISITS > 0 and len(rows) > MAX_VISITS:
        rows = rows[-MAX_VISITS:]
    return rows


def _vendor_class_from_registry(vendor_key):
    """The package's own registry answer for ``vendor_key``, or None.

    Not a second opinion and not a local table — ``get_vendor()`` reads the
    same registry ``classify()`` does. It exists only for the version window
    where the event carries a vendor and no class, which is exactly the
    window THIS fork is in: ``vendor_class`` arrives on the classification at
    dimll 2.9.2 and the floor here is `>=2.8.0`.
    """
    if not vendor_key:
        return None
    try:
        from dash_improve_my_llms.vendors import get_vendor

        vendor = get_vendor(vendor_key)
        return getattr(vendor, "cls", None) if vendor else None
    except Exception:
        return None


def _classify(user_agent, client_ip=None):
    """The one classifier, made total: never raises, always has ``lane``.

    PREFER, THEN DERIVE (1.6.44 item 8). dash-improve-my-llms 2.9.x puts
    ``vendor_class`` on the classification itself. A fork that computes the
    class unconditionally OVERWRITES the package's answer with its own, and
    the two disagree the moment the registry learns a vendor the fork's table
    does not have — which is the whole reason there is one classifier. So the
    package's value is taken whenever it is present, and the registry is
    consulted only where it is absent (a floor below 2.9, or a vendor the
    classifier matched without a class). Never a hand-written map.
    """
    try:
        c = classify(user_agent or "", client_ip)
    except Exception:
        c = {}
    vendor_key = c.get("vendor_key")
    vendor_class = c.get("vendor_class")
    if vendor_class is None:
        vendor_class = _vendor_class_from_registry(vendor_key)
    return {
        "lane": c.get("lane") or "browser",
        "bot_type": c.get("bot_type"),
        "vendor_key": vendor_key,
        "vendor_class": vendor_class,
        "verified": c.get("verified") or "n/a",
    }


# Global tracker instance
tracker = AnalyticsTracker()
