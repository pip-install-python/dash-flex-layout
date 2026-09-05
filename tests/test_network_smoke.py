"""Run the network battery against the in-process app.

`scripts/network_smoke.py` only ever executes in two places a developer never
watches: against the container CI just booted, and against production after a
deploy. That is exactly the code that rots — a typo in a check turns it into a
silent pass and the battery keeps reporting green over a broken host.

So it runs here too, with its `fetch` pointed at the test client. Three
distinct things get proven, and it is worth being explicit about which:

1. the battery's own logic still works (the checks fire, and they can fail);
2. this app satisfies every check the network standard makes of a satellite;
3. the per-site block at the top of the script — the expected H1, the hidden
   paths — still matches the app it describes.

What it cannot prove is the deployed artifact, which is the whole reason the
container run and the post-deploy run exist as well.
"""

from __future__ import annotations

import importlib.util
import json
import sys

import pytest

from conftest import REPO_ROOT
from lib.constants import BASE_URL, INTERNAL_UA_TOKEN, SITE_BRAND

BASE = BASE_URL


@pytest.fixture(scope="module")
def battery():
    spec = importlib.util.spec_from_file_location(
        "network_smoke", REPO_ROOT / "scripts" / "network_smoke.py"
    )
    module = importlib.util.module_from_spec(spec)
    sys.modules["network_smoke"] = module
    spec.loader.exec_module(module)
    return module


@pytest.fixture
def wired(battery, client, monkeypatch):
    """Point the battery's `fetch` at the test client.

    The signature is `fetch(url, ua=..., method=..., body=..., headers=...)`
    and it returns `(status, headers, text)`.

    HEAD is emulated (1.6.44 item 5): `head_get_parity_three_uas` compares the
    two methods, so a harness that refused HEAD would make the parity check
    unrunnable in process. Werkzeug answers HEAD through the same view and
    discards the body, which is the behaviour under test.

    Headers come back through the battery's own `_Headers` mapping rather than
    a plain dict, so `get_all()` exists here exactly as it does on the wire —
    a stub that flattened them would hide the multi-valued `Link` this fork
    actually serves folded.
    """
    seen_agents = []

    def fetch(url, ua=battery.UA, method="GET", body=None, headers=None,
              timeout=None, retries=1):
        assert method in ("GET", "HEAD"), (
            f"the satellite battery issued a {method}")
        seen_agents.append(ua)
        path = url[len(BASE):] if url.startswith(BASE) else url
        accept = (headers or {}).get("Accept")
        if method == "HEAD":
            raw = client._raw.head(
                path or "/",
                headers={"User-Agent": ua,
                         **({"Accept": accept} if accept else {})})
            return raw.status_code, battery._Headers(raw.headers), ""
        response = client.get(path or "/", user_agent=ua, accept=accept)
        return response.status, battery._Headers(response.headers), response.text

    monkeypatch.setattr(battery, "fetch", fetch)
    monkeypatch.setattr(battery, "_RESULTS", [])
    # No declaration in the in-process seat: here the "host" serves from the
    # suite's own interpreter, which on the docs matrix's window legs
    # (3.13/3.12) — and in any local venv — is deliberately not the fleet
    # Python. `python_matches_declared` still proves the FIELD exists, which
    # is the half that can rot silently; holding the artifact to the
    # Dockerfile's minor is the container and production seats' job.
    monkeypatch.setattr(battery, "declared_python_minor", lambda: None)
    battery.seen_agents = seen_agents
    return battery


def test_the_battery_passes_against_this_app(wired, capsys):
    wired.satellite_checks(BASE)
    output = capsys.readouterr().out

    failed = [(name, detail) for name, verdict, detail in wired._RESULTS
              if verdict == wired.FAIL]
    assert failed == [], f"battery failures against the in-process app:\n{output}"
    assert len(wired._RESULTS) >= 9, "checks silently stopped running"


def test_every_request_the_battery_makes_is_internal(wired):
    """A battery that pollutes the ledger it is auditing is worse than none."""
    wired.satellite_checks(BASE)
    untokened = [ua for ua in wired.seen_agents if INTERNAL_UA_TOKEN not in ua]
    assert untokened == [], f"battery sent untokened User-Agents: {untokened}"


def test_the_expected_h1_tracks_the_brand_constant(battery):
    """The per-site block is a copy of `SITE_BRAND`; copies drift."""
    assert battery.SITE_H1 == f"# {SITE_BRAND}"


def test_the_default_ua_is_on_the_browser_lane(battery):
    """Item 17 (2026-08-30): a User-Agent with no browser engine token is
    crawler-lane at dimll >=2.8 — the bare internal token used to BE the
    default UA, so every default-UA check in this battery quietly read the
    prerendered crawler document instead of the browser one. UA must carry
    a real Chrome/AppleWebKit token; CRAWLER_UA stays the other lane."""
    from dash_improve_my_llms import classify

    assert classify(battery.UA)["lane"] == "browser", (
        f"battery.UA classifies as {classify(battery.UA)['lane']!r} — a "
        "browser engine token (Chrome/AppleWebKit/...) must come BEFORE "
        "the internal token"
    )
    assert classify(battery.CRAWLER_UA)["lane"] == "crawler"
    assert INTERNAL_UA_TOKEN in battery.UA, "the internal token must survive the fix"


