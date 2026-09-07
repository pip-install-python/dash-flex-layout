"""The tracker keeps no addresses and calls nobody — 1.6.44 item 16.

Until this item, every visitor's IP address was sent to ip-api.com on a
cache miss: a third party, over plain HTTP, with no agreement and nothing in
the site's prose saying so, to learn a country that `CF-IPCountry` was
already supplying for free. The lookup is gone and `requests` with it.

Two properties are asserted here rather than described:

* the module makes NO outbound call of any kind, so there is no code path by
  which reading these docs tells anyone else that you did;
* the ledger stores no address — only `visitor_key`, a salted one-way hash
  that separates visitors within a day without keeping anyone.
"""
from __future__ import annotations

import ast
import json
import tempfile
from pathlib import Path

import pytest

from conftest import REPO_ROOT

TRACKER = REPO_ROOT / "lib" / "analytics_tracker.py"
SOURCE = TRACKER.read_text()
TREE = ast.parse(SOURCE)


def _tracker(tmp_path):
    from lib.analytics_tracker import AnalyticsTracker

    return AnalyticsTracker(data_file=str(tmp_path / "visitor_analytics.json"))


def _visit(tracker, headers, ua="Mozilla/5.0 Chrome/120.0.0.0"):
    tracker.track_visit("/basic", user_agent=ua, headers=headers)
    tracker.flush()
    return json.loads(Path(tracker.data_file).read_text())["visits"][0]


# ------------------------------------------------------- the parsed detect --
#
# PARSED, never grepped. Item 16 corrected its own detect for this reason: a
# tree that DOCUMENTS the removal contains the string "ip-api" in the comment
# explaining it, so a grep for that literal reports the defect the comment
# describes the absence of. This module's comment does exactly that.


def test_the_tracker_imports_nothing_that_can_make_a_request():
    modules = set()
    for node in ast.walk(TREE):
        if isinstance(node, ast.Import):
            modules |= {a.name.split(".")[0] for a in node.names}
        elif isinstance(node, ast.ImportFrom) and node.module:
            modules.add(node.module.split(".")[0])

    banned = {"requests", "urllib", "http", "socket", "httpx", "aiohttp"}
    assert not (modules & banned), (
        f"the tracker can reach the network again via {sorted(modules & banned)}"
    )


def test_none_of_the_lookup_callables_survive():
    defined = {n.name for n in ast.walk(TREE)
               if isinstance(n, (ast.FunctionDef, ast.AsyncFunctionDef))}
    gone = {"_geolocate", "geo_for", "get_geolocation", "_backfill_geo"}
    assert not (defined & gone), f"still defined: {sorted(defined & gone)}"


def test_the_grep_form_of_this_detect_would_have_failed():
    """Item 16's correction, demonstrated on this very tree.

    The drop's original detect was "no `ip-api` string in lib/". This file
    and the tracker both name ip-api.com in prose explaining its removal, so
    that detect reports a defect on a tree that has fixed it. Pinned so
    nobody reintroduces the grep form believing it is equivalent.
    """
    assert "ip-api" in SOURCE, (
        "the comment recording WHY the lookup was removed is gone — keep it; "
        "it is the only thing telling the next reader not to add it back"
    )


# ------------------------------------------------------------- the ledger --


def test_no_address_reaches_a_default_config_visit_row(tmp_path):
    row = _visit(_tracker(tmp_path), {"CF-Connecting-IP": "203.0.113.9"})
    assert "ip_address" not in row, row
    for value in row.values():
        assert "203.0.113.9" not in str(value), (
            f"the address is still in the row under another key: {row}"
        )


def test_a_visitor_key_is_stored_instead(tmp_path):
    row = _visit(_tracker(tmp_path), {"CF-Connecting-IP": "203.0.113.9"})
    assert len(row["visitor_key"]) == 16
    int(row["visitor_key"], 16)          # hex, therefore not the input


def test_the_key_is_salted_so_it_is_not_a_reversible_encoding(monkeypatch):
    """HMAC, not a bare digest. The IPv4 space is enumerable: an unkeyed
    hash of an address is the address in a costume."""
    import lib.analytics_tracker as mod

    monkeypatch.setenv("ANALYTICS_VISITOR_SALT", "salt-one")
    one = mod.visitor_key("203.0.113.9", "UA")
    monkeypatch.setenv("ANALYTICS_VISITOR_SALT", "salt-two")
    two = mod.visitor_key("203.0.113.9", "UA")
    assert one != two, "the key does not depend on the salt — it is a plain digest"

    import hashlib
    assert one != hashlib.sha256(b"203.0.113.9|UA").hexdigest()[:16]


