# Changelog

All notable changes to flexlayout-dash will be documented in this file.
("DashDock" was this project's original name; the `dash-dock-*` CSS classes it
left behind are still public API and are deliberately not renamed.)

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-08-01

_First PyPI upload since 1.0.0. The 1.1.0 section below was finalized on
2026-06-22 but never uploaded, so its changes — including the breaking
`dash_flex_layout` → `flexlayout_dash` import rename — reach PyPI for the
first time with this release._

### Added
- **The 2plot network standard, in full** (the satellite pass proven on
  2plot.ai, 2plot.dev, boilerplate.2plot.dev and leaflet.2plot.dev), landed
  together with this site's FIRST deploy to https://flexlayout.2plot.dev:
  - `.github/workflows/ci.yml` reshaped to the network baseline (CI on
    pull_request/workflow_call only — `main` is owned by the new `cd.yml`,
    which deploys via a Render hook, waits for SUSTAINED health, then runs
    the live battery) plus an actionlint gate, a zero-secret pytest job, and
    a docker build→fingerprint→boot→battery job. `release.yml` (tag-driven
    PyPI publish) is unchanged and independent.
  - `scripts/network_smoke.py` + `scripts/smoke_live.py` — the same named
    checks against the CI container and production, including the social
    card's REAL pixels on the CDN (IHDR vs the declared width/height).
  - `tests/` — 54-test secretless suite (site identity, social card +
    installable-app surfaces, internal-traffic contract, the in-process
    battery run, and package-level checks replacing the stale
    `test_app.py` that still imported the deleted root `app.py`).
  - **Internal-traffic contract**: the tracker drops `2plot-internal` UAs at
    WRITE time (before bot classification) and never stores `/healthz`;
    the ad fetch and the signed rollup POST send `internal_ua(...)` so the
    hub stops counting this satellite's machinery as its own bots.
  - **Ad-network app id converged to the short key `flexlayout`** (hub
    2.2.0 rule) — `lib/ad_client.py` defaulted to the legacy
    `flexlayout-dash` spelling.
  - `scripts/make_social_card.py` + the rendered 1200x630 card
    (`build/social-cards/flexlayout.2plot.dev.png`), served from
    cdn.2plot.ai — never from the app, whose cold starts would poison
    scraper caches.
- **`modelAction` prop — imperative FlexLayout actions on the LIVE model.** Dash callbacks can now add/remove/select/rename tabs and adjust weights at runtime without replacing the `model` prop (which is ignored under `useStateForModel=True` and re-mounts every tab otherwise). Shape: `{type, nonce, ...args}` with a changed `nonce` per action. Types: `addNode` (`{json, toNodeId, location?, index?, select?}`; re-adding an existing tab id selects it instead of throwing), `deleteTab`, `selectTab`, `renameTab`, `updateNodeAttributes`, `adjustWeights`. Actions apply via `model.doAction(Actions.*)`, so sibling tabs keep their DOM — no re-mounts. A `dfl.Tab` child whose tab isn't in the model is (as always) silently skipped, so keep dynamic-tab children in `children` permanently and let `addNode`/`deleteTab` control visibility. Motivated by a broadcast-monitoring app that opens an editor tab on demand.
- **Documentation site: `.env.example`** documenting every environment key the
  site reads (canonical base URL, ad network, satellite traffic reporting,
  analytics). `run.py` now calls `load_dotenv()` *before* the `lib/` imports —
  `lib/ad_client.py` reads its env at import time, so a later load was
  silently ignored — and `python-dotenv` joined the site's requirements.

### Changed
- **Packaging metadata moved from `setup.py` to `pyproject.toml`,** which is now
  the authoritative version. `MANIFEST.in` became a strict allowlist, so the
  documentation site, `scripts/`, `render.yaml` and the R/Julia backends can no
  longer leak into the PyPI artifact. Declared the real dependencies for the
  first time: `dash>=4.1,<5` and `typing_extensions>=4.0` — the latter is
  imported unconditionally by the generated wrappers and until now resolved only
  as a transitive dependency of Dash. Added `requires-python = ">=3.9"`,
  classifiers and project URLs, and the 1 MB react-docgen `metadata.json` is no
  longer shipped.
- **`LICENSE` now contains the MIT text.** It had been a 0-byte file while the
  package metadata claimed MIT.
- **Repository reorganised to the standard satellite layout.** The documentation
  site moved out of `documentation/` to the repo root (`run.py`, `docs/`,
  `pages/`, `lib/`, `components/`, `assets/`, `requirements.txt`),
  matching dash-email, dash-emoji-mart, dash-leaflet2 and the documentation
  boilerplate. Doc pages are now one folder per page — `docs/<slug>/<slug>.md`
  plus `docs/<slug>/example.py` — and the home page is `docs/home/` with
  `endpoint: "/"` rather than a hand-rolled `pages/home.py`. Nothing about the
  published package changed; `MANIFEST.in` prunes every one of those
  directories by name and `scripts/check_release.py` now asserts it does.
