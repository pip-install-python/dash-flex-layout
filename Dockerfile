# syntax=docker/dockerfile:1
# ---------------------------------------------------------------------------
# flexlayout-dash documentation site (run.py) — production image for
# https://flexlayout.2plot.dev.
#
# The component bundle (flexlayout_dash/flexlayout_dash.min.js) is committed,
# so no Node/webpack build is needed: this is a pure-Python image serving the
# pre-built Dash app with gunicorn. node_modules/ and src/ are excluded via
# .dockerignore.
# ---------------------------------------------------------------------------
FROM python:3.14-slim

# PYTHONUNBUFFERED        -> stream logs straight to stdout (Render shows them live)
# PYTHONDONTWRITEBYTECODE -> no .pyc clutter in the image
# PORT                    -> local default; Render overrides this at runtime
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PORT=8055

WORKDIR /app

# Install Python deps first so this layer is cached across app-code changes.
# requirements.txt is the DOCUMENTATION SITE's dependency list (Dash 4.x, DMC,
# the markdown engine, gunicorn) — the component's own are in pyproject.toml
# and are not needed to serve the site.
#
# vendor/ holds dash_clerk_auth, which is not on PyPI: requirements.txt
# installs it from `./vendor/dash_clerk_auth-1.0.5.tar.gz`, so vendor/ MUST be
# copied BEFORE the requirements install. Get this order wrong and pip reports
# the missing path as a SOFT WARNING, then dies seconds later on an OSError
# that reads like a registry outage — a fork lost an afternoon to it. Auth
# stays gated at runtime: no CLERK_* keys, no login wall.
#
# CACHE SEMANTICS (the round-2 fleet lesson, found by pannellum 2026-08-22):
# this layer re-runs ONLY when vendor/ or requirements.txt bytes change. A
# `>=` floor can NEVER pull a newer release through a cache hit — a code-only
# commit rebuilds the app layers below while pip silently keeps whatever
# version the image was first built with. Ship every dependency upgrade as a
# floor bump in requirements.txt (grep the NUMBER — it also lives in run.py's
# boot floor and in CI's two fingerprint asserts): the bump IS the cache bust,
# and the boot floor turns a stale image from a silent downgrade into a loud
# refusal to start.
COPY vendor/ ./vendor/
COPY requirements.txt ./requirements.txt
# Two commands, deliberately (network standard, same as the boilerplate):
# markdown2dash 0.1.2 declares `gunicorn<22` against the CVE-driven
# gunicorn>=23 floor in requirements.txt, so it installs with its dependency
# graph skipped. CI's fingerprint step asserts the dodge kept working.
RUN pip install --no-cache-dir -r requirements.txt \
 && pip install --no-cache-dir --no-deps markdown2dash==0.1.2

# The docs site and the built flexlayout_dash/ package both live at the repo
# root, so one COPY covers both: run.py resolves docs/, assets/, components/,
# lib/ and pages/ relative to the working directory, and imports the component
# straight from flexlayout_dash/ with no sys.path juggling and no pip install.
COPY . .

# Documentation only; the process actually binds to $PORT (below).
EXPOSE 8055

# run:server is the Flask WSGI callable (run.py: `server = app.server`).
# Shell form so ${PORT} / ${WEB_CONCURRENCY} expand when the container starts.
#
# The port is defaulted AT THE POINT OF USE (${PORT:-8055}), not only by the
# ENV above (template 1.6.14, SYNC-1.6.10-1.6.16 item 5). ENV covers PORT
# being UNSET; it does not cover PORT being set EMPTY, which a platform can
# do — and a bare ${PORT} then collapses the bind to "0.0.0.0:" and the
# container never listens. 8055 is this host's number, not the template's.
CMD gunicorn run:server --bind "0.0.0.0:${PORT:-8055}" --workers "${WEB_CONCURRENCY:-2}" --threads 4 --timeout 120 --access-logfile - --error-logfile -
