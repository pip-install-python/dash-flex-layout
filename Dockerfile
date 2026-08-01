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
FROM python:3.12-slim

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
CMD gunicorn run:server --bind "0.0.0.0:${PORT}" --workers "${WEB_CONCURRENCY:-2}" --threads 4 --timeout 120 --access-logfile - --error-logfile -
