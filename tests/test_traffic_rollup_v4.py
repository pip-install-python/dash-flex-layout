"""Rollup v4 — the vendor dimension folded additively from the ledger's
``reads`` table (dash-improve-my-llms >= 2.8.0's ``on_document_read``).

The rule under test: ``vendors``/``reads`` appear ONLY on a day with read
events, every v3 key stays exactly as before (this file must never touch
tests/test_traffic_rollup.py's assertions), and the null vendor key — the
unidentified crawler lane — is kept, not dropped.
"""

from __future__ import annotations

import json
from datetime import date

from lib.traffic_rollup import daily_rollup, load_reads, vendor_rows

DAY = date(2026, 8, 14)


def _read(*, minute=0, vendor_key="gptbot", vendor_class="training",
          verified="unverified", policy=None, tier="page", bytes_=1000):
    return {
        "ts": __import__("datetime").datetime(2026, 8, 14, 10, minute).timestamp(),
        "host": "flexlayout.2plot.dev",
        "path": "/basic",
        "method": "GET",
        "tier": tier,
        "lane": "crawler",
        "bot_type": "training",
        "vendor_key": vendor_key,
        "vendor_class": vendor_class,
        "verified": verified,
        "policy": policy,
        "verdict": "served",
        "status": 200,
        "bytes": bytes_,
        "ua": "GPTBot/1.0",
    }


def _ledger(tmp_path, visits=(), reads=()):
    p = tmp_path / "visitor_analytics.json"
    p.write_text(json.dumps({"visits": list(visits), "reads": list(reads)}))
    return str(p)


def _visit(path, *, minute=0, ip="1.1.1.1", ua="Mozilla/5.0 Chrome",
           device_type="desktop"):
    return {
        "timestamp": f"2026-08-14T10:{minute:02d}:00",
        "path": path,
        "ip_address": ip,
        "user_agent": ua,
        "device_type": device_type,
    }


def test_a_day_with_only_visits_gets_no_vendors_or_reads_key(tmp_path):
    ledger = _ledger(tmp_path, visits=[_visit("/basic")])
    from lib.traffic_rollup import load_visits

    payload = daily_rollup("flexlayout", DAY,
                           visits=load_visits(ledger),
                           agent_visits=[], reads=[])
    assert payload is not None
    assert "vendors" not in payload
    assert "reads" not in payload


def test_a_day_with_reads_gains_vendors_and_reads(tmp_path):
    ledger = _ledger(tmp_path, reads=[_read(minute=1), _read(minute=2)])
    reads = load_reads(ledger)
    payload = daily_rollup("flexlayout", DAY, visits=[], agent_visits=[], reads=reads)
    assert payload is not None
    assert payload["reads"] == 2
    assert len(payload["vendors"]) == 1
    row = payload["vendors"][0]
    assert row["key"] == "gptbot"
    assert row["class"] == "training"
    assert row["verified"] == "unverified"
    assert row["policy"] == "default"
    assert row["hits"] == 2
    assert row["bytes"] == 2000
    assert row["tiers"]["page"] == 2


def test_a_reads_only_day_is_reported_like_a_machine_only_day(tmp_path):
    """Zero visits, zero agent hits, but reads exist — must still report,
    per the same rule test_traffic_rollup.py pins for machine-only days."""
    ledger = _ledger(tmp_path, reads=[_read()])
    reads = load_reads(ledger)
    payload = daily_rollup("flexlayout", DAY, visits=[], agent_visits=[], reads=reads)
    assert payload is not None
    assert payload["human_hits"] == 0
    assert payload["bot_hits"] == 0
    assert payload["reads"] == 1


def test_the_null_vendor_key_is_kept_not_dropped(tmp_path):
    ledger = _ledger(tmp_path, reads=[
        _read(vendor_key=None, vendor_class=None, verified="n/a"),
    ])
    reads = load_reads(ledger)
    rows = vendor_rows(reads)
    assert len(rows) == 1
    assert rows[0]["key"] is None
    assert rows[0]["class"] is None


def test_vendor_rows_partition_by_key_verified_and_policy(tmp_path):
    ledger = _ledger(tmp_path, reads=[
        _read(vendor_key="gptbot", verified="verified", policy="allow"),
        _read(vendor_key="gptbot", verified="unverified", policy="allow"),
        _read(vendor_key="gptbot", verified="verified", policy="deny"),
    ])
    rows = vendor_rows(load_reads(ledger))
    assert len(rows) == 3


def test_a_missing_policy_groups_as_default():
    """2.8.1 will write a resolved policy; until then every event's policy
    is None and the rollup must group it as "default", never crash or split
    silently on None vs "default"."""
    rows = vendor_rows([dict(_read(policy=None), dt=None)])
    assert rows[0]["policy"] == "default"


def test_vendors_are_sorted_by_hits_desc_and_capped(tmp_path):
    reads = []
    for n, key in enumerate(["a", "b", "c"]):
        for _ in range(3 - n):  # a:3, b:2, c:1
            reads.append(_read(vendor_key=key))
    ledger = _ledger(tmp_path, reads=reads)
    rows = vendor_rows(load_reads(ledger))
    assert [r["key"] for r in rows] == ["a", "b", "c"]


def test_every_v3_key_is_present_and_unaffected_by_reads(tmp_path):
    """The item's own requirement: v3 keys byte-identical whether or not the
    day also carries reads."""
    ledger = _ledger(tmp_path, visits=[_visit("/basic")], reads=[_read()])
    from lib.traffic_rollup import load_visits

    payload = daily_rollup("flexlayout", DAY,
                           visits=load_visits(ledger),
                           agent_visits=[], reads=load_reads(ledger))
    for key in ("app", "date", "human_hits", "bot_hits", "visitors",
                "sessions", "bot_visitors", "pages", "countries"):
        assert key in payload
    assert payload["human_hits"] == 1