def test_the_battery_reports_a_failure_rather_than_swallowing_it(wired):
    """The check that keeps every other assertion here honest.

    If `check()` ever caught too broadly, the battery would print `pass` for a
    host that is on fire. Break one expectation on purpose and require it to
    be reported.
    """
    wired.SITE_H1 = "# not this site"
    try:
        wired.satellite_checks(BASE)
    finally:
        wired.SITE_H1 = f"# {SITE_BRAND}"

    verdicts = {name: verdict for name, verdict, _ in wired._RESULTS}
    assert verdicts.get("llms_txt_identity") == wired.FAIL


def test_the_default_base_url_matches_the_container_port(battery):
    """CI boots the image and runs the battery with no --base-url.

    The Dockerfile binds `0.0.0.0:${PORT}` with PORT defaulting via ENV, so
    the assertion is on the EXPOSE line and the PORT default rather than a
    literal bind address.
    """
    dockerfile = (REPO_ROOT / "Dockerfile").read_text()
    port = battery.DEFAULT_BASE_URL.rsplit(":", 1)[1]
    assert f"EXPOSE {port}" in dockerfile, (
        f"the battery defaults to port {port}; the image exposes something else"
    )
    assert f"PORT={port}" in dockerfile, "the image's default PORT differs"


def test_a_host_with_no_python_field_fails_the_battery(wired, monkeypatch):
    """Absence is NOT-ADOPTED, never not-applicable (SYNC-1.6.22-1.6.29 item
    5, as amended 1.6.28).

    emojimart's image reached the fleet Python through a dependabot bump
    alone, so `grep ^FROM Dockerfile` — the cheap half of the detect — passed
    while the expensive half, the wire, had nothing to report. A check that
    skipped on a missing field would have called that host adopted.
    """
    real_fetch = wired.fetch

    def fieldless(url, *args, **kwargs):
        status, headers, text = real_fetch(url, *args, **kwargs)
        if url.endswith("/healthz"):
            payload = json.loads(text)
            payload.pop("python", None)
            return status, headers, json.dumps(payload)
        return status, headers, text

    monkeypatch.setattr(wired, "fetch", fieldless)
    wired.satellite_checks(BASE)
    failed = {name: detail for name, verdict, detail in wired._RESULTS
              if verdict == wired.FAIL}
    assert "python_matches_declared" in failed, wired._RESULTS
    assert "no `python` field" in failed["python_matches_declared"]


# ------------------------------------------------- skip is a verdict, not a --
#                                                    pass (1.6.44 item 5)


def test_the_four_new_invariants_are_registered_by_name(wired):
    """Registered BY NAME, so a rename cannot quietly retire one."""
    wired.satellite_checks(BASE)
    names = {name for name, _verdict, _detail in wired._RESULTS}
    for required in ("head_get_parity_three_uas", "api_llms_rows_present",
                     "discovery_link_headers_per_lane",
                     "directory_counts_are_derived"):
        assert required in names, f"{required} did not run: {sorted(names)}"


def test_an_empty_api_packages_SKIPS_rather_than_passing(wired, monkeypatch):
    """THE MUTATION. A pass on an absent precondition is note 88's defect.

    This fork declares one API package, so the skip branch is not the state
    this host runs in — which is precisely why it has to be exercised
    deliberately. Without this, `api_llms_rows_present` would read green on a
    host that indexes nothing, and nobody would learn the difference between
    "the index is right" and "there was no index to check".
    """
    import lib.constants as constants

    monkeypatch.setattr(constants, "API_PACKAGES", [])
    monkeypatch.setattr(wired, "_RESULTS", [])
    wired.satellite_checks(BASE)

    verdicts = {name: verdict for name, verdict, _ in wired._RESULTS}
    assert verdicts.get("api_llms_rows_present") == wired.SKIP, (
        f"empty API_PACKAGES did not SKIP: {verdicts.get('api_llms_rows_present')!r}"
    )


def test_the_populated_case_really_passes_so_the_skip_means_something(wired):
    """The other half of the mutation: with packages declared it must PASS.

    A check that skipped in both directions would satisfy the test above
    while testing nothing.
    """
    from lib.constants import API_PACKAGES

    assert API_PACKAGES, "this fork is expected to declare an API package"
    wired.satellite_checks(BASE)
    verdicts = {name: verdict for name, verdict, _ in wired._RESULTS}
    assert verdicts.get("api_llms_rows_present") == wired.PASS, wired._RESULTS


def test_link_headers_survive_folding_and_repetition(battery):
    """The header mapping keeps repeats AND parses folded values.

    Both shapes are legal and this host serves the folded one, so a check
    that counted headers rather than parsing relations would pass here and
    fail on a peer for no reason anyone could see.
    """
    import email.message

    folded = email.message.Message()
    folded["Link"] = '</llms.txt>; rel="alternate", </llms.txt>; rel="describedby"'
    repeated = email.message.Message()
    repeated["Link"] = '</llms.txt>; rel="alternate"'
    repeated["Link"] = '</llms.txt>; rel="describedby"'

    import re

    for label, message, n in (("folded", folded, 1), ("repeated", repeated, 2)):
        headers = battery._Headers(message)
        values = headers.get_all("link")
        assert len(values) == n, f"{label}: {values}"
        rels = set(re.findall(r'rel="?([a-zA-Z-]+)"?', ", ".join(values)))
        assert rels == {"alternate", "describedby"}, f"{label}: {rels}"
        # dict semantics unchanged for every existing caller
        assert headers["link"] == values[-1]