- **Documentation site: upgraded `dash-improve-my-llms` to 2.3.4** (the
  network standard — `resolve_site_title` is what gives the /llms.txt H1 and
  the llms viewer chip one identity source), and **replaced the 17 KB
  hand-rolled `templates/index.html` with a minimal one that declares ONLY
  what Dash omits**: og:site_name/og:url, the og:image:* auxiliaries, the
  manifest + apple-touch-icon + theme-color. The template was briefly deleted
  outright on the theory that the prerender covers OG — it does, but only on
  the crawler path, and social scrapers (`facebookexternalhit` etc.) take the
  browser path; `tests/test_social_card.py` now pins the template in place.
  The favicon set moved under `assets/favicon/`, whose `site.webmanifest`
  arrived naming the HUB and now names this site.
- **Documentation site: gunicorn floor raised to >=23** (21.x carried the
  request-smuggling CVEs CVE-2024-6827 / CVE-2024-1135). markdown2dash 0.1.2
  declares `gunicorn<22`, so it left `requirements.txt` and installs as a
  second `pip install --no-deps` command (Dockerfile, CI and
  `scripts/compat_matrix.py` all updated); CI fingerprints assert the dodge
  keeps working inside the shipped image.
- **README: added the 2plot.ai logo** above the header, and switched the image
  references to absolute `raw.githubusercontent.com` URLs — relative paths
  render on GitHub but appear broken on the PyPI project page.

### Fixed
- **Documentation site: invalid `<p>` nesting on every page with inline
  emphasis.** markdown2dash 0.1.2 renders `**bold**`, `*italic*` and
  `~~struck~~` as `dmc.Text`, which is a `<p>`, inside the paragraph's own
  `<p>` — React warned `validateDOMNesting(...): <p> cannot appear as a
  descendant of <p>` on `/`, `/basic`, `/callbacks` and `/getting-started`.
  `lib/renderer.py` subclasses the renderer to emit `<span>` (`dmc.Text`'s
  `span` prop) instead. Upstream bug, shared by every boilerplate-derived site.
- **Documentation site: the "Copy llms.txt URL" button was missing** from every
  page except the home page — the `.. llms_copy::` directive was registered but
  never used in the markdown.
