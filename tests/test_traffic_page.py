"""/admin/traffic — the same fail-closed gate as the control board
(pages/control_board.py), and the table-building helpers pure of Dash
callbacks."""

from __future__ import annotations

import importlib
import json
from datetime import date

import pytest


def _traffic_module():
    """Import the traffic page, standing up a bare Dash app if none exists.

    Same trick test_control_board.py uses: ``dash.register_page`` refuses to
    run before app instantiation, and ``pages_folder=""`` keeps the
    throwaway app from importing the whole docs tree.
    """
    import dash

    try:
        return importlib.import_module("pages.traffic")
    except dash.exceptions.PageError:
        dash.Dash(__name__, use_pages=True, pages_folder="")
        return importlib.import_module("pages.traffic")


def test_the_page_fails_closed_without_clerk(monkeypatch):
    traffic = _traffic_module()
    monkeypatch.delenv("ALLOW_UNGATED_ADMIN", raising=False)
    rendered = str(traffic.layout())
    assert "traffic-vendor-day" not in rendered


def test_the_page_opens_locally_with_the_dev_override(monkeypatch):
    traffic = _traffic_module()
    monkeypatch.setenv("ALLOW_UNGATED_ADMIN", "1")
    rendered = str(traffic.layout())
    assert "traffic-vendor-day" in rendered or "No read events" in rendered


def test_the_page_stays_out_of_both_ledgers():
    """Same reasoning as the control board: no lib.page_tiers entry, no
    controllable_pages entry — the gate is the layout() itself."""
    from lib import page_tiers, page_visibility

    _traffic_module()
    assert "/admin/traffic" not in page_tiers.registered()
    assert "/admin/traffic" not in page_visibility.controllable_pages()

    from dash_improve_my_llms import is_hidden

    assert is_hidden("/admin/traffic")


# ---------------------------------------------------------------------------
# Pure table-building helpers — no Dash context needed
# ---------------------------------------------------------------------------


def _read(*, minute=0, vendor_key="gptbot", verified="unverified", path="/basic",
          bytes_=1000, tier="page"):
    ts = __import__("datetime").datetime(2026, 8, 14, 10, minute).timestamp()
    return {
        "ts": ts, "path": path, "tier": tier, "vendor_key": vendor_key,
        "vendor_class": "training", "verified": verified, "policy": None,
        "bytes": bytes_,
    }


def _with_dt(rows):
    from datetime import datetime as _dt
    out = []
    for r in rows:
        r = dict(r)
        r["dt"] = _dt.fromtimestamp(r["ts"])
        out.append(r)
    return out


def test_window_returns_days_in_ascending_order():
    traffic = _traffic_module()
    days = traffic._window(date(2026, 8, 14))
    assert days[-1] == date(2026, 8, 14)
    assert len(days) == traffic.DAYS
    assert days == sorted(days)


def test_vendor_by_day_aggregates_hits_and_bytes():
    traffic = _traffic_module()
    reads = _with_dt([_read(minute=1), _read(minute=2)])
    days = [date(2026, 8, 14)]
    rows, cells, nbytes = traffic.vendor_by_day(reads, days)
    assert rows == [("gptbot", "unverified")]
    assert cells[(("gptbot", "unverified"), date(2026, 8, 14))] == 2
    assert nbytes[("gptbot", "unverified")] == 2000


def test_top_paths_caps_per_vendor():
    traffic = _traffic_module()
    reads = _with_dt([_read(path=f"/p{i}") for i in range(15)])
    out = traffic.top_paths(reads)
    assert len(out) == 1
    _key, _verified, paths = out[0]
    assert len(paths) == traffic.TOP_PATHS


def test_day_view_renders_without_reads():
    traffic = _traffic_module()
    rendered = str(traffic.day_view(date(2026, 8, 14), reads=[]))
    assert "traffic-day-view" in rendered


def test_verified_na_footnote_mentions_claudebot_by_name():
    """The item's requirement: the page states what `verified: n/a` means,
    naming that ClaudeBot is always n/a since Anthropic publishes no
    ranges — otherwise the owner reads a wall of n/a as a defect."""
    traffic = _traffic_module()
    rendered = str(traffic._footnote())
    assert "n/a" in rendered
    assert "Anthropic" in rendered or "ClaudeBot" in rendered


# ------------------------------------------------- enforcement is LABELLED --
#
# 1.6.44 item 3. A read the policy refused is evidence the policy fired; it is
# never folded into the serve count and never rendered as a bare colour.


def _read_row(path, verdict, vendor="gptbot"):
    from datetime import datetime

    return {"dt": datetime.now(), "path": path, "verdict": verdict,
            "vendor_key": vendor, "verified": "unverified", "bytes": 10}


def test_a_denied_read_is_grouped_by_verdict_not_folded_into_the_path():
    mod = _traffic_module()
    rows = [
        _read_row("/hidden/llms.txt", "denied"),
        _read_row("/hidden/llms.txt", "served"),
        _read_row("/hidden/llms.txt", "served"),
    ]
    _key, _verified, paths = mod.top_paths(rows)[0]
    by_verdict = {v: n for _p, v, n in paths}

    assert by_verdict == {"denied": 1, "served": 2}, (
        "the same path under two verdicts collapsed into one row — "
        "enforcement is being reported as traffic"
    )


def test_serve_counts_keeps_the_denied_read_out_of_the_serve_total():
    mod = _traffic_module()
    rows = [_read_row("/a", "served"), _read_row("/b", "denied"),
            _read_row("/c", "blocked"), _read_row("/d", "rate_limited")]
    served, not_served = mod.serve_counts(rows)
    assert (served, not_served) == (1, 3)


def test_the_verdict_cell_carries_the_WORD_not_only_a_colour():
    """Colour alone puts the meaning in a channel some readers never get."""
    mod = _traffic_module()
    for verdict in ("served", "denied", "blocked", "rate_limited",
                    "priced", "gated"):
        badge = mod._verdict_cell(verdict)
        assert verdict in str(badge.children), verdict
        assert getattr(badge, "color", None), f"{verdict} rendered with no tone"


def test_an_unknown_verdict_still_renders_labelled():
    """A verdict the package adds later must not vanish from the board."""
    mod = _traffic_module()
    badge = mod._verdict_cell("quarantined")
    assert "quarantined" in str(badge.children)


def test_the_rendered_table_has_a_verdict_column():
    mod = _traffic_module()
    block = mod.top_paths_block([_read_row("/hidden/llms.txt", "denied")])
    rendered = str(block)
    assert "verdict" in rendered, "the reads table shipped without the column"
    assert "denied" in rendered