def test_the_same_visitor_is_stable_within_one_salt(monkeypatch):
    """It still has to work as a session key, or item 16 breaks the rollup."""
    import lib.analytics_tracker as mod

    monkeypatch.setenv("ANALYTICS_VISITOR_SALT", "fixed")
    assert mod.visitor_key("203.0.113.9", "UA") == mod.visitor_key("203.0.113.9", "UA")
    assert mod.visitor_key("203.0.113.9", "UA") != mod.visitor_key("203.0.113.10", "UA")


# ----------------------------------------------------------- the location --


@pytest.mark.parametrize("headers,expected", [
    ({"CF-IPCountry": "FR", "CF-IPCity": "Lyon"},
     {"country": "FR", "country_code": "FR", "city": "Lyon"}),
    ({"CF-IPCountry": "FR"}, {"country": "FR", "country_code": "FR"}),
])
def test_location_comes_from_the_edge_headers(tmp_path, headers, expected):
    assert _visit(_tracker(tmp_path), headers)["location"] == expected


def test_a_visit_with_no_location_headers_carries_no_location(tmp_path):
    """Never a guess and never a default country: a wrong country in a
    ledger is worse than no country at all."""
    assert "location" not in _visit(_tracker(tmp_path), {})


@pytest.mark.parametrize("code", ["XX", "T1"])
def test_the_non_country_codes_are_not_countries(tmp_path, code):
    """XX is unknown and T1 is Tor. Neither is a place."""
    assert "location" not in _visit(_tracker(tmp_path), {"CF-IPCountry": code})


def test_healthz_reports_which_location_headers_were_seen():
    """The edge's headers are now the ONLY source of location, so whether the
    zone attaches them is worth answering without reading a boot log."""
    from lib.health import health_payload

    geo = health_payload("flask").get("geo") or {}
    assert "headers_seen" in geo
    assert isinstance(geo["headers_seen"], list)


# ------------------------------------------------ the rollup's session key --


def test_the_rollup_prefers_the_stored_key():
    from lib.traffic_rollup import visitor_key as rollup_key

    assert rollup_key({"visitor_key": "abc123", "ip_address": "203.0.113.9",
                       "user_agent": "UA"}) == "abc123"


def test_the_rollup_falls_back_for_rows_written_before_this_item():
    """THE HALF THAT MATTERS INSIDE THE RETENTION WINDOW.

    Rows written before item 16 have an ip_address and no visitor_key. A
    reader that only looked for the new field would collapse every one of
    them onto its User-Agent — a day of distinct visitors becoming a handful
    of sessions, silently.
    """
    from lib.traffic_rollup import visitor_key as rollup_key

    old_a = {"ip_address": "203.0.113.9", "user_agent": "UA"}
    old_b = {"ip_address": "203.0.113.10", "user_agent": "UA"}
    assert rollup_key(old_a) != rollup_key(old_b), (
        "two pre-item visitors collapsed onto one session key"
    )


def test_mixed_old_and_new_rows_do_not_collide():
    from lib.traffic_rollup import visitor_key as rollup_key

    new = {"visitor_key": "deadbeefdeadbeef", "user_agent": "UA"}
    old = {"ip_address": "203.0.113.9", "user_agent": "UA"}
    assert rollup_key(new) != rollup_key(old)


# ------------------------------------------------------------- the salt ----


def test_the_salt_is_gitignored():
    """A committed salt makes every visitor_key in every checkout computable
    by anyone holding the repo, which undoes the whole item."""
    import subprocess

    ignored = subprocess.run(
        ["git", "check-ignore", "-q", ".visitor_salt"], cwd=REPO_ROOT
    ).returncode == 0
    assert ignored, ".visitor_salt is not gitignored"


def test_the_salt_is_not_tracked():
    """The stronger form: ignored AND absent from the index."""
    import subprocess

    tracked = subprocess.run(
        ["git", "ls-files", "--error-unmatch", ".visitor_salt"],
        cwd=REPO_ROOT, capture_output=True,
    ).returncode == 0
    assert not tracked, ".visitor_salt is committed — rotate it and remove it"


def test_an_unwritable_ledger_directory_still_salts(monkeypatch, tmp_path):
    """An unsalted hash of an IP is an IP, so the fallback is a salt, never
    the absence of one."""
    import lib.analytics_tracker as mod

    monkeypatch.delenv("ANALYTICS_VISITOR_SALT", raising=False)
    monkeypatch.setattr(mod, "analytics_path",
                        lambda: Path("/proc/nonexistent/visitor_analytics.json"))
    monkeypatch.setattr(mod, "_fallback_salt", None)
    salt = mod._visitor_salt()
    assert isinstance(salt, bytes) and len(salt) == 32
