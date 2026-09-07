"""The Legal section — 1.6.44 item 15.

Two properties matter more than the prose:

1. ONE STRING PER PAGE. What the browser renders and what the machine lane is
   served are the same markdown. A site whose privacy page says one thing to
   a reader and another to a crawler has two privacy policies, and only one
   of them was reviewed.
2. THE PRIVACY PROSE IS BOUND TO THE CODE. Every key the tracker actually
   writes must be described on the page. If the tracker starts storing
   something new, this goes red rather than the page going quietly false.
"""
from __future__ import annotations

import json
import re


def _flat(text: str) -> str:
    """Whitespace flattened, for matching prose that WRAPS.

    Item 13's rule, and this module needed it twice on its first run: the
    page says "It is never\n  written to disk." across a line break, and a
    raw substring check for that sentence reports it missing from the page
    that contains it.
    """
    return " ".join(text.split())

import pytest

from conftest import CRAWLER_UA, REPO_ROOT


@pytest.fixture(scope="module")
def legal(app_module):
    import pages.legal as mod

    return mod


# ------------------------------------------------------------- one string --


def test_both_pages_serve_the_same_string_to_both_lanes(legal, app_module):
    import pages.privacy as privacy_page
    import pages.terms as terms_page

    assert privacy_page.LLMS_DOC is legal.PRIVACY_DOC
    assert terms_page.LLMS_DOC is legal.TERMS_DOC


def test_the_rendered_page_is_built_from_that_same_string(legal, app_module):
    import pages.privacy as privacy_page

    rendered = str(privacy_page.layout())
    # A sentence unique to the doc, present in the rendered tree.
    assert "reduced to the visitor key and discarded" in rendered
    assert "m2d-page-privacy" in rendered


def test_the_pages_are_registered_with_the_legal_category(app_module):
    import dash

    from lib.constants import CATEGORY_ORDER

    assert "Legal" in CATEGORY_ORDER
    by_path = {e["path"]: e for e in dash.page_registry.values()}
    for path in ("/terms", "/privacy"):
        assert path in by_path, f"{path} is not a registered page"
        assert by_path[path]["category"] == "Legal"


def test_both_appear_in_the_root_machine_index(client):
    """`/terms/llms.txt` and `/privacy/llms.txt` present in the root index."""
    index = client.get("/llms.txt", user_agent=CRAWLER_UA).text
    for path in ("/terms", "/privacy"):
        assert path in index, f"{path} is absent from /llms.txt"


@pytest.mark.parametrize("path", ["/terms", "/privacy"])
def test_the_machine_lane_serves_markdown_not_a_shell(client, path):
    doc = client.get(f"{path}/llms.txt", user_agent=CRAWLER_UA)
    assert doc.status == 200
    assert not doc.text.lstrip().startswith("<!"), "an HTML shell came back"
    assert doc.text.lstrip().startswith("#"), doc.text[:80]


# ------------------------------------- the prose is bound to the mechanism --


def _real_visit_row(tmp_path):
    """A REAL row from the tracker, not a fixture of what we think it writes."""
    from lib.analytics_tracker import AnalyticsTracker

    tracker = AnalyticsTracker(data_file=str(tmp_path / "a.json"))
    tracker.track_visit(
        "/basic",
        user_agent="Mozilla/5.0 (Macintosh) AppleWebKit/537.36 Chrome/120.0.0.0",
        headers={"CF-Connecting-IP": "203.0.113.9", "CF-IPCountry": "FR",
                 "CF-IPCity": "Lyon"},
    )
    tracker.flush()
    return json.loads((tmp_path / "a.json").read_text())["visits"][0]


# What on the page describes each key the tracker writes. The mapping is the
# test's own claim; the keys come from the tracker at run time.
DESCRIBED_BY = {
    "timestamp": "the **time** of the request",
    "path": "the **path** requested",
    "device_type": "a **device type**",
    "user_agent": "the **User-Agent** string",
    "visitor_key": "a **visitor key**",
    "location": "a **location**",
}


