"""The network's internal-traffic contract — the analytics point of truth.

The rule (https://2plot.ai/docs/satellite-analytics, "Internal traffic"): a
request whose User-Agent contains `2plot-internal` is 2plot machinery talking
to itself — the hub's hourly health sweep, CI smoke batteries, the 4x-daily
heartbeat, cross-app calls — and is counted NOWHERE. Dropped at write time,
before device detection and before bot classification. `/healthz` is never a
visit either.

Both halves are tested here, because a contract kept on only one side is not
kept at all:

*inbound*   token-carrying requests never reach the ledger, and therefore
            never reach `human_hits` / `bot_hits` in the hourly rollup this
            app POSTs to 2plot.ai;
*outbound*  every call this host makes to another network host sends
            `INTERNAL_UA`, so the far side can apply the same rule. That half
            was missing here: the ad client fetched a campaign from 2plot.dev
            on every single docs page view, arriving as `python-requests/2.x`,
            and the hub counted this satellite's readers as its own bots.
"""

from __future__ import annotations

import json
import time
from datetime import datetime

import pytest

from conftest import BROWSER_UA, CRAWLER_UA
from lib.analytics_tracker import analytics_path, tracker
from lib.constants import INTERNAL_UA, INTERNAL_UA_TOKEN, internal_ua

# A real page. `lib/traffic_rollup` drops infrastructure paths (`/llms.txt`,
# `/robots.txt`, `/healthz`, ...) at read time, so a rollup assertion made
# against one of those would pass no matter what the tracker did.
PAGE = "/basic"


def _ledger_visits():
    """Every hit on disk, flushing the write buffer first."""
    tracker.flush()
    try:
        with open(analytics_path()) as f:
            return json.load(f).get("visits", [])
    except FileNotFoundError:
        return []


def _rollup():
    """Today's rollup as the hub would receive it, or an all-zero stand-in."""
    from lib.traffic_rollup import daily_rollup

    tracker.flush()
    return daily_rollup("flexlayout", datetime.now().date()) or {
        "human_hits": 0, "bot_hits": 0,
    }


# --------------------------------------------------------------- the token --


def test_token_is_the_network_wide_string():
    """The contract only works if every host agrees on the byte sequence."""
    assert INTERNAL_UA_TOKEN == "2plot-internal"
    assert INTERNAL_UA_TOKEN in INTERNAL_UA
    assert INTERNAL_UA.startswith(INTERNAL_UA_TOKEN)


def test_caller_suffix_never_breaks_the_token():
    ua = internal_ua("traffic-reporter")
    assert INTERNAL_UA_TOKEN in ua
    assert ua.endswith("traffic-reporter")
    assert internal_ua() == INTERNAL_UA
    assert internal_ua("  ") == INTERNAL_UA


# ------------------------------------------------------------------ inbound --


def test_the_tests_can_see_the_ledger_at_all(client, tmp_state_dir):
    """Guard for every delta assertion below.

    If the ledger path were wrong (or the suite were writing into the repo's
    own visitor_analytics.json), every "count did not change" test would pass
    vacuously. Prove a write lands first.
    """
    assert str(analytics_path()).startswith(tmp_state_dir), analytics_path()
    before = len(_ledger_visits())
    client.get(PAGE, user_agent=BROWSER_UA)
    assert len(_ledger_visits()) == before + 1


def test_internal_ua_is_counted_nowhere(client):
    before = len(_ledger_visits())
    client.get(PAGE, user_agent=internal_ua("network-smoke"))
    client.get("/", user_agent=INTERNAL_UA)
    assert len(_ledger_visits()) == before


def test_a_crawler_shaped_probe_carrying_the_token_stays_internal(client):
    """The battery's crawler probe exercises the bot path deliberately.

    It must still not be counted. This is precisely why the drop happens
    before `detect_device_type` — classification would file it under `bot`.
    """
    before = len(_ledger_visits())
    client.get(PAGE, user_agent=f"{CRAWLER_UA} {INTERNAL_UA}")
    assert len(_ledger_visits()) == before


def test_the_token_is_matched_case_insensitively(client):
    before = len(_ledger_visits())
    client.get(PAGE, user_agent="2PLOT-INTERNAL/1.0 Health-Sweep")
    assert len(_ledger_visits()) == before


