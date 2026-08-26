# Divergences from the template

Every DELIBERATE difference between this repo and
dash-documentation-boilerplate, with its reason. This file is the
boundary between design and drift:

- Template syncs read this file FIRST and must not "restore" anything
  recorded here.
- A difference not recorded here is treated as drift and will be
  synced away.
- Record the divergence in the SAME commit that creates it — one
  line: what differs, why, and what the template would otherwise do.
- An empty list is a statement too: it means this repo intends to
  match the template exactly.

This list is not a diff. Branding, copy, page content, colors, the
navbar order, the changelog and the favicon *images* differ because
this is a different site, and none of that is recorded here. What is
recorded is behavior this fork decided differently — the things a
wholesale file copy would silently undo.

## This repo's divergences

### 1. This repo is a component library first, a docs site second

The template is a documentation site. This repo is the
`flexlayout-dash` PyPI package (React 18 + FlexLayout-React +
webpack under `src/`, the built bundle committed at
`flexlayout_dash/flexlayout_dash.min.js`) with the docs site living
at the repo root beside it. Consequences that look like drift and
are not: `MANIFEST.in` is an allow-list that keeps the docs site out
of the wheel; `requirements.txt` is the DOCS SITE's dependency list
while the package's own live in `pyproject.toml`; `package.json`,
`webpack.config.js`, `scripts/check_release.py`,
`scripts/smoke_test.py`, `scripts/compat_matrix.py` and
`.github/workflows/release.yml` have no template counterpart.
`run.py` sits beside the built package, so live examples import it
with no `sys.path` juggling and no install.

### 2. Flask-only — the ASGI half of the template is absent

No `lib/backend.py`, `lib/asgi_routes.py`, `lib/asgi_middleware.py`,
`lib/proxy.py`, `components/backend_badge.py`, `docker-compose.yml`
or `tests/test_proxy_scheme.py`. `run.py` constructs `Dash(...)` with
no backend selection and calls `register_health_route(app, "flask")`
literally. `lib/health.py` nonetheless keeps the template's
shared-`health_payload` shape, including its `quart`/`fastapi`
branches, so the file stays a straight port and the probe contract
does not fork — its module docstring says so. A sync that ports the
ASGI modules here would add a backend this image cannot serve.

### 3. `lib/health.py` — `app` sourcing: CONVERGED, no longer a divergence

*Retired 2026-08-24, and left here rather than deleted because two
fleet records still describe it as live.* This fork reads
`payload["app"] = os.environ.get("SATELLITE_APP_KEY") or "unknown"`
rather than `lib.satellite_reporter.app_key()`, whose fallback is
literally `"boilerplate"` — a host that never claimed an identity
would otherwise report someone else's. The template has since done
the same thing: `lib/health.py:77` in 1.6.15 (`1638528`) is that
identical line. Verified by diff, not by memory. **Nothing to defend
in a sync any more**; the reasoning is kept because it is why the
line reads as it does, and identity is still claimed once, at the
marked FORK POINT near the top of `run.py`.

### 4. `lib/health.py` — the payload carries `version`

A local addition on top of the template's payload: `APP_VERSION` from
`lib/constants.py`, so `curl .../healthz` answers "which build" in
human terms as well as by commit. `scripts/check_release.py` keeps it
in step with `pyproject.toml`. The template has no equivalent field;
a sync must add ours back, not drop it.

### 5. `pages/markdown.py::_build_llms_doc` skips its preamble over a body H1

The machine-lane document builder prepends `# {name}` only when the
body does not already open with its own H1 (fence-aware).
`docs/home/home.md` opens with the site brand as an H1 — the identity
standard, pinned by `tests/test_site_identity.py` — so the preamble
would hand crawlers a duplicate-H1 home page: exactly the defect
dash-improve-my-llms 2.7.0 removed on the package's side,
reintroduced one layer up by this app. Measured 2026-08-23: `/`
served 4 h1s on 2.6.1, 3 on 2.7.1, 1 after this. The template has no
such rule because all its docs start at h2 and never hit it.
Demoting home.md's H1 is the obvious-looking alternative and it
breaks site identity — the guard catches it, but only after the
wrong edit is made. Pinned by `tests/test_pages.py`.

### 6. `lib/constants.py` — BASE_URL defaults to this host's real domain