def test_every_key_the_tracker_writes_is_described_on_the_page(legal, tmp_path):
    """THE BINDING. Read a real row; require the page to describe each key.

    A new key added to the tracker without a line here fails this test, which
    is the only thing standing between a mechanism change and a privacy page
    that has quietly become untrue.
    """
    row = _real_visit_row(tmp_path)
    undescribed = []
    for key in row:
        phrase = DESCRIBED_BY.get(key)
        if phrase is None or phrase not in legal.PRIVACY_DOC:
            undescribed.append(key)
    assert undescribed == [], (
        f"the tracker writes {undescribed} and the privacy page does not "
        "describe it — add the line, or stop writing the key"
    )


def test_the_binding_would_notice_a_new_key(legal, tmp_path):
    """The mutation: prove the check above can fail.

    A binding test that has never been shown to fail is a binding nobody has
    tested — and this one guards prose, where a false green is invisible.
    """
    row = _real_visit_row(tmp_path)
    row["shoe_size"] = 42
    undescribed = [k for k in row
                   if DESCRIBED_BY.get(k) is None
                   or DESCRIBED_BY[k] not in legal.PRIVACY_DOC]
    assert undescribed == ["shoe_size"]


def test_the_page_does_not_claim_an_address_is_kept(legal, tmp_path):
    """The claim most likely to become false, checked against the row."""
    assert "ip_address" not in _real_visit_row(tmp_path)
    assert "It is never written to disk." in _flat(legal.PRIVACY_DOC)


def test_the_retention_numbers_come_from_the_code(legal):
    """Not typed into prose: a page quoting a stale number is a page lying
    slowly."""
    from lib.analytics_tracker import MAX_VISITS, RETENTION_DAYS

    assert f"**{RETENTION_DAYS} days**" in legal.PRIVACY_DOC
    assert f"**{MAX_VISITS:,} rows**" in legal.PRIVACY_DOC


def test_the_third_party_lookup_claim_is_true_of_this_tree(legal):
    """The page says the lookup was REMOVED, not disabled. Hold it to that."""
    import ast

    assert "removed — not disabled" in legal.PRIVACY_DOC
    tree = ast.parse((REPO_ROOT / "lib" / "analytics_tracker.py").read_text())
    names = {n.name for n in ast.walk(tree)
             if isinstance(n, (ast.FunctionDef, ast.AsyncFunctionDef))}
    assert not (names & {"_geolocate", "geo_for", "get_geolocation"}), (
        "the privacy page says the lookup was removed and it is back"
    )


def test_the_headers_the_page_names_are_the_ones_the_code_reads(legal):
    """A page naming a header the tracker ignores is a page describing
    somebody else's software."""
    from lib.analytics_tracker import LOCATION_HEADERS

    # Matched case-INSENSITIVELY on the flattened doc: the page spells them
    # the way Cloudflare documents them (CF-IPCountry), the code lower-cases
    # them for lookup, and neither spelling is more correct than the other.
    # Reconstructing the display form from the lookup key produced
    # `Cf-Ipcountry` and failed against a page that names it correctly —
    # a detect wrong about its own subject.
    doc = _flat(legal.PRIVACY_DOC).lower()
    for header, _field in LOCATION_HEADERS:
        assert f"`{header}`" in doc, (
            f"{header} is read by the tracker and is not named on the page"
        )


def test_the_footer_reaches_both_pages(app_module):
    from components.footer import create_footer

    text = str(create_footer())
    assert "/terms" in text and "/privacy" in text


def test_no_placeholder_text_shipped(legal):
    """The failure mode of legal prose: a template's leftovers."""
    for doc in (legal.TERMS_DOC, legal.PRIVACY_DOC):
        for smell in ("TODO", "Lorem", "[Company Name]", "{{"):
            assert smell not in doc, smell
        assert not re.search(r"\bexample\.com\b", doc)
