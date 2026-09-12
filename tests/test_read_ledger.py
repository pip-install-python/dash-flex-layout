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


# ------------------------------- reads are never pruned by count (item 21) --


def _read_rows(n, days_old=0):
    import time as _t

    stamp = _t.time() - days_old * 86400
    return [{"ts": stamp, "path": f"/p{i}", "ua": "GPTBot/1.0", "kind": "read"}
            for i in range(n)]


def test_reads_are_pruned_by_age_but_never_by_count(monkeypatch):
    """20,001 rows inside the window plus one outside: all 20,001 survive
    and the dated one is gone."""
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "MAX_VISITS", 20000)
    monkeypatch.setattr(mod, "RETENTION_DAYS", 45)

    rows = _read_rows(20001) + _read_rows(1, days_old=90)
    kept = mod._prune(rows, stamp=mod._read_stamp, cap=False)

    print(f"reads: {len(rows)} in -> {len(kept)} kept")
    assert len(kept) == 20001, (
        "the count cap reached the read table — a busy crawl day would lose "
        "its oldest evidence inside the retention window"
    )


def test_the_same_corpus_WITH_the_cap_loses_an_in_window_row(monkeypatch):
    """THE RED-FIRST PROOF the item demands.

    Without this, the test above passes on any implementation that keeps
    everything, and says nothing about whether the cap was the thing
    removed. Prune the identical corpus WITH the cap and require the loss.
    """
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "MAX_VISITS", 20000)
    monkeypatch.setattr(mod, "RETENTION_DAYS", 45)

    rows = _read_rows(20001) + _read_rows(1, days_old=90)
    capped = mod._prune(rows, stamp=mod._read_stamp, cap=True)

    print(f"reads WITH the cap (the pre-item behaviour): {len(capped)} kept")
    assert len(capped) == 20000, (
        "the cap did not bite even when asked for — this test can no longer "
        "prove the uncapped result means anything"
    )
    assert len(capped) < 20001


def test_visits_KEEP_the_count_cap(monkeypatch):
    """The mirror. Item 21 removes the cap from reads, not from visits."""
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "MAX_VISITS", 100)
    monkeypatch.setattr(mod, "RETENTION_DAYS", 45)

    visits = [{"timestamp": __import__("datetime").datetime.now().isoformat(),
               "path": f"/p{i}"} for i in range(150)]
    kept = mod._prune(visits)
    assert len(kept) == 100, "visits lost their size guard"


def test_the_rule_per_table_is_SOURCE_pinned():
    """The choice lives AT THE CALL SITE, so pin the call site by AST.

    A behavioural test cannot see a `cap=True` restored above it: the write
    path would cap reads again and every assertion above still passes,
    because they call `_prune` directly.
    """
    import ast

    from conftest import REPO_ROOT

    tree = ast.parse((REPO_ROOT / "lib" / "analytics_tracker.py").read_text())
    calls = [n for n in ast.walk(tree)
             if isinstance(n, ast.Call)
             and isinstance(n.func, ast.Name) and n.func.id == "_prune"]
    assert len(calls) == 2, f"expected two _prune call sites, found {len(calls)}"

    by_cap = {}
    for call in calls:
        kwargs = {k.arg: k.value for k in call.keywords}
        cap = kwargs.get("cap")
        stamp = kwargs.get("stamp")
        is_reads = isinstance(stamp, ast.Name) and stamp.id == "_read_stamp"
        by_cap["reads" if is_reads else "visits"] = cap

    assert "reads" in by_cap and "visits" in by_cap, by_cap
    reads_cap = by_cap["reads"]
    assert isinstance(reads_cap, ast.Constant) and reads_cap.value is False, (
        "the reads call site no longer passes cap=False — the count cap is "
        "back on the read table"
    )
    assert by_cap["visits"] is None, (
        "the visits call site now passes `cap` explicitly; if that is "
        "deliberate, update this pin — the default is what keeps the guard"
    )
