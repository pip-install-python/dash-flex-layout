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

import dash


def health_payload(backend: str) -> dict:
    # `app` and `version` are a local addition to the template's payload. The
    # hub only reads `ok`, but they make `curl .../healthz` enough to tell WHICH
    # app answered and WHICH build is live — which is the first thing you want
    # after a deploy, and the check DEPLOYMENT.md documents.
    # scripts/check_release.py keeps APP_VERSION in step with pyproject.toml.
    from lib.constants import APP_VERSION
    from lib.satellite_reporter import app_key

    return {
        "ok": True,
        "app": app_key(),
        "version": APP_VERSION,
        "backend": backend,
        "dash_version": dash.__version__,
    }


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

    print(f"[boilerplate] /healthz registered ({backend}) — "
          "the 2plot.ai hourly health sweep probes this path.")
