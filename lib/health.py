"""
``/healthz`` liveness probe for the Flask and Quart backends.

The 2plot.ai hub sweeps every satellite's ``/healthz`` once an hour and records
up/down + latency — that's the "Satellite health & reach" panel on ``/traffic``
(the traffic rollup this app POSTs supplies the other half). The FastAPI build
declares a typed ``/healthz`` in ``lib/asgi_routes`` so it shows up in Swagger,
but it renders from the SAME ``health_payload`` below — one payload builder on
every backend, so the probe contract doesn't depend on which backend a
deployment happens to run. THIS FORK IS FLASK-ONLY (there is no
``lib/asgi_routes``); the shared-builder shape is kept anyway so the file stays
a straight port of the template's.

Keep it cheap: the hub measures the round trip, so any work done here is
reported back as this app being slow.
"""
from __future__ import annotations

import os
import platform

import dash


def _resolved_country(headers=None) -> str:
    """``geo.explain_resolution`` over THIS request's headers, or a reason.

    Reads the request headers directly rather than anything the package
    threads through, so it answers "did the country header reach this app
    at all?" independently of how the enforcement seam is wired.

    Each route passes its own framework's headers explicitly — the template's
    first version read Flask's request context, which made the FastAPI and
    Quart lanes answer "no request context" forever (pannellum's production
    healthz was the host that showed it, first wave of the >=2.7.1 floor
    round). ``normalize_headers`` accepts Flask/Starlette/Quart/dict and never
    raises. The Flask-context fallback stays for callers that pass nothing.
    """
    try:
        from dash_improve_my_llms import geo
        from dash_improve_my_llms._headers import normalize_headers
    except Exception:
        return "unavailable (pre-2.7.0 package)"

    try:
        if headers is not None:
            return geo.explain_resolution(normalize_headers(headers))

        from flask import has_request_context, request

        if not has_request_context():
            return "no request context"
        return geo.explain_resolution(normalize_headers(request.headers))
    except Exception:
        return "unavailable"


def health_payload(backend: str, headers=None) -> dict:
    payload = {
        "ok": True,
        "backend": backend,
        "dash_version": dash.__version__,
        # WHICH interpreter is serving (SYNC-1.6.22-1.6.29 item 5). The
        # image, the CI matrix and render.yaml can each declare a Python and
        # nothing on the wire could contradict any of them — the template
        # carried a patch-pinned 3.11.8 image, a 3.12 matrix and a 3.12.0
        # render.yaml at the same time, invisibly, for months (ops-seat
        # finding, 2026-08-25). This field is the observability;
        # scripts/network_smoke.py's python_matches_declared asserts it
        # against the Dockerfile's FROM minor, which is the teeth. Absence
        # is NOT-ADOPTED, never not-applicable: emojimart's image reached
        # 3.14 through dependabot alone, so the cheap half of the detect
        # passed while the expensive half failed silently.
        "python": platform.python_version(),
    }

    # Which commit the RUNNING instance was built from. This is what lets CD
    # verify the artifact it shipped rather than whichever build happens to
    # be serving: a Render service with a disk restarts with a blip instead
    # of overlapping instances, so a bare 200 proves nothing about WHICH
    # build answered (the muicharts finding, 2026-08-21 — its battery had
    # been verifying the previous release on every run, invisibly, until a
    # new surface made the race lose). Optional on purpose: omitted where
    # the platform variable does not exist, so the fleet's probe contract
    # is unchanged and cd.yml falls back with a warning on older builds.
    build = os.environ.get("RENDER_GIT_COMMIT")
    if build:
        payload["build"] = build

    # WHICH satellite answered. `build` says which commit, this says which
    # app — and on a fleet where every host shares this template and a
    # hostname can be repointed between services (llms.2plot.dev was,
    # 2026-08-23), "is this the site I think it is?" is a different question
    # from "is this the build I shipped?". Read straight from the
    # environment, NOT through lib.satellite_reporter: this must report what
    # this process actually claimed at run.py's FORK POINT, including the
    # "unknown" that says nothing claimed anything.
    payload["app"] = os.environ.get("SATELLITE_APP_KEY") or "unknown"

    # A local addition to the template's payload: the release string, so
    # `curl .../healthz` answers "which build" in human terms as well as by
    # commit. scripts/check_release.py keeps APP_VERSION in step with
    # pyproject.toml, and DEPLOYMENT.md documents the check.
    from lib.constants import APP_VERSION

    payload["version"] = APP_VERSION

    # The geo guardrail's LIVE state (dash-improve-my-llms >= 2.7.0). Added
    # after llms-2plot-dev's production verification could not answer "is
    # the denylist actually in force?" from outside: the control board and
    # the public policy showcase both showed countries denied while every
    # request was served 200, and the only surfaces that could settle it
    # (the boot log, the operator panel) need credentials a verification
    # pass does not have.
    #
    # Counts and flags only — never the denylist's country codes: a health
    # endpoint is not where anyone should learn policy. `resolved` reveals
    # only the caller's own country back to them, which Cloudflare's
    # /cdn-cgi/trace already does — and it is THE per-host check
    # docs/GEO.md calls mandatory before trusting a denylist. It also
    # localises a failure: geo can be configured with a full denylist and
    # still never match if the country header is not reaching the app —
    # "configured: true, denied: 7, resolved: unknown" says that in one
    # line.
    try:
        from dash_improve_my_llms import geo
    except ImportError:
        # Pre-2.7 package: the key is OMITTED, not error-flagged — a host on
        # an older floor is not broken, it just predates the diagnostic. The
        # fleet's >=2.7.1 floor round lights this up with no further change,
        # which also makes `geo`'s ABSENCE in production the tell that the
        # Docker cache trap fired and the floor did not really move.
        pass
    else:
        try:
            payload["geo"] = {
                "configured": bool(geo.is_configured()),
                "denied": len(
                    geo.effective_policy().get("deny_countries") or []
                ),
                "resolved": _resolved_country(headers),
            }
        except Exception:  # never let a diagnostic break the health probe
            payload["geo"] = {"configured": False, "denied": 0, "error": True}

    return payload


def register_health_route(app, backend: str) -> None:
    """Mount ``/healthz`` on Flask/Quart. No-op on FastAPI (already typed)."""
    if backend == "fastapi":
        return

    server = app.server

    # Built PER REQUEST, not once at registration. It used to be a snapshot
    # closed over by the route — harmless while every field was static
    # (ok/backend/dash_version/build never change for a running process),
    # and silently wrong the moment one is not: on llms-2plot-dev the route
    # is registered ~150 lines before configure_geo runs, so a snapshot
    # reported the guardrail as unconfigured on a host where it is
    # configured — the diagnostic lying in exactly the situation it exists
    # for (found 2026-08-23, fixed fork-side first). Here too: this route is
    # registered at run.py:~424, well after the app's own configuration.
    if backend == "quart":
        from quart import jsonify, request

        @server.get("/healthz")
        async def _healthz():  # pragma: no cover — quart runtime
            return jsonify(health_payload(backend, headers=request.headers))
    else:
        from flask import jsonify, request

        @server.get("/healthz")
        def _healthz():
            return jsonify(health_payload(backend, headers=request.headers))

    print(f"[flexlayout] /healthz registered ({backend}) — "
          "the 2plot.ai hourly health sweep probes this path.")