- **Documentation site: the site title read "Dash" / "Home".** `Dash(title=...)`
  was never set, so the browser tab, `og:title`/`twitter:title` and the llms
  viewer's brand chip all showed Dash's default; and the root `/llms.txt` H1
  rendered `# Home` — the home page's navbar name — instead of the site name.
  The fix is the network identity standard: one
  `SITE_BRAND = "flexlayout-dash — resizable panel layouts for Dash"` in
  `lib/constants.py`, carried verbatim by `Dash(title=)`,
  `register_page_metadata(path="/", name=SITE_BRAND)` (2.2+ merges, so the
  home page's frontmatter llms_doc is untouched), the home markdown H1 and
  the webmanifest — resolved on every surface by 2.3.4's
  `resolve_site_title`, and pinned by `tests/test_site_identity.py`.
- **Documentation site: robots.txt now actually blocks AI-training crawlers.**
  `block_ai_training` was `False` while the comment above it claimed the
  opposite. Enabling it only became safe with dash-improve-my-llms 2.3.3, which
  separates training crawlers (GPTBot, ClaudeBot, CCBot — disallowed) from the
  user-triggered and search fetchers (Claude-User, Claude-SearchBot,
  ChatGPT-User, OAI-SearchBot — still allowed).

### Removed
- **No free/premium split.** There is no tab limit, licence-key check or paid
  edition anywhere in the package or the compiled bundle — verified for 1.2.0
  across `flexlayout_dash/`, `src/` and `flexlayout_dash.min.js`. Releases up to
  1.0.0 were described on PyPI as a free build "limited to 3 tabs" alongside a
  premium one; this release's description supersedes that.
- **The generated R and Julia bindings** (`R/`, `man/`, `inst/`,
  `deps/`, `DESCRIPTION`, `NAMESPACE`, `Project.toml`, `src/jl/`), and
  `--r-prefix`/`--jl-prefix` dropped from `npm run build:backends`, which is
  what regenerated them. No other component in the network ships them.
- The unused webpack dev harness (`webpack.serve.config.js`,
  `src/demo/`, `npm start`, the stale root `index.html`), a stray root
  `__init__.py` still wired to the pre-1.1.0 `dash_flex_layout.min.js`, and the
  boilerplate `_validate_init.py` / `review_checklist.md`.

## [1.1.0] - 2026-06-22

### Fixed
- **Eliminated unnecessary tab-content re-mounts on internal FlexLayout model changes.** With `useStateForModel=False`, every `onModelChange` round-trip recreated the `Model` via `Model.fromJson`, re-running the factory and re-mounting all portaled tab content. Now model-prop echoes of FlexLayout's own internal changes are skipped; only a genuinely Dash-originated model recreates the Model. Fixes content flashing/resetting and re-mount storms for stateful tab children (canvases, editors, drag state, etc.). `setProps` still fires on every change, so downstream `Input(component, 'model')` callbacks are unaffected.
- **Dock no longer escapes its container.** `.dash-dock-container` is now `position: relative`, so FlexLayout's absolutely-positioned layout stays inside the component's own box instead of overflowing to the nearest positioned ancestor (e.g. rendering behind a fixed `AppShell` navbar/sidebar). Consumers only need to give the component an explicit height via its `style` prop.

### Changed
- **Unified the Python import name under `flexlayout_dash`.** Previously the package installed/bundled as `flexlayout-dash` (`flexlayout_dash.min.js`, `window.flexlayout_dash`) but its Python import package and backend were still `dash_flex_layout`. The import name is now `flexlayout_dash` everywhere — consistent with the bundle and the npm/webpack library name.
  - **BREAKING:** code that did `import dash_flex_layout` must change to `import flexlayout_dash`. The PyPI distribution name is unchanged — you still `pip install flexlayout-dash`.
  - Regenerated the Python/R/Julia backends and updated `setup.py`, `MANIFEST.in`, the build (`build:backends`), and webpack config to the `flexlayout_dash` namespace; removed the stale `dash_flex_layout/` package directory.

## [0.0.2] - 2026-01-04

### Fixed
- **Tab content vanishing bug**: Resolved critical issue where tab content would disappear after Dash callbacks updated component props. The root cause was FlexLayout's internal caching of React elements with original props, which conflicted with Dash's callback-based prop updates.

### Changed
- **Rendering architecture**: Implemented portal-based rendering to decouple Dash's component lifecycle from FlexLayout's mounting/unmounting behavior. The factory function now creates empty container elements, and actual content is rendered via React portals into these containers.
- **Removed API key validation**: DashDock is now completely free with all features unlocked. Removed `apiKey`, `apiUrl`, and `freeTabLimit` props.
- **Removed premium/free tier system**: Deleted `apiClient.ts` and `tabAnalyzer.ts` utility files. All FlexLayout features are now available without restrictions.

### Added
- `TabPortalContainer` component for managing portal target registration
- Technical documentation in `.claude/flexlayout-rendering.md` explaining the rendering architecture and callback patterns
- **Apple Liquid Glass Theme**: WWDC 2025-inspired glassmorphism theme with light and dark variants
  - `dash-dock-liquid-glass-light` and `dash-dock-liquid-glass-dark` CSS classes
  - Backdrop blur with `blur(16px) saturate(180%)` effect
  - Transparent rgba backgrounds (never opacity)
  - Layered box shadows (outer depth + inner glow)
  - Specular highlight gradients (135deg)
  - Accessibility: high contrast mode, reduced motion, focus states
- **Interactive Theme Control Panel** (`pages/theming.py`):
  - Live theme selector (Light, Dark, Glass Light, Glass Dark)
  - Component props controls (useStateForModel, supportsPopout, realtimeResize, debugMode)
  - Model options controls (tabEnableClose, tabEnableFloat, splitterSize, etc.)
  - Splitter color customization with live preview
  - CSS documentation and props reference tables

### Technical Details

#### Portal-Based Rendering Solution

The previous direct rendering approach failed because:
1. FlexLayout calls `factory()` once and caches the returned React element
2. When Dash callbacks update props, React updates the rendered DOM
3. When FlexLayout remounts a tab, it uses the cached element with original props

The new portal-based approach:
1. Factory returns empty `TabPortalContainer` components
2. Containers register themselves in a ref map when mounted
3. Dash children are rendered via `ReactDOM.createPortal()` into these containers
4. Portal content is managed by React's reconciliation, not FlexLayout

#### Recommended Model Configuration

For reliable callback behavior, set `tabEnableRenderOnDemand: false` in your model:

```python
model = {
    "global": {
        "tabEnableRenderOnDemand": False,  # Keep all tabs mounted
        "tabEnableClose": False,
        "tabEnableFloat": True,
    },
    # ...
}
```

#### Callback Best Practices

1. **Static structure**: Define all possible components in layout, control visibility via style props
2. **Prop updates**: Update component data/style props instead of replacing children
3. **State stores**: Use `dcc.Store` to manage shared state across tabs

See `.claude/flexlayout-rendering.md` for detailed documentation.

## [0.0.1] - 2026-01-04

### Added
- Initial release of DashDock component
- FlexLayout-React integration for dockable, resizable, and floatable panels
- Drag-and-drop tab management
- Maximize, close, and pop-out tab capabilities
- Mantine theme integration (light/dark mode)
- Dash 2 and Dash 3 compatibility
- `DashDock` main component with model-based configuration
- `Tab` wrapper component for content
- Multi-page example application with:
  - Basic usage examples
  - Advanced layout configurations
  - Theme integration demos
  - Callback interactivity examples
- Comprehensive documentation in `.claude/` folder