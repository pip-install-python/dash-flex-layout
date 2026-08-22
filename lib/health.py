"""
``/healthz`` liveness probe for the Flask and Quart backends.

The 2plot.ai hub sweeps every satellite's ``/healthz`` once an hour and records
up/down + latency — that's the "Satellite health & reach" panel on ``/traffic``
(the traffic rollup this app POSTs supplies the other half). The FastAPI build
already declares a typed ``/healthz`` in ``lib/asgi_routes`` so it shows up in
Swagger; this module gives the other two backends the same endpoint, so the
probe result doesn't depend on which backend a deployment happens to run.

Keep it cheap: the hub measures the round trip, so any work done here is
reported back as this app being slow.
"""
from __future__ import annotations

import os

import dash


def health_payload(backend: str) -> dict:
    # `app` and `version` are a local addition to the template's payload. The
    # hub only reads `ok`, but they make `curl .../healthz` enough to tell WHICH
    # app answered and WHICH build is live — which is the first thing you want
    # after a deploy, and the check DEPLOYMENT.md documents.
    # scripts/check_release.py keeps APP_VERSION in step with pyproject.toml.
    from lib.constants import APP_VERSION
    from lib.satellite_reporter import app_key

    payload = {
        "ok": True,
        "app": app_key(),
        "version": APP_VERSION,
        "backend": backend,
        "dash_version": dash.__version__,
    }
    # Which commit the RUNNING instance was built from. This is what lets CD
    # verify the artifact it just shipped rather than whichever build happens
    # to be serving: a Render service with a disk restarts with a blip instead
    # of overlapping instances, so a bare 200 proves nothing about WHICH build
    # answered (the muicharts finding, 2026-08-21 — its battery had been
    # verifying the PREVIOUS release on every run, invisibly, until a run added
    # a new surface and the race finally lost). Optional on purpose: omitted
    # where the platform variable does not exist, so the fleet's probe contract
    # is unchanged and cd.yml falls back with a warning on older builds.
    build = os.environ.get("RENDER_GIT_COMMIT")
    if build:
        payload["build"] = build
    return payload


def register_health_route(app, backend: str) -> None:
    """Mount ``/healthz`` on Flask/Quart. No-op on FastAPI (already typed)."""
    if backend == "fastapi":
        return

    server = app.server
    payload = health_payload(backend)

    if backend == "quart":
        from quart import jsonify

        @server.get("/healthz")
        async def _healthz():  # pragma: no cover — quart runtime
            return jsonify(payload)
    else:
        from flask import jsonify

        @server.get("/healthz")
        def _healthz():
            return jsonify(payload)

    print(f"[flexlayout] /healthz registered ({backend}) — "
          "the 2plot.ai hourly health sweep probes this path.")