The template defaults `BASE_URL` to ITS domain and makes an unset
`APP_BASE_URL` fatal in production, because a fork that inherits the
template's default silently deindexes itself as a duplicate. This
repo IS the fork: its default is `https://flexlayout.2plot.dev`, so
the failure that guard exists to catch cannot happen here and
`require_owned_base_url` deliberately tolerates an unset variable in
production (it still rejects platform hostnames). Two env names are
accepted, in order: `APP_BASE_URL` (the network-shared spelling) then
`FLEXLAYOUT_BASE_URL` (this repo's legacy alias, still set on the live
service; `render.yaml` sets BOTH — removing one of two names from a
live service is how a satellite quietly deindexes itself). The
mirrored tests live in `tests/test_config.py` and are labelled as the
deliberate opposite of the template's.

### 7. `lib/directives/kwargs.py` parses Dash's `Keyword arguments:` docstrings

The template's parser understands only numpy-style
`Parameters\n----------` blocks. Dash component classes document
props as `- name (type; default):`, so every `.. kwargs::` table on
this site would render EMPTY under the template's file. This fork
adds `convert_dash_docstring_to_dict` alongside the numpy parser. A
byte-copy of the template's `kwargs.py` blanks the prop tables that
are the reason this documentation site exists.

### 8. The home page is a docs folder, not a `pages/` module

`docs/home/home.md` carries `endpoint: "/"` and is registered by the
same `pages/markdown.py` walk as every other page — there is no
`pages/home.py` + `pages/home.md` pair and no special-casing in
`run.py`. One authoring path for every page, root included.

### 9. `templates/index.html` — the noscript block carries no H1

Its headings are `<h2>`/`<h3>`. Crawlers run no JavaScript and DO
parse noscript content, so an `<h1>` there is a second H1 on every
page of the machine lane. Pinned by `tests/test_config.py`
(`test_noscript_block_carries_no_h1`, which strips HTML comments
before counting). The file itself must not be deleted: social
scrapers never take the prerender path, and
`tests/test_social_card.py` pins it.

### 10. The icon set is this host's own four files

`flexlayout.2plot.dev` draws its own dock mark
(`scripts/make_brand_assets.py`, a fork-only script — the template's
`scripts/make_favicons.py` is absent) into favicon.ico, favicon-192,
favicon-512 and apple-touch-icon. `run.py`'s `configure_seo(icons=…)`
list is deliberately shorter than the template's eight-file
realfavicongenerator layout: copying it verbatim publishes five
hrefs that 404 here. The rule is every emitted href RESOLVES and the
declaration is set-equal to what autodiscovery finds;
`tests/test_seo_icons.py` pins both, and pins that these are the same
paths `templates/index.html` links.

### 11. `.github/dependabot.yml` — never an npm ecosystem here

**An explanatory mention, NOT a byte claim** — recorded because the
hazard is this fork's alone, not because the file diverges. The
template has no npm entry either, so nothing here is a difference
from it; `.github/dependabot.yml` is deliberately absent from the
byte-owned fence below and the F3b fan-out owns its bytes.

Why it still needs saying: this repo's `package.json` is REAL (React
18 + FlexLayout-React + webpack — the component's own build
toolchain; the boilerplate deleted its vestigial copy in 1.6.9). A
React or webpack bump here is not a config change: it requires `npm
run build`, which rewrites the COMMITTED
`flexlayout_dash/flexlayout_dash.min.js` that this site and every
`pip install flexlayout-dash` serve. Dependabot cannot rebuild that,
so an automated npm PR would ship a lockfile whose bundle nobody
regenerated. Component dependency moves go through a human `npm run
build` + release. **This paragraph is the durable home for that
reasoning** — the in-file comment saying the same thing is a
convenience copy, and template 1.6.24's rewrite of that file will
remove it. That is fine; do not read its removal as permission to
add an npm entry.

Correction, 2026-08-26: this entry previously ended "The pip
allow-list and the docker/actions ecosystems match the template."
That is no longer true — template 1.6.24 removed the pip ecosystem
outright (floors move through sync specs, not floor-raise PRs) and
this fork has not yet consumed that file. The gap is UNSYNCED DRIFT,
not divergence, and it is the 1.6.22-1.6.27 `sync-verbatim` block's
to close.

### 12. The image has no apt layer, and therefore no HEALTHCHECK

The template installs `curl` so its Dockerfile can declare a
`HEALTHCHECK` against `/healthz`. This image is pure Python (the JS
bundle is committed, so the 1.6.9 "drop the Node layer" conditional
never applied here either) and installs no system packages at all.
Liveness is covered from outside the container: Render probes the
service over HTTP, and `cd.yml`'s wait polls `/healthz` until
`build == GITHUB_SHA` before the battery runs. Adding the template's
HEALTHCHECK means adding an apt layer for one binary; if the fleet
ever standardizes on the in-image check, that is the trade to make
knowingly.

