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

Correction, 2026-08-26 (morning): this entry previously ended "The
pip allow-list and the docker/actions ecosystems match the
template." That stopped being true when template 1.6.24 removed the
pip ecosystem outright (floors move through sync specs, not
floor-raise PRs) and this fork had not yet consumed that file. The
gap was UNSYNCED DRIFT, not divergence — which is precisely why the
file was left OUT of the byte-owned fence.

CLOSED, 2026-08-26 (evening): the F3b fan-out delivered it —
`8d2cc01` (PR #7, the 1.6.22-1.6.29 verbatim block). `md5`
`.github/dependabot.yml` now equals the template's at `5589318`.
The mechanical route worked exactly as the fence's reasoning
predicted: had this file been fenced that morning to "protect" a
difference this fork never chose, the fan-out would have skipped it
and the drift would have needed a session. It needed none.

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

### 15. `scripts/smoke_live.py` — this fork's copy is a SUPERSET

A byte claim, and the reason the fence below is no longer empty.

Both files descend from the same template ancestor, and the template
has since gained three things this fork lacked — the cold-start wake
loop, `fetch`'s retry ladder, and the 3c crawler/browser identity
parity block. All three were ported here by hand on 2026-08-26
(SYNC-1.6.22-1.6.29 items 5-6 §B/§D round), which is the whole of
item 6's contract.

What must NOT happen is the reverse direction. Measured at template
1.6.29 (`5589318`), this fork's copy carries six check blocks the
template's does not:

| block | what it proves |
|---|---|
| `/healthz` names the running build | which COMMIT answered — cd.yml's build-match reads this |
| `/healthz` claims this app's identity | `app == "flexlayout"`, not the template's key |
| `/healthz` carries the geo diagnostic | the dimll >=2.7.0 floor really moved (the Docker layer-cache trap) |
| prerender, browser lane | present / VISIBLE / per-page / exactly one h1 — the lane a curl cannot see |
| `/api/agent-key` closed to anonymous | 204 and empty, or this host mints authority for strangers |
| machine surfaces stay open | the llms.txt family answers an anonymous agent with prose during the crawl-demand window |

Each was added by a session on THIS fork, for a defect measured on
THIS host. A byte-copy of the template's file deletes all six
silently and leaves a green CD run saying nothing is wrong — the
worst possible failure shape, and the exact class item 5 exists to
kill (a declaration nothing holds to reality).

So the path is fenced. The fence is not a refusal to sync: item 6 is
`contract` class as of 1.6.29 precisely because this file's
behaviour, not its bytes, is what the fleet standardises. The port
above is that contract, discharged by hand and pinned by
`tests/test_smoke_live.py` (21 tests, including the template's
transport ladder and wake-loop reference tests, adapted).

### 16. Render deploys `release`; only CD writes it (item 13, 2026-08-29)

Render's Blueprint `branch:` is `release`, not `main`, and `cd.yml`'s
`deploy` job is the only writer — a fast-forward push of the run's own
commit, gated on `needs: [test]`, after `actions/checkout@v4` with
`fetch-depth: 0` (a shallow clone pushed onto an existing `release` is
rejected as non-fast-forward). A push to `main` is therefore a
*candidate*, not a deploy: nothing serves it until CI is green and the
promote step runs. `verify` runs ONLY on `needs.deploy.result ==
'success'` and its first step re-asserts `/healthz` build == this run's
sha before running the battery — a verify that passes against a build
nothing this run shipped must not exist.

The old shape POSTed to a Render deploy hook (`RENDER_DEPLOY_HOOK_URL`,
left unset fleet-wide) and let Render's `autoDeploy` watch `main`
directly. That means Render could build a commit CI was still judging —
the class of failure item 13 closes. The secret name is deliberately not
spelled out in `cd.yml`'s prose (item 13's own detect greps the file for
it); the repo secret itself is inert now and safe to delete.

`build == HEAD` on `/healthz` means HEAD of `origin/release`, never
`origin/main` — see the `.claude/CLAUDE.md` trap. `main` ahead of
`release` is an uncertified push pending, never drift, never a reason to
deploy by hand or write to `release` directly.

OWNER STEP, not done by this session: if the Render service is not
Blueprint-managed, `render.yaml`'s `branch:` is documentation only and
the dashboard's Branch field is the actual switch — the owner flips it
after the promote step is proven green on the wire.

### 17. Navigation contract (item 16, 2026-08-30) — this fork's identity choices

