"""The ledger's boot guard — 1.6.44 item 22.

`TRAFFIC_ANALYTICS_FILE` unset means the visitor ledger is on the container
filesystem: it vanishes on the next deploy, and so does the visitor-key salt
beside it. One line at boot says so.

WHY A SUBPROCESS AND NOT caplog. The drop says "via caplog"; that cannot
work. The warning is a `print` at IMPORT time — it runs before logging is
configured, which is the whole reason it is a print — so caplog sees nothing
and a caplog test would pass on a module that said nothing at all. That is
the vacuous-negative family this release keeps meeting, so these boot a real
interpreter and read its output.
"""
from __future__ import annotations

import os
import subprocess
import sys

from conftest import REPO_ROOT

BRACKET = "[analytics] WARNING: TRAFFIC_ANALYTICS_FILE unset"
BOOT = "import sys; sys.path.insert(0, '.'); import lib.analytics_tracker"


def _boot(env_overrides: dict) -> str:
    env = dict(os.environ)
    env.pop("TRAFFIC_ANALYTICS_FILE", None)
    env.update(env_overrides)
    done = subprocess.run([sys.executable, "-c", BOOT], cwd=REPO_ROOT,
                          capture_output=True, text=True, env=env)
    assert done.returncode == 0, done.stderr[-400:]
    return done.stdout + done.stderr


def test_a_fresh_boot_with_the_variable_unset_says_so():
    assert BRACKET in _boot({}), "the boot guard said nothing"


def test_a_fresh_boot_with_it_set_is_SILENT():
    """The other direction. A guard that warns unconditionally is noise, and
    noise in a deploy log is the same as no guard."""
    output = _boot({"TRAFFIC_ANALYTICS_FILE": "/var/data/visitor_analytics.json"})
    assert BRACKET not in output, output[:300]


def test_it_uses_the_same_bracket_as_the_visibility_guard():
    """An operator greps ONE deploy log. A second convention means they have
    to know both."""
    visibility = (REPO_ROOT / "lib" / "page_visibility.py").read_text()
    assert "[visibility] WARNING:" in visibility
    tracker = (REPO_ROOT / "lib" / "analytics_tracker.py").read_text()
    assert "[analytics] WARNING:" in tracker


def test_the_guard_names_the_variable_and_the_fix():
    """A warning that does not say what to set is a warning nobody acts on."""
    output = _boot({})
    assert "TRAFFIC_ANALYTICS_FILE=/var/data/visitor_analytics.json" in output
    assert "salt" in output, (
        "the guard should say the visitor-key salt rotates with the ledger — "
        "that is the consequence an operator cannot infer"
    )


def test_the_guard_and_the_healthz_block_AGREE(monkeypatch, tmp_path):
    """Item 22 pairs with item 20: the guard says it ONCE at boot, the
    `ledger.persistent` field says it CONTINUOUSLY.

    They read the same filesystem, so the test asserts they AGREE rather
    than pinning either value on its own — a pin on one of them would drift
    from the other silently, which is the exact shape of "two systems, one
    truth, nobody comparing them".
    """
    import lib.health as health

    # Unset -> ledger inside the tree -> guard fires AND persistent is False.
    inside = REPO_ROOT / "visitor_analytics.json"
    monkeypatch.setattr("lib.analytics_tracker.analytics_path", lambda: inside)
    assert health._ledger_block()["persistent"] is False
    assert BRACKET in _boot({})

    # Set to a path outside the tree -> persistent True AND the guard silent.
    outside = tmp_path / "visitor_analytics.json"
    monkeypatch.setattr("lib.analytics_tracker.analytics_path", lambda: outside)
    assert health._ledger_block()["persistent"] is True
    assert BRACKET not in _boot({"TRAFFIC_ANALYTICS_FILE": str(outside)})