Amended 2026-08-26: the "apt layer for one binary" premise is
weaker than it was. `SYNC-1.6.10-1.6.16` item 5 records clerkhook's
python-urllib probe as an accepted alternative — no apt, no curl —
and `SYNC-1.6.17-1.6.21` item 2 (CI asserts `docker inspect`'s
`State.Health.Status`, failing on `none`) is BLOCKED here for as
long as this image declares no HEALTHCHECK: with none declared the
verdict is `none` by construction, so that item would fail
vacuously rather than measure anything. Recorded as an open
decision, not defended: this entry's second half (liveness is
covered from outside the container) still holds, but "it would cost
an apt layer" no longer does.

### 13. `.claude/` ships the kit only; this fork's older workspace stays local

The `.gitignore` allow-list is the template's, ported verbatim
(`CLAUDE.md`, `settings.json`, `skills/`). This repo's `.claude/` also
holds `agents/`, `tasks/` and `support_files/` from the component-build
era; they remain local rather than being added to the allow-list.
`.claude/CLAUDE.md` keeps this fork's project guide (component API,
build commands, the R-generator crash note) and appends the network
role & behavioral contract section verbatim — the template's copy of
that file documents the TEMPLATE's directives and customization
points, and porting it byte-for-byte would delete this repo's guide.

### 14. `scripts/smoke_live.py` — `post()` verifies certificates: RETIRED

*Retired 2026-08-26 — the template carries the fix. Left here rather
than deleted because the fleet records that credit this fork still
describe the divergence as live.*

This fork fixed `post()` to pass `context=SSL_CONTEXT` in `154688e`
after measuring the template-class defect against production
2026-08-24: the script reported 0/0 for both auth POSTs while `curl
-X POST` on the same machine, the same minute, got 401 and 200. On
any Python without OS trust-store integration (macOS — the fleet's
whole local-dev half) every auth POST died in the TLS handshake,
returned 0, and the check accused the app of the very
`configure_app(app)` regression it exists to detect.

The template absorbed it in 1.6.16 (`ceb0d50`, shipped as
`SYNC-1.6.10-1.6.16` item 7). Verified at template 1.6.27
(`055363e`): its `post()` now calls `urlopen(request,
timeout=TIMEOUT, context=SSL_CONTEXT)` under a comment naming this
fork's commit. **Nothing to defend in a sync any more.** One shape
difference remains and is sanctioned by the item itself: the
template's source pin lives in `tests/test_auth_wiring.py`, this
fork's in
`tests/test_smoke_live.py::test_post_verifies_certificates_the_same_way_fetch_does`
— the item's batch-1 correction (2026-08-25) records that home as
satisfying it, because the pin is not auth-specific.

## Byte-owned paths

Paths this fork owns byte-for-byte. The F3b fan-out never overwrites
a path listed here; everything else in the spec's `sync-verbatim`
block is the template's to update mechanically. Prose above explains
divergences; this block is the machine answer.

Repo-relative paths, one per line, `#` comments, no `..`; exactly one
block. An EMPTY block means "the template owns every sync-verbatim
path here" — present so the absence is a statement. When the block
exists it is authoritative; a fork without it gets the conservative
mention heuristic (over-flags, never restores).

Audited 2026-08-26 against every `sync-verbatim` path in the three
specs at template 1.6.27 (`055363e`) — the four kit files, plus
`.github/dependabot.yml` and `tests/test_auth_demos.py` from
1.6.22-1.6.27. The block is EMPTY, and that is a measurement:

- The four kit files are byte-identical to the template here (md5,
  2026-08-26) — the F3b fan-out already delivered them in PRs #4/#5.
  §13 names `skills/` only as the `.gitignore` allow-list's contents,
  which is the mention heuristic's false positive, not a byte claim.
- `.github/dependabot.yml` differs, and the difference is unsynced
  drift (1.6.24's pip removal), not divergence — see §11. Fencing it
  would freeze that drift in and route a mechanical item to a session
  forever.
- `tests/test_auth_demos.py` is the template's bytes, ported here
  2026-08-26; this fork's judgment lives in `lib/auth_demos.py`'s
  DEMOS table, which is not a `sync-verbatim` path.
- §13's byte claim on `.claude/CLAUDE.md`, and the host swap in
  `.claude/settings.json`, are real — but neither file is a
  `sync-verbatim` path (both are `# requires:` gates and explicitly
  session-class adapted halves), so neither belongs in this block.

```yaml byte-owned
```
