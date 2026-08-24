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
   {"ok": true, "app": "flexlayout", "version": "2.0.0",
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
| `SATELLITE_APP_KEY` | `render.yaml` + `run.py` | `flexlayout` |
| `SATELLITE_REPORT_INTERVAL_S` | `render.yaml` | `900` |
| `SATELLITE_PRESENCE_INTERVAL_S` | unset (default `60`) | seconds between presence pings; `0` disables |

The reporter runs **two** threads. The hourly signed rollup is the source of
the board's daily numbers; a second, lighter **presence ping** posts
`{app, active}` to `/api/satellite/active` about once a minute so the hub can
show who is on this satellite right now. Presence is display-only and ephemeral
by contract — the hub holds it in memory with a ~3-minute TTL and never writes
it to the event log — and every presence failure is swallowed silently, because
a hub that predates the endpoint simply 404s. Both share
`CROSS_APP_WEBHOOK_SECRET`; there is no second key.

> **`SATELLITE_APP_KEY`, not `SATELLITE_APP_ID`.** The pre-hub-client
> generation of this code used the `_ID` name; `satellite_reporter.py` reads
> `_KEY` and ignores the old one.
>
> **Where the default now lives.** This repo used to edit the reporter's own
> fallback from the template's `"boilerplate"` to `"flexlayout"` — which is
> exactly what made the file a local fork that could no longer be re-synced,
> and it silently skipped the presence half of the module for a release.
> `lib/satellite_reporter.py` is now **byte-identical** to the boilerplate's
> (`shasum` against it is the check), so its fallback says `"boilerplate"`
> again, and the identity claim moved to a marked FORK POINT at the top of
> `run.py`:
>
> ```python
> os.environ.setdefault("SATELLITE_APP_KEY", "flexlayout")
> ```
>
> before any hub-facing import. `setdefault`, so the real environment value
> above always wins; the line only closes the unset gap. Between the two there
> is no path on which this app's traffic files under the template's hub row.

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

### The interactive gate (shipped DARK)

As of the gate-wave pass this site carries the network's full sign-in stack —
`lib/auth.py`, `lib/access.py`, `lib/gate_layouts.py`, `lib/agent_key.py`, the
`/admin/control-board` page — and it is **switched off**. `PAGE_DEFAULT_TIER`
is declared explicitly as `public`, so every documentation page is open while
the enforcement wiring is live and verifiable. Flipping that one variable to
`auth` gates every page that does not pin its own tier; flipping it back is the
whole rollback, with no code revert anywhere.

Three things follow from that, and each is a thing to check rather than assume:

- **The Clerk block matters even while the gate is dark.** `dash-clerk-auth` is
  vendored (`vendor/dash_clerk_auth-1.0.5.tar.gz`) and installed in every
  image. It registers a Dash *entry-point hook*, so `Dash(...)` imports it
  during construction whether or not the `CLERK_*` keys are set — which is why
  `requirements.txt` also floors `clerk-backend-api>=7.0.0,<8` and
  `cryptography>=50.0.0`. Without those the site does not boot.
- **`/api/agent-key` is mounted always** and answers `204` to anyone without a
  session. It turns a signed-in browser's Clerk session into a portable `?key=`
  for copied `llms.txt` URLs — those get pasted into assistants, which fetch
  with no cookie.
- **`/admin/control-board` fails CLOSED.** Every other tier degrades to public
  when Clerk is unavailable, because documentation must never brick over a
  missing credential. Anything that can change what the site exposes must not.
  Set `ALLOW_UNGATED_ADMIN=1` to work on it locally.

Three boot lines are the acceptance check for a deploy, and two of them are
**absences**:

```
[flexlayout] interactive gate: default tier 'public', 0 non-public page(s), ...
```

...present, and naming `dash-improve-my-llms 2.7.1`; **no** `[visibility]`
warning (the `/var/data` disk is really mounted and `PAGE_VISIBILITY_FILE`
really reached the service); **no** `[auth]` warning
(`CLERK_SATELLITE_SIGN_IN_REDIRECT` is set and is an absolute URL — it is a
destination, not a flag, and both an unset and a non-URL value fail silently in
the browser).

See `.env.example` for every variable, and `render.yaml` for which shared env
group delivers it.

## 4. Plan and persistence

The service runs on Render's **starter** plan with a **1 GB disk mounted at
`/var/data`** (`render.yaml` declares both; the owner attached the disk
fleet-wide on 2026-08-21). That combination is what the rest of this document
assumes:

- **No sleeping.** Starter does not idle out, so there is no cold start for the
  first visitor after a quiet hour — which also means the hub's hourly
  `/healthz` sweep measures the app rather than a container waking up.
- **Two files survive deploys**, both on the disk: the analytics ledger
  (`TRAFFIC_ANALYTICS_FILE`) and the control-board override store
  (`PAGE_VISIBILITY_FILE`). This matters more than it looks: the hub takes the
  **last** report for a given `(app, date)`, so on an ephemeral filesystem a
  mid-day deploy wiped the ledger and the next report overwrote the day's real
  total with whatever had accrued since the restart.
- **A declaration attaches nothing.** `render.yaml` declaring the disk is not
  the same as the disk existing — the pilot host ran for weeks that way, with
  the app quietly `mkdir`-ing `/var/data` on the container filesystem and every
  deploy wiping both files. Verify in the dashboard's Disks tab, or trust the
  boot guard: a `[visibility]` warning names exactly which half is missing, and
  its absence is the pass.
- **Accepted trade-off:** a disk-backed service restarts with a brief blip on
  deploy instead of overlapping instances. Correct for a docs site — and it is
  why `cd.yml` waits for `/healthz` to report *this run's commit* rather than
  merely a 200.
- 512 MB RAM. `WEB_CONCURRENCY=2` (2 gunicorn workers × 4 threads) fits
  comfortably; drop to `1` if you see OOM restarts.

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
