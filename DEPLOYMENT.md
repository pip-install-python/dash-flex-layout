# Deploying the documentation site

The `flexlayout-dash` documentation site (`run.py`) is deployed to
[Render](https://render.com) as a Docker web service, fronted by
**https://flexlayout.2plot.dev**.

Everything the deployment needs is in the repo root: [`Dockerfile`](./Dockerfile),
[`.dockerignore`](./.dockerignore) and [`render.yaml`](./render.yaml).

---

## Quick reference

| | |
|---|---|
| Service name | `flexlayout-dash-docs` |
| Plan | `free` |
| Runtime | Docker (`python:3.12-slim`, gunicorn) |
| Health check | `/healthz` |
| Custom domain | `flexlayout.2plot.dev` |
| Local port | 8055 |
| Only manual secret | `CROSS_APP_WEBHOOK_SECRET` |

---

## 1. First deploy

1. **Push this repo to GitHub** with `Dockerfile` and `render.yaml` at the root.
2. Render dashboard → **New → Blueprint** → select
   `pip-install-python/dash-flex-layout`.
3. Render reads `render.yaml`, builds the Dockerfile and starts
   `gunicorn run:server`. First build takes a few minutes; there is no Node step
   because the component bundle is committed.
4. Confirm the service is healthy: `https://<service>.onrender.com/healthz`
   should return

   ```json
   {"ok": true, "app": "flexlayout", "version": "1.2.0",
    "backend": "flask", "dash_version": "4.4.1"}
   ```

## 2. Point flexlayout.2plot.dev at it

1. Render → the service → **Settings → Custom Domains → Add**
   `flexlayout.2plot.dev`.
2. Render shows a target host. Create the record on the `2plot.dev` zone:

   ```
   flexlayout   CNAME   <service>.onrender.com
   ```

3. Wait for Render to report the domain verified and the TLS certificate issued.

The public origin is hard-coded in two places, and **both must match the custom
domain**:

- `FLEXLAYOUT_BASE_URL` in `render.yaml` — feeds canonical URLs, `sitemap.xml`
  and `llms.txt`.
- `app._base_url` in `run.py` — which is what dash-improve-my-llms' prerender
  writes the canonical / `og:url` / per-page `<title>` tags from, server-side,
  on every response. (`templates/index.html` deliberately declares none of
  those; a 2.0-era shim there used to, and double-emitted them.)

Hard-coding the origin (rather than reading `location.origin`) is deliberate: it
makes hits on the `*.onrender.com` host consolidate onto the custom domain
instead of competing with it in search results.

## 3. 2plot network integration

The site runs as a [2plot](https://2plot.ai) network satellite. Both integrations
are **dormant without their environment keys**, so a local `python run.py` makes
no outbound calls and needs no secrets.

### Ads — `lib/ad_client.py`

An ad slot is appended below the table of contents in each page's aside
(`pages/markdown.py` calls `inject_ad_into_aside`). On each page view the server
fetches one campaign from `2plot.dev/api/ad-network/serve`; clicks are beaconed
from the browser straight back to `2plot.dev` with app + page attribution.

Configured entirely from `render.yaml` — no manual step:

| Variable | Value |
|---|---|
| `AD_SERVER_URL` | `https://2plot.dev` |
| `AD_APP_ID` | `flexlayout-dash` |

If the ad server is unreachable the slot simply stays hidden, and a 60-second
circuit breaker stops retrying — an outage never adds an HTTP timeout to a page
view.

### Traffic — the analytics trio

Three modules, copied from `dash-documentation-boilerplate` and kept in step
with it:

| Module | Role |
|---|---|
| `lib/analytics_tracker.py` | The `before_request` hook and the on-disk visit ledger |
| `lib/traffic_rollup.py` | Sessionises the ledger into a daily rollup |
| `lib/satellite_reporter.py` | Signs and POSTs it to `2plot.ai/api/satellite/traffic` |

The result is the owner-only `/traffic` dashboard on 2plot.ai, with numbers that
mean the same thing as every other satellite's.

| Variable | Where | Value |
|---|---|---|
| `CROSS_APP_WEBHOOK_SECRET` | **Render dashboard** | the shared HMAC secret (same value as on 2plot.ai) |
| `SATELLITE_APP_KEY` | `render.yaml` | `flexlayout` |
| `SATELLITE_REPORT_INTERVAL_S` | `render.yaml` | `1800` |

> **`SATELLITE_APP_KEY`, not `SATELLITE_APP_ID`.** The pre-hub-client
> generation of this code used the `_ID` name; `satellite_reporter.py` reads
> `_KEY` and ignores the old one. The module's default was also changed from the
> template's `"boilerplate"` to `"flexlayout"` — left as shipped, this app's
> rollups would have overwritten the boilerplate's rows at the hub.

**`CROSS_APP_WEBHOOK_SECRET` is the one value you must set by hand** — it is
`sync: false` in `render.yaml` precisely so it never lands in the repo. Without
it the app still serves `/healthz`, but reports nothing.

On the hub side, add this app to the hourly health sweep on 2plot.ai:

```
PULSE_POLL_TARGETS=...,flexlayout=https://flexlayout.2plot.dev/healthz
```

Two more routes support this:

- **`/healthz`** (`lib/health.py`) — the network's health convention. Registered whether or not
  reporting is enabled, and excluded from traffic counts, which is why it makes
  a cleaner Render health check than `/`.
- **`/api/pageview`** (`run.py`) — the SPA beacon. A Dash multi-page app serves **one** HTML
  request per visit; every later page is a client-side route change that never
  reaches the server. Without this beacon every session would be reported as
  single-page and `median_session_s` would always be null.

### No authentication

Unlike `leaflet.2plot.dev`, this site has **no Clerk auth** and no page-visibility
control board. Every documentation page is public, so none of the `CLERK_*`
satellite variables apply here.

## 4. Free-tier caveats

- The service **sleeps after ~15 minutes idle** and cold-starts on the next
  request (several seconds for the first visitor).
- The container filesystem is **ephemeral**. The analytics ledger
  (`visitor_analytics.json`, written by `lib/analytics_tracker.py`) lives there,
  so an eviction costs whatever traffic had not yet been reported. `SATELLITE_REPORT_INTERVAL_S=1800` halves that
  window; the reporter also only POSTs when the day's numbers actually changed,
  so an idle day costs zero requests.
- 512 MB RAM. `WEB_CONCURRENCY=2` (2 gunicorn workers × 4 threads) fits
  comfortably; drop to `1` if you see OOM restarts.

Moving to `starter` or higher removes the sleep. Add a persistent disk if the
traffic ledger must survive deploys.

## 5. Running the production image locally

```bash
docker build -t flexlayout-dash-docs .
docker run --rm -p 8055:8055 -e PORT=8055 flexlayout-dash-docs
open http://localhost:8055
```

This is the exact image Render runs. The Dockerfile copies the whole repo and
runs from `/app`: the docs app resolves `docs/`, `assets/`, `components/`,
`lib/` and `pages/` relative to the working directory, and imports the built
`flexlayout_dash/` package from the same directory — one tree, no `sys.path`
juggling.

## 6. Verifying a deploy

```bash
BASE=https://flexlayout.2plot.dev

curl -s $BASE/healthz                  # {"ok":true,"app":"flexlayout",...}
curl -s -o /dev/null -w '%{http_code}\n' $BASE/          # 200
curl -s $BASE/llms.txt | head -5                          # markdown, not HTML
curl -s $BASE/sitemap.xml | grep -c '<loc>'               # one per page
curl -s $BASE/ | grep -o 'rel="canonical" href="[^"]*"'   # the custom domain
```

`version` in the `/healthz` payload comes from
`lib/constants.py:APP_VERSION`, which `scripts/check_release.py` keeps in sync
with `pyproject.toml` — so a stale value there means the release checks were
skipped.

The same checks run headlessly against a local app in
[`scripts/smoke_test.py`](./scripts/smoke_test.py), including `/healthz`,
`/api/pageview`, `/llms.txt`, `/robots.txt`, `/sitemap.xml` and every page route.