def test_healthz_is_never_a_visit(client):
    before = len(_ledger_visits())
    client.get("/healthz", user_agent="Render/1.0 health-check")
    client.get("/healthz", user_agent=BROWSER_UA)
    assert len(_ledger_visits()) == before


# ----------------------------------------------- the reported numbers -------
#
# The exclusion that actually matters. Everything above is about the ledger;
# this is about what 2plot.ai charts.


def test_internal_traffic_is_absent_from_human_hits_and_bot_hits(client):
    before = _rollup()

    # Four calls that are all machinery, in the two shapes the network sends:
    # a plain internal UA, and a crawler-shaped probe carrying the token.
    for _ in range(2):
        client.get(PAGE, user_agent=internal_ua("network-smoke"))
        client.get(PAGE, user_agent=f"{CRAWLER_UA} {INTERNAL_UA}")

    after = _rollup()
    assert after["human_hits"] == before["human_hits"], (
        "internal traffic reached human_hits — the hub would chart the health "
        "sweep as readers of these docs"
    )
    assert after["bot_hits"] == before["bot_hits"], (
        "internal traffic reached bot_hits — the hub would chart CI as crawler "
        "interest"
    )


def test_real_traffic_is_still_counted(client):
    """The exclusions must not have lobotomised the tracker.

    A rule that drops everything also satisfies every assertion above, so the
    positive case is load-bearing: one browser hit is one human, one Googlebot
    hit is one bot.
    """
    before = _rollup()
    client.get(PAGE, user_agent=BROWSER_UA)
    client.get(PAGE, user_agent=CRAWLER_UA)
    after = _rollup()

    assert after["human_hits"] == before["human_hits"] + 1
    assert after["bot_hits"] == before["bot_hits"] + 1


# --------------------------------------------------------- the read table --
#
# The other half of "counted nowhere" (SYNC-1.6.43 item 1). Read rows do not
# arrive from a request — dash-improve-my-llms calls `record_read` through its
# `on_document_read` hook — so these probe the tracker in process against a
# tempfile ledger rather than through `client`.
#
# The drop is keyed on the event's `ua`. `EVENT_FIELDS` has `ua` and has never
# had `user_agent`; keying on the wrong name is a silent no-op, which is this
# contract's own failure mode, so the name is pinned below rather than assumed.


@pytest.fixture
def read_tracker(tmp_path):
    from lib.analytics_tracker import AnalyticsTracker

    return AnalyticsTracker(data_file=str(tmp_path / "visitor_analytics.json"))


def _read_event(**overrides):
    """One `on_document_read` event, crawler-lane by default."""
    base = {
        "ts": time.time(),
        "host": "flexlayout.2plot.dev",
        "path": "/basic/llms.txt",
        "method": "GET",
        "tier": "page",
        "lane": "crawler",
        "bot_type": "training",
        "vendor_key": "gptbot",
        "verified": "unverified",
        "policy": None,
        "verdict": "served",
        "status": 200,
        "bytes": 4096,
        "ua": CRAWLER_UA,
        "client_ip": "203.0.113.9",
    }
    base.update(overrides)
    return base


def _read_rows(read_tracker):
    """Read rows on disk, flushing first.

    A tracker that has never flushed anything has no file yet — `flush()`
    returns early when both buffers are empty — so the "before" of every delta
    below is a legitimate zero rather than an error.
    """
    read_tracker.flush()
    try:
        return json.loads(read_tracker.data_file.read_text()).get("reads", [])
    except FileNotFoundError:
        return []


def test_the_event_field_is_ua_across_every_wheel_the_floor_admits():
    """The name the drop keys on, pinned at the source.

    A range, not a pair: this fork's `/healthz` carries no `llms_version`, so
    it cannot compare CI against production. Asserting the field name over the
    floor's whole admissible range is strictly stronger anyway, and needs no
    dashboard.
    """
    from dash_improve_my_llms._ledger import EVENT_FIELDS

    assert "ua" in EVENT_FIELDS
    assert "user_agent" not in EVENT_FIELDS, (
        "a drop keyed on `user_agent` would be a silent no-op"
    )


def test_an_internal_read_is_counted_nowhere(read_tracker):
    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=internal_ua("network-smoke")))
    read_tracker.record_read(_read_event(ua=INTERNAL_UA))
    after = len(_read_rows(read_tracker))
    print(f"internal read probe: reads {before} -> {after}")
    assert after == before