`components/navbar.py`, `components/footer.py`, `lib/aside.py`,
`lib/api_reference.py`, `pages/changelog.py` and `pages/api.py` are now
the template's generic, registry-driven shape — no fork content,
cargo-eligible on the next mechanical round. NOT byte-identical to the
template at commit `8ceca5c` — diffed and confirmed the gap is comment
wording only ("item 16" vs "1.6.39", one kept docstring note on
navbar.py's DMC-floor comment) plus, in `pages/api.py`, a module
docstring that correctly names THIS fork's own `API_PACKAGES` declaration
instead of the template's "the template documents nothing" placeholder
text — code bodies match. `components/header.py` and
`components/appshell.py` differ more, where this fork's own identity or
Flask-only shape requires it, noted below. The fork's own choices live in
`lib/constants.py`'s navigation block and in these adaptations:

- **Backend badge, Flask-only.** DIVERGENCES §2: this fork has no
  `lib/backend.py` and no pluggable backend at all — Flask is hardcoded
  in `run.py`. `components/header.py::create_backend_badge()` is a
  static "Flask" badge rather than an import from a `lib.backend` module
  this fork does not carry; there is nothing to detect.
- **`/reference` and `/api` coexist, deliberately.** `docs/reference/reference.md`
  is hand-written narrative (the model schema, usage guidance) that
  embeds `.. kwargs::` prop tables inline; `/api` is the auto-generated
  raw prop dump from `flexlayout_dash/metadata.json`. `/api` supplements
  `/reference`, it does not replace it — both stay registered, and both
  are in the sidebar (Reference under its own category, API in its own
  section). `API_PACKAGES = ["flexlayout_dash"]`, this fork's own
  package.
- **The header keeps a PyPI icon link** alongside the contract's GitHub
  icon — not in the contract list, kept because this IS a PyPI-published
  package and the docs site's whole purpose is documenting it. No test
  forbids it; `tests/test_nav_contract.py` only pins the contract's
  MINIMUM surface.
- **`lib/renderer.py`'s bold/italic `<p>`-nesting fix stays**, unreplaced
  by `markdown2dash.create_parser`: `pages/markdown.py` still builds its
  parser from `lib.renderer.create_parser` (the fork-local
  `PatchedDashRenderer` subclass), and `lib/directives/headings.py`'s
  `patch_renderer()` monkeypatches `DashRenderer.heading`/`image` on the
  BASE class before that subclass is instantiated — since the subclass
  overrides neither method, it inherits both patches. Two fixes, one
  parser, verified in `pages/markdown.py`'s docstring.
- **The H1-preamble guard (§5) is untouched.** The template's own
  `pages/markdown.py` at 1.6.38 drops the fence-aware `_first_heading_level`
  guard entirely and always prepends `# {name}` to the LLMS_DOC — which
  would reintroduce the duplicate-H1 defect §5 exists to prevent on
  `docs/home/home.md`. Not ported; this fork's guard stays.
- **`DISCORD_URL`/`YOUTUBE_URL` moved to the network-wide values**
  (`discord.gg/e5s5uHWUHH`, `youtube.com/@2plotai`) from this fork's
  previous vanity Discord invite and personal YouTube channel — the
  owner's 2026-08-30 decision, not a per-fork choice.

### 18. `robots.txt` carries one `Disallow` line under `User-agent: *` — deliberate, not drift

Verified live 2026-08-30 (post item-15 flip): `flexlayout.2plot.dev/robots.txt`
reads `User-agent: *` / `Allow: /` / `Disallow: /admin/`, with no other
`Disallow` anywhere. This fork is the only flipped fork carrying any
`Disallow` line, which is a fact about THIS fork's admin surface, not
fleet drift — it does not conflict with item 15's "no blanket Disallow"
pins (`tests/test_llms_routes.py::test_robots_artifact_fingerprint`,
`scripts/smoke_live.py`, `scripts/network_smoke.py`), which check for a
blanket `Disallow: /` line specifically and treat `Disallow: /admin/`
as expected.

Set explicitly in `run.py`'s `RobotsConfig(..., disallowed_paths=["/admin/"])`
call (`run.py:297`), not a `dash-improve-my-llms` default — the package
ships no default `disallowed_paths`. The comment immediately above that
line (`run.py:287-296`) explains why: `mark_hidden("/admin/control-board")`
already keeps the control board out of the sitemap, the MCP resource set
and the prerender, and 404s a crawler-lane request — but measured against
dimll 2.6.1, `mark_hidden` alone does NOT write a robots rule, so this is
the missing half, added deliberately. Gated documentation pages (a
different axis — who may READ a page) stay listed in robots and the
sitemap by network policy; only the ADMIN surface is disallowed here.

### 19. Item 18 (the 1.6.41 remainder) — a real defect found from inside, a scope cut, a deferral

Item 18 ported the nineteen 1.6.41 files the 16+17 round hadn't carried.
Two things this session found that the item text didn't name, one scope
cut, and one deferral — all worth a session reading this fork later
knowing about:

- **The 4th empty-machine-lane mechanism, found on THIS fork's own
  content.** `docs/reference/reference.md`'s two `.. kwargs::` directives
  (13 props on DashFlexLayout, 2 on Tab) rendered a full prop table in
  the browser and were COMPLETELY ABSENT from `/reference/llms.txt` and
  the crawler HTML — `### DashFlexLayout` ran straight into `### Tab`
  with nothing between them. Not named in item 18's own text (which
  described the mechanism generically via muicharts' /api case); this
  fork's instance is on its documentation page, not /api. Fixed:
  `lib/directives/kwargs.py` now exposes `resolve_kwargs()` — the ONE
  parse both the browser's `Kwargs` directive and a new fence-aware
  `pages/markdown.py::_expand_kwargs_directives` call — so a spec can
  never resolve to one table in the browser and a different (or empty)
  one in `/<page>/llms.txt`. Pinned by `tests/test_kwargs_machine_lane.py`
  with a mutation check (disable `resolve_kwargs`, confirm the machine
  lane actually goes empty) per the item's own test lesson.
- **The VUNRELEASED badge, item 18's acceptance bar, not "leave it".**
  An earlier drop said the badge bug was "note 67, template-side — leave
  it" — true for the TEMPLATE's own /changelog, but this fork's
  `CHANGELOG.md` opens with `## [Unreleased]`, which item 18's own
  acceptance line ("/changelog badges read correctly on your changelog's
  own shape") explicitly covers. Ported the `_is_version`/label fix;
  verified `vUnreleased` no longer appears.
- **Rollup v4's "v3-agnostic" restructuring (`ROLLUP_V4_MODULE`,
  `tests/fixtures/rollup_pre_v3.py`) was NOT ported.** That work targets
  forks with no v3 rollup at all (clerkhook). This fork's
  `lib/traffic_rollup.py` has full v3 (items 12's own work), and
  `tests/test_traffic_rollup_v4.py` from that round already tests it
  correctly against this tree — not-applicable-because, not skipped.
- **Deferred, not ported:** `scripts/smoke_live.py`'s auth-wiring POST
  check and GitHub-repo-link-resolves check, and cd.yml's "fail fast on
  supersession" `gh api compare` logic in the build-match wait. All
  three are real, valuable additions from the 1.6.41 file set, but none
  are named in item 18's own acceptance bar (the four pins + /api
  lastmod + /changelog badges), and none could be verified against a
  live run in this session. Left as `open` — a future session should
  port and verify them against an actual CD run rather than trust an
  unexercised diff.

**Amendment (2026-08-31, boilerplate seat's post-report correction),
applied same day:**

- **The /api lastmod was a fabricated date.** The first pass wrote
  `date.today()` — "the day I ran the builder" — exactly the class
  muicharts shipped and caught live within minutes: a sitemap asserting
  a content date that is not one. Fixed the SHAPE, not just the value:
  `scripts/build_api_metadata.py::changelog_date_for_version()` derives
  `generated` from CHANGELOG.md's dated entry for the INSTALLED
  package's own `__version__` (2.0.0 → 2026-08-02, CHANGELOG.md's own
  release date, not 2026-08-31 when this script happened to run), and
  REFUSES to write today's date when no dated entry exists rather than
  inventing one. Pinned by
  `tests/test_seo_icons.py::test_api_lastmod_is_the_changelog_date_not_the_day_the_builder_ran`,
  which derives the expected date independently (not by re-reading the
  same file the builder wrote) so a version bump that forgets to
  regenerate the extract goes red.
- **The exec-lane defect (mechanism 4's OTHER directive) — found on this
  fork's own docs, seventh instance network-wide of the kwargs case,
  first of the exec case.** All SIX of this fork's `.. exec::` directives
  (one per topic doc, rendering each page's live component demo)
  reached the browser fully and were COMPLETELY ABSENT from every
  page's `/<page>/llms.txt` — `/basic/llms.txt` measured 1256 bytes
  before the fix, ran "...maximize a tabset..." straight into
  "### Notes" with the entire example source gone; 3266 bytes after.
  Fixed with the three-step precedence (dedupe on a paired
  `.. source::`, honour `:code: false` as a visible marker, else
  expand) in `pages/markdown.py::_expand_exec_directives`, sharing the
  same fence-aware pattern `_expand_source_directives` uses. PIPELINE
  ORDER MATTERS and was wrong on the first pass: exec must expand
  BEFORE source (`_expand_source_directives(_expand_exec_directives(content))`)
  because exec's dedupe scan looks for raw `.. source::` lines in the
  text it receives — source-first would have already turned every
  `.. source::` line into a fenced block, and the scan would dedupe
  against nothing, silently doubling every hand-paired page's source.
  Measured across this fork's own docs: 0 of 6 directives dedupe or
  flag, so all six expand. Pinned by `tests/test_exec_lane.py` (9
  tests: unit fixtures for all three precedence branches plus fence-
  awareness and a missing-target error, a live sweep of every real
  `.. exec::` in docs/, and a mutation check).
- **Three test-pin precision fixes**, all corrections to pins this
  fork's own item 18 pass had already shipped as "done":
  - `test_every_test_client_user_names_headers` checked for the bare
    substring `"headers="` anywhere in a file, which a
    `headers={"CF-IPCountry": "FR"}` call (tests/test_llms_routes.py,
    naming no lane at all) satisfied vacuously. Now checks specifically
    for `User-Agent`/`HTTP_USER_AGENT`/`user_agent=`; named UAs added
    to the two calls that were actually bare.
  - `test_battery_hidden_paths_match_the_registry` used strict equality
    between `HIDDEN_DOC_PATHS` and the registry's admin pages — which
    would delete a legitimately hidden non-admin canary the day one is
    ever added. Now subset-plus-reality-check: every registered admin
    page must be listed (unchanged), and anything EXTRA in the tuple
    must be verified 404 on the crawler lane rather than assumed.
  - `test_a_docs_page_really_carries_its_parsed_content`'s positive
    control resolved its target page via `lib.aside.ASIDE_PATHS` — a
    side effect of a page carrying `.. toc::`, which would silently
    retarget the test the day a page loses that directive for
    unrelated reasons. Now selects directly from the registry: the
    first page (by path) carrying a `category`, this fork's own marker
    for "a real topic doc".
  - `test_admin_paths_absent_from_sitemap_llms_and_sidebar` swept only
    `/llms.txt` and sitemap.xml. Extended to also sweep `/llms-small.txt`
    and `/llms-full.txt` (both LINK-shaped checks, matching the root
    index's own `(path)` / `path/llms.txt` pattern, with a positive
    control proving the tier docs actually link real content) — no
    leak found on this fork, but the surfaces are now covered.

### 20. SYNC-1.6.43 item 1 — the version check is a RANGE here, never a pair

The spec offers two shapes for proving the read-table drop keys on the
right field name. The pair ("compare your CI version against
production") is **not available on this fork and never will be**:
divergence 4 records that this host's `/healthz` payload carries the
APP's `version`, and it carries no `llms_version` — there is no wire
surface anywhere on flexlayout.2plot.dev that names the resolved
`dash-improve-my-llms` version. `grep -rn llms_version lib/ tests/`
returns nothing, and that is deliberate, not an oversight.

So the pinned check is the range the spec calls "strictly stronger and
dashboard-free": across EVERY wheel the floor `>=2.8.0` admits, `ua` is
in `EVENT_FIELDS` and `user_agent` is not. Measured 2026-09-04 by
IMPORTING each wheel (not parsing it), package file count taken before
the import so `__pycache__` cannot inflate it:

| version | files (whole wheel) | n  | `ua` | `user_agent` | `vendor_class` |
|---------|--------------------|----|------|--------------|----------------|
| 2.8.0   | 45                 | 15 | yes  | no           | no             |
| 2.9.0   | 45                 | 15 | yes  | no           | no             |
| 2.9.1   | 46                 | 15 | yes  | no           | no             |
| 2.9.2   | 46                 | 16 | yes  | no           | yes            |
| 2.9.4   | 46                 | 16 | yes  | no           | yes            |
| 2.10.0  | 47                 | 16 | yes  | no           | yes            |

`tests/test_internal_traffic.py::test_the_event_field_is_ua_across_every_wheel_the_floor_admits`
pins the invariant against whichever wheel is resolved at run time.

A sync must NOT "restore" a CI-vs-production pair assertion here. It
would have nothing to read on the production side and would either skip
silently or pin a constant — both worse than the range.

The floor stays `>=2.8.0` this round, deliberately: a `>=` floor cannot
pull a newer wheel through a cached Docker layer, and the requirements
line changing IS the cache bust. Not busting it as a side effect of
this port is the point.

### 21. SYNC-1.6.44 item 2 — no HeadAsGetMiddleware to retire, and none needed

The item asks every fork to retire `lib/asgi_middleware.HeadAsGetMiddleware`
or record what it still covers. **There is nothing to retire here**:
divergence 2 records that the ASGI half of the template is absent, and
`lib/asgi_middleware.py` does not exist on this fork. Flask answers HEAD by
running the GET view and discarding the body, so the shim's job is done by
the framework.

Recorded rather than skipped, because "the file is absent" and "the
behaviour is absent" are different claims and only the second one matters.
Item 2's acceptance run, against production at 06cc418's parent, GET vs HEAD
compared on status, content-type and the Link headers:

  /healthz /llms.txt /robots.txt /sitemap.xml /  x  browser / crawler / cli
  **15/15 pairs matched**, `/` to a browser UA included.

Same result the template reports WITHOUT the middleware. `head_get_parity_three_uas`
in `scripts/network_smoke.py` (item 5) is where this is re-measured every run;
this entry is why no shim is expected to be there.

Related, and worth keeping beside it: the ops seat reported `HEAD /` on this
host timing out at 25 s / 0 bytes twice on 2026-09-03. Not reproduced from
this seat in fifteen further probes across three sessions (0.17-0.38 s, all
200). The two seats reach the origin by different paths, so this is recorded
as unexplained rather than resolved.

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

Re-audited 2026-08-26 (evening) against template 1.6.29 (`5589318`)
after the F3b fan-out landed `8d2cc01`. The four kit files and
`.github/dependabot.yml` and `tests/test_auth_demos.py` are all
byte-identical to the template again (md5) — the block stayed empty
through a whole mechanical round, which is the measurement working.

ONE entry is added, and it is the first real one:

- `scripts/smoke_live.py` — §15. It rode the `sync-verbatim` block
  for exactly one round (1.6.28) and was pulled back out at 1.6.29
  after landing red on 7 of 12 forks; this fork never received the
  copy, because PR #7 arrived carrying the 1.6.29 block. That is
  luck, not protection. This fork's copy is a documented SUPERSET —
  six check blocks the template's file does not have — so a future
  round that made the file cargo again would silently delete them.
  The behaviour half of the same file IS synced: item 6's wake loop,
  retry ladder and SSL context were all ported by hand in the same
  touch as this entry.

```yaml byte-owned
# See §15. Superset, not drift: the behaviour contract (item 6) is
# ported by hand every round; the six fork-owned check blocks are
# what this line protects.
- scripts/smoke_live.py
```

## What this host serves

Declares posture facts a sync session should check against, not
restate from memory (sync/README.md's second fence). Empty for now —
`tests/test_claude_kit.py`'s kit copy (landed by PR #8's 1.6.22-1.6.33
fan-out) validates `_POSTURE_KEYS = {ai_bots, healthz, runtime}` only,
so a `deploy` key here would either fail that pin or, per its own
comment, "be read by nobody" even if the pin were loosened — the hub
side does not know the key yet either. Item 13's `deploy:
release-branch` fact is recorded in prose instead, in §16 above and in
the `.claude/CLAUDE.md` trap for the `build == HEAD` reading it
implies; add it to this fence once the kit's `_POSTURE_KEYS` catches
up (a future fan-out, or a session's own kit-test port).

`ai_bots` and `healthz` are WIRE facts (a real vendor UA against the
live host), and this key is for what the host actually SERVES, not
what its code intends — so it stays empty until measured there, never
filled from in-process behavior. Item 15's posture flip
(`block_ai_training=False` in `run.py`, not a recorded divergence —
this fork is adopting the template's own new default, not diverging
from it) is verified in-process only as of this touch: `GET /`,
`/llms.txt`, `/healthz` with GPTBot and ClaudeBot UAs all answered 200
against the local app (2026-08-30, pre-deploy — this host's production
still runs the OLD `block_ai_training=True` build until this work
pushes and deploys). A `/wire-verify` pass after that deploy should
paste the six live lines here and populate this fence for real.

```yaml posture
```
