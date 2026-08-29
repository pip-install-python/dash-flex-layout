"""The ledger's second table — one row per corpus document served.

``AnalyticsTracker.record_read`` is what ``run.py`` registers with
dash-improve-my-llms' ``on_document_read`` hook (>= 2.8.0). It must land in
the SAME ledger file's ``reads`` list — never mixed into ``visits`` — with
the same buffer/lock/flush discipline, and it must drop ``client_ip`` unless
the operator opts in.
"""

from __future__ import annotations

import json
import time

import pytest

from lib.analytics_tracker import AnalyticsTracker
from lib.traffic_rollup import load_reads


@pytest.fixture
def tracker(tmp_path):
    return AnalyticsTracker(data_file=str(tmp_path / "visitor_analytics.json"))


def _event(**overrides):
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
        "ua": "GPTBot/1.0",
        "client_ip": "203.0.113.9",
    }
    base.update(overrides)
    return base


def test_a_read_event_lands_in_reads_not_visits(tracker):
    tracker.record_read(_event())
    tracker.flush()
    data = json.loads(tracker.data_file.read_text())
    assert data["reads"], "record_read did not write to the reads table"
    assert data["visits"] == [], "a read event leaked into visits"


def test_client_ip_is_dropped_by_default(tracker):
    tracker.record_read(_event())
    tracker.flush()
    data = json.loads(tracker.data_file.read_text())
    assert "client_ip" not in data["reads"][0]


def test_client_ip_is_kept_when_opted_in(tracker, monkeypatch):
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "KEEP_CLIENT_IP", True)
    tracker.record_read(_event())
    tracker.flush()
    data = json.loads(tracker.data_file.read_text())
    assert data["reads"][0]["client_ip"] == "203.0.113.9"


def test_every_event_field_survives_the_round_trip(tracker):
    from dash_improve_my_llms._ledger import EVENT_FIELDS

    tracker.record_read(_event())
    tracker.flush()
    data = json.loads(tracker.data_file.read_text())
    row = data["reads"][0]
    for key in EVENT_FIELDS:
        if key == "client_ip":
            continue
        assert key in row, f"{key} missing from a stored read row"


def test_a_non_dict_event_is_ignored_not_raised(tracker):
    tracker.record_read("not a dict")
    tracker.record_read(None)
    tracker.flush()
    assert load_reads(str(tracker.data_file)) == []


def test_a_ledger_with_no_reads_key_reads_as_empty(tmp_path):
    p = tmp_path / "visitor_analytics.json"
    p.write_text(json.dumps({"visits": []}))
    assert load_reads(str(p)) == []


def test_load_reads_parses_ts_into_a_local_dt(tracker):
    tracker.record_read(_event())
    tracker.flush()
    rows = load_reads(str(tracker.data_file))
    assert len(rows) == 1
    assert rows[0]["dt"].year >= 2025


def test_visits_and_reads_share_the_same_buffer_discipline(tracker, monkeypatch):
    """Both tables flush together under the same FLUSH_EVERY count — a read
    event must not sit unflushed forever just because visits stayed quiet."""
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "FLUSH_EVERY", 1)
    tracker.record_read(_event())
    data = json.loads(tracker.data_file.read_text())
    assert data["reads"], "a read event did not trigger a flush at FLUSH_EVERY=1"
