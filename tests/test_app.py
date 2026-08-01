"""The installable package, as `pip install flexlayout-dash` delivers it.

The docs-site suite next door boots run.py; this file checks the component
package itself — the thing that ships to PyPI — without a browser and without
building anything.
"""

from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def test_package_imports_and_exports_the_components():
    import flexlayout_dash as dfl

    assert dfl.DashFlexLayout.__name__ == "DashFlexLayout"
    assert dfl.Tab.__name__ == "Tab"


def test_the_bundle_is_registered_for_dash_to_serve():
    """`__init__.py` is hand-maintained (see CLAUDE.md); this is its contract."""
    import flexlayout_dash as dfl

    assert dfl.package_name == "flexlayout_dash"
    paths = [d["relative_package_path"] for d in dfl._js_dist]
    assert "flexlayout_dash.min.js" in paths
    for dist in dfl._js_dist:
        bundled = REPO_ROOT / "flexlayout_dash" / dist["relative_package_path"]
        assert bundled.exists(), f"{dist['relative_package_path']} not built"


def test_the_package_version_matches_pyproject():
    import re

    import flexlayout_dash as dfl

    pyproject = (REPO_ROOT / "pyproject.toml").read_text()
    declared = re.search(r'^version\s*=\s*"([^"]+)"', pyproject, re.M).group(1)
    assert dfl.__version__ == declared


def test_no_premium_gate_survives_in_the_component_api():
    """Releases up to 1.0.0 shipped a free/premium split; 1.2.0's docstring
    promises it is gone. Hold the API to it."""
    import inspect

    from flexlayout_dash import DashFlexLayout

    props = set(inspect.signature(DashFlexLayout.__init__).parameters)
    for prop in ("apiKey", "apiUrl", "freeTabLimit"):
        assert prop not in props, f"{prop} is back in the component API"
