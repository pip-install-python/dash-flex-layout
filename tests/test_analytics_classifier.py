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
