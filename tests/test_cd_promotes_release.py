"""CD promotes main -> release on a green matrix; nothing else writes release.

The road since item 13 (2026-08-29, template owner decision A, ported into
this fork's own cd.yml/render.yaml shape — the template's file differs from
this fork's by host, timeout sizing and comments, so only the CONTRACT is
pinned here): Render auto-deploys the `release` branch and ONLY cd.yml's
`deploy` job writes it, as a fast-forward push of the run's own sha after
the CI matrix is green. The measurement behind the upstream decision: a
push built by Render (watching `main` directly) went red in CD minutes
later, with the red build still serving — CI cannot stop a deploy while the
platform watches the branch CI is still judging.

These pins hold the STRUCTURE — the part a fork can drift silently:
`deploy` still needs `test`; the promote step exists and is not a force
push; the write grant is on that one job, not the workflow; the old
deploy-hook step is gone; render.yaml watches `release`.
"""

from __future__ import annotations

import re
from pathlib import Path

import yaml

REPO = Path(__file__).resolve().parent.parent
CD = REPO / ".github" / "workflows" / "cd.yml"
RENDER = REPO / "render.yaml"


def _cd() -> dict:
    return yaml.safe_load(CD.read_text())


def _deploy() -> dict:
    return _cd()["jobs"]["deploy"]


def _promote_step() -> dict:
    steps = [s for s in _deploy()["steps"] if s.get("name") == "Promote to release"]
    assert len(steps) == 1, "cd.yml deploy job must have exactly one 'Promote to release' step"
    return steps[0]


def test_release_is_only_written_after_a_green_matrix():
    """needs: [test] is the whole gate — a red matrix never reaches the push."""
    assert "test" in _deploy()["needs"]
    assert _cd()["jobs"]["test"]["uses"].endswith("ci.yml")


def test_the_promote_step_is_a_fast_forward_push_of_this_sha():
    # Commands only — the step's comments explain why NOT to force.
    run = "\n".join(
        line for line in _promote_step()["run"].splitlines()
        if not line.lstrip().startswith("#")
    )
    assert re.search(r"git push origin\s+\"?HEAD:refs/heads/release\"?", run), run
    assert "--force" not in run and " -f " not in run and "+HEAD" not in run, (
        "a non-fast-forward push must FAIL the job — someone wrote release "
        "by hand — never be forced over"
    )


def test_the_promote_checkout_is_not_shallow():
    """A depth-1 clone cannot fast-forward an EXISTING ref: the push is
    rejected as non-fast-forward. The first promote passes regardless
    because it creates the branch; a fork will not see this until its
    second push."""
    steps = _deploy()["steps"]
    checkouts = [s for s in steps if str(s.get("uses", "")).startswith("actions/checkout")]
    assert checkouts, "the promote job must check out before it can push"
    assert checkouts[0].get("with", {}).get("fetch-depth") == 0, (
        "promote's checkout must be fetch-depth: 0 — a shallow HEAD pushed "
        "onto an existing release is rejected ('fetch first')"
    )


def test_a_verify_only_dispatch_does_not_promote():
    cond = _promote_step().get("if", "")
    assert "inputs.target_url == ''" in cond and "github.event_name == 'push'" in cond, cond


def test_the_write_grant_is_on_the_deploy_job_only():
    assert _deploy()["permissions"] == {"contents": "write"}
    assert _cd()["permissions"] == {"contents": "read"}, (
        "the workflow-level grant stays read; only the promote job writes"
    )
    for name, job in _cd()["jobs"].items():
        if name != "deploy":
            assert job.get("permissions", {}).get("contents") != "write", name


def test_the_deploy_hook_is_gone():
    """Item 13's own detect, from the inside: the secret's name must not
    appear anywhere in the file, comments included."""
    assert "RENDER_DEPLOY_HOOK" + "_URL" not in CD.read_text()
    assert not any("hook" in (s.get("id") or "") for s in _deploy()["steps"])
    assert "deployed" not in _deploy().get("outputs", {})


def test_verify_never_runs_on_a_failed_deploy():
    """The old `!= 'cancelled' && != 'skipped'` condition admitted `failure`
    too, so a failed promote still let verify run and report GREEN against
    the previous build. Verify must require success AND check the sha
    itself."""
    verify = _cd()["jobs"]["verify"]
    assert "deploy" in verify["needs"]
    assert verify.get("if", "").strip() == "needs.deploy.result == 'success'", verify.get("if")
    sha_steps = [s for s in verify["steps"] if s.get("name") == "The live build IS this run's sha"]
    assert len(sha_steps) == 1, "verify must assert /healthz build == github.sha itself"
    run = sha_steps[0]["run"]
    assert "/healthz" in run and "GITHUB_SHA" in run and "exit 1" in run


def test_render_watches_release():
    doc = yaml.safe_load(RENDER.read_text())
    web = [s for s in doc["services"] if s.get("type") == "web"]
    assert web and all(s.get("branch") == "release" for s in web), (
        "render.yaml must deploy `release` — main is where CI judges, "
        "release is what it certified"
    )
    # autoDeploy stays the mechanism.
    assert all("autoDeploy" not in s or s["autoDeploy"] is True for s in web)


def test_the_road_is_recorded_in_divergences():
    """`deploy: release-branch` belongs in the posture fence once this
    fork's kit copy of tests/test_claude_kit.py recognizes the key
    (_POSTURE_KEYS is {ai_bots, healthz, runtime} as of PR #8's
    1.6.22-1.6.33 fan-out) — until then the fact lives in prose, which
    this pins instead of a fence key the kit test would reject."""
    text = (REPO / "DIVERGENCES.md").read_text()
    assert "release-branch" in text or "deploys `release`" in text, (
        "DIVERGENCES.md must record that Render deploys `release`, "
        "not `main`"
    )