def test_a_crawler_shaped_read_carrying_the_token_stays_internal(read_tracker):
    """The battery's crawler probe, on the read path.

    Same shape as the visit-side test above: the token wins over the lane.
    """
    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=f"{CRAWLER_UA} {INTERNAL_UA}"))
    after = len(_read_rows(read_tracker))
    print(f"tokened crawler read probe: reads {before} -> {after}")
    assert after == before


def test_the_read_token_is_matched_case_insensitively(read_tracker):
    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua="2PLOT-INTERNAL/1.0 Health-Sweep"))
    after = len(_read_rows(read_tracker))
    print(f"upper-case token read probe: reads {before} -> {after}")
    assert after == before


def test_neutralising_the_token_restores_the_row(read_tracker):
    """The mutation line, and the load-bearing half of this file.

    A delta of 0 also happens when the probe never reached the read path at
    all — `record_read` doing nothing is indistinguishable from `record_read`
    dropping correctly. Send the IDENTICAL event with the token neutralised
    and require the row back.
    """
    tokened = f"{CRAWLER_UA} {INTERNAL_UA}"
    neutralised = tokened.replace(INTERNAL_UA_TOKEN, "2plot-external")
    assert INTERNAL_UA_TOKEN not in neutralised.lower()

    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=tokened))
    dropped = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=neutralised))
    kept = len(_read_rows(read_tracker))

    print(
        f"mutation: reads {before} -> {dropped} (tokened) -> {kept} (neutralised)"
    )
    assert dropped == before, "the tokened read was counted"
    assert kept == dropped + 1, (
        "the neutralised read was dropped too — record_read is dropping "
        "everything, or never ran"
    )


def test_a_real_crawler_read_is_still_counted(read_tracker):
    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=CRAWLER_UA))
    after = len(_read_rows(read_tracker))
    print(f"real crawler read probe: reads {before} -> {after}")
    assert after == before + 1


def test_a_ua_less_read_is_kept(read_tracker):
    """An absent UA is the CRAWLER LANE, not machinery.

    `classify()` has filed UA-less requests there since 2.8.0, so this is a
    real fetch by something that declined to identify itself. A defensive
    rewrite that turns the None case into a drop is the regression this pins;
    `event.get("ua", "")` would additionally raise, since the key is present
    and None rather than absent.
    """
    before = len(_read_rows(read_tracker))
    read_tracker.record_read(_read_event(ua=None))
    read_tracker.record_read(_read_event(ua=""))
    after = len(_read_rows(read_tracker))
    print(f"UA-less read probe: reads {before} -> {after}")
    assert after == before + 2


# ----------------------------------------------------------------- outbound --


class _Captured(Exception):
    """Abort the request once the headers have been seen."""


def test_the_traffic_rollup_post_sends_the_token(monkeypatch):
    import requests

    from lib import satellite_reporter

    seen = {}

    def fake(*args, **kwargs):
        seen.update(kwargs.get("headers") or {})
        raise _Captured

    monkeypatch.setattr(requests, "post", fake)
    ok, _detail = satellite_reporter.post_rollup(
        {"app": "flexlayout", "date": "2026-08-01"}, secret="test-secret"
    )
    assert ok is False  # the fake raised; we only wanted the headers
    assert INTERNAL_UA_TOKEN in seen.get("User-Agent", "")


def test_the_ad_fetch_sends_the_token():
    """One call per docs page view — the loudest of the outbound shapes.

    The token rides on the SESSION's headers (set once at import), so the
    assertion is on `_session.headers` rather than a per-call kwarg.
    """
    from lib import ad_client

    assert INTERNAL_UA_TOKEN in ad_client._session.headers.get("User-Agent", "")


@pytest.mark.parametrize("script", ["smoke_live", "network_smoke"])
def test_every_battery_script_sends_the_token(script):
    """A post-deploy battery sweeps every peer; it must not register anywhere."""
    import importlib.util

    from conftest import REPO_ROOT

    spec = importlib.util.spec_from_file_location(
        f"_ua_{script}", REPO_ROOT / "scripts" / f"{script}.py"
    )
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)

    agents = [
        value
        for name, value in vars(module).items()
        if (name == "UA" or name.endswith("_UA")) and isinstance(value, str)
    ]
    assert agents, f"scripts/{script}.py declares no User-Agent constant"
    missing = [ua for ua in agents if INTERNAL_UA_TOKEN not in ua]
    assert missing == [], f"scripts/{script}.py sends untokened UAs: {missing}"
