"""ONE CLASSIFIER — lib/analytics_tracker.py must carry no UA lists of its
own; is_bot()/detect_bot_type() must agree with dash_improve_my_llms.classify()
for real vendor and browser user agents.

The defect this guards: this module used to carry a fourth User-Agent list
(bot_patterns / training_bots / search_bots / traditional_bots) that filed
ClaudeBot — Anthropic's TRAINING crawler — under "search", still named the
retired anthropic-ai/claude-web tokens, and counted an absent or library UA
as a desktop human. Every host that kept such a list reported wrong numbers.
The fix is structural, not a patched list: delegate to the package's
registry so the site's robots.txt and its bot accounting can never disagree.
"""

from __future__ import annotations

import inspect

import pytest

from lib.analytics_tracker import AnalyticsTracker, tracker

SOURCE = inspect.getsource(__import__("lib.analytics_tracker", fromlist=["_"]))

# The retired tokens this module used to carry. None of them may appear in
# the file text any more — their presence means a UA list crept back in.
RETIRED_TOKENS = (
    "'anthropic-ai'", '"anthropic-ai"',
    "'claude-web'", '"claude-web"',
    "'gptbot'", '"gptbot"',
    "'googlebot'", '"googlebot"',
    "'bingbot'", '"bingbot"',
    "training_bots", "search_bots", "traditional_bots", "bot_patterns",
)


@pytest.mark.parametrize("token", RETIRED_TOKENS)
def test_no_hardcoded_ua_list_survives_in_the_module_text(token):
    assert token not in SOURCE, (
        f"{token!r} found in lib/analytics_tracker.py — a hardcoded "
        "User-Agent list crept back into the ONE-classifier module"
    )


def test_the_module_imports_classify_from_the_package():
    import lib.analytics_tracker as mod

    assert mod.classify.__module__.startswith("dash_improve_my_llms"), (
        "lib.analytics_tracker.classify must be the package's classify(), "
        "not a local reimplementation"
    )


# ---------------------------------------------------------------------------
# Behavioural agreement: is_bot()/detect_bot_type() vs classify() directly
# ---------------------------------------------------------------------------

BROWSER_UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
GPTBOT_UA = "GPTBot/1.0"
CLAUDEBOT_UA = "Mozilla/5.0 (compatible; ClaudeBot/1.0; +https://anthropic.com)"


@pytest.mark.parametrize("ua", [BROWSER_UA, GPTBOT_UA, CLAUDEBOT_UA, "", "python-requests/2.31"])
def test_is_bot_agrees_with_classify_lane(ua):
    from dash_improve_my_llms import classify

    expected = classify(ua)["lane"] == "crawler"
    assert tracker.is_bot(ua) == expected, ua


def test_claudebot_classifies_as_training_not_search():
    """The contract-change case the item text calls out by name: ClaudeBot
    is Anthropic's TRAINING crawler and must classify `training`, never the
    retired `search` filing."""
    assert tracker.detect_bot_type(CLAUDEBOT_UA) == "training"


def test_gptbot_classifies_as_training():
    assert tracker.detect_bot_type(GPTBOT_UA) == "training"


def test_an_absent_user_agent_is_a_bot_now():
    """Contract change from the list this replaced: an absent UA used to be
    filed as a desktop human. The package puts it on the crawler lane, and
    this module must not override that."""
    assert tracker.is_bot("") is True
    assert tracker.detect_device_type("") == "bot"


def test_a_real_browser_is_never_a_bot():
    assert tracker.is_bot(BROWSER_UA) is False
    assert tracker.detect_device_type(BROWSER_UA) == "desktop"


def test_detect_bot_type_never_raises_and_always_returns_a_string():
    for ua in (None, "", BROWSER_UA, GPTBOT_UA, "\x00garbage\xff"):
        result = tracker.detect_bot_type(ua)
        assert isinstance(result, str) and result


def test_a_fresh_tracker_instance_uses_the_same_classifier():
    """is_bot/detect_bot_type are instance methods (this fork's tests call
    them by name on an instance) — a second instance must classify
    identically, since the classifier is module-level, not per-instance
    state."""
    other = AnalyticsTracker(data_file="/tmp/does-not-matter.json")
    assert other.is_bot(GPTBOT_UA) == tracker.is_bot(GPTBOT_UA)
    assert other.detect_bot_type(GPTBOT_UA) == tracker.detect_bot_type(GPTBOT_UA)


# --------------------------------------------- prefer, then derive (item 8) --


def test_a_package_supplied_vendor_class_passes_through_untouched(monkeypatch):
    """THE CONFLICTING FIXTURE. A test whose registry answer AGREES with the
    package's cannot fail, so the two are made to disagree deliberately.

    If the fork ever computes the class unconditionally, the registry's value
    wins here and the assertion catches it.
    """
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "classify", lambda ua, ip=None: {
        "lane": "crawler", "bot_type": "training", "vendor_key": "gptbot",
        "vendor_class": "PACKAGE_SAYS_THIS", "verified": "verified",
    })
    monkeypatch.setattr(mod, "_vendor_class_from_registry",
                        lambda key: "REGISTRY_SAYS_OTHERWISE")

    assert mod._classify("GPTBot/1.0")["vendor_class"] == "PACKAGE_SAYS_THIS", (
        "the fork overwrote the package's vendor_class with its own answer"
    )


def test_the_registry_is_consulted_only_where_the_class_is_absent(monkeypatch):
    """THE MIRROR. "Prefer" that never derives and "derive" that never
    prefers both pass a one-sided test, so both directions are pinned."""
    import lib.analytics_tracker as mod

    monkeypatch.setattr(mod, "classify", lambda ua, ip=None: {
        "lane": "crawler", "bot_type": "training", "vendor_key": "gptbot",
        "vendor_class": None, "verified": "verified",
    })
    monkeypatch.setattr(mod, "_vendor_class_from_registry",
                        lambda key: f"DERIVED:{key}")

    assert mod._classify("GPTBot/1.0")["vendor_class"] == "DERIVED:gptbot", (
        "the class was absent and the registry was not consulted"
    )


def test_the_registry_helper_reads_the_packages_own_registry():
    """Never a hand-written map: `get_vendor()` reads what `classify()` reads.

    Measured against the resolved package rather than asserted — this fork's
    floor (>=2.8.0) is BELOW the 2.9.2 that puts vendor_class on the event,
    so the derive path is the live one here, not the fallback.
    """
    from dash_improve_my_llms._ledger import EVENT_FIELDS

    import lib.analytics_tracker as mod

    if "vendor_class" in EVENT_FIELDS:
        # 2.9.2+: the package supplies it, derivation is the fallback.
        return

    derived = mod._vendor_class_from_registry("gptbot")
    assert derived, (
        "on a package below 2.9.2 the registry is the ONLY source of "
        "vendor_class, and it returned nothing for a known vendor"
    )


def test_an_unknown_or_missing_vendor_derives_nothing_rather_than_guessing():
    import lib.analytics_tracker as mod

    assert mod._vendor_class_from_registry(None) is None
    assert mod._vendor_class_from_registry("") is None
    assert mod._vendor_class_from_registry("not-a-real-vendor-xyz") is None


def test_classification_still_survives_a_raising_package(monkeypatch):
    """The totality guarantee must not have been lost to the new branch."""
    import lib.analytics_tracker as mod

    def boom(ua, ip=None):
        raise RuntimeError("registry exploded")

    monkeypatch.setattr(mod, "classify", boom)
    result = mod._classify("anything")
    assert result["lane"] == "browser" and result["verified"] == "n/a"
