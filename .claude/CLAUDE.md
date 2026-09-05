# Claude Code Project Guide - flexlayout-dash

## Project Overview

**flexlayout-dash** is a Dash component library that wraps [FlexLayout-React](https://github.com/caplin/FlexLayout) to provide IDE-like dockable, resizable, and floatable windows for Plotly Dash applications.

- **PyPI distribution:** `flexlayout-dash` (`pip install flexlayout-dash`)
- **Python import name:** `flexlayout_dash` (unified with the distribution as of 1.1.0; older code used `dash_flex_layout`)
- **Component classes:** `DashFlexLayout` (main) and `Tab`
- **Note:** "DashDock" is the deprecated original product name. The CSS classes `dash-dock-container` / `dash-dock-light` / `dash-dock-dark` are still emitted by the component and must NOT be renamed.

### Key Features
- Dockable, resizable, and floatable window panels
- Drag-and-drop tab management
- Maximize, close, and pop-out tab capabilities
- Unlimited tabs - completely free and open source
- Seamless Mantine theme integration (light/dark mode)
- Dash 3 and Dash 4 compatibility
- Portal-based rendering for reliable callback support

---

## Technology Stack

### Core Framework
- **Python 3.7+** - Required runtime
- **Dash 4.2+** - Primary web framework (also runs on Dash 3.x)
- **React 18.3.1** - Frontend UI library

### UI Components
- **Dash Mantine Components (DMC) 2.0+** - Theme integration
- **Dash Iconify** - Icon library for tab headers
- **FlexLayout-React 0.8.3** - Core docking layout engine

### Build Tools
- **TypeScript 5.0+** - Type-safe React development
- **Webpack 5.84+** - JavaScript bundling
- **Babel 7.22+** - JavaScript transpilation

---

## Project Structure

```
dash-flex-layout/
├── src/lib/                    # React/TypeScript source
│   ├── components/             # React components (DashFlexLayout.tsx, Tab.tsx)
│   ├── styles/                 # CSS styling (theme.css)
│   ├── utils/                  # Utility functions
│   │   ├── dash3.ts            # Dash 2/3 compatibility
│   │   └── theme.ts            # Mantine theme integration
│   └── types/                  # TypeScript definitions
├── flexlayout_dash/            # Generated Python package
│   ├── DashFlexLayout.py       # Auto-generated component class
│   ├── Tab.py                  # Tab wrapper component
│   ├── __init__.py             # Package initialization (see build note below)
│   └── flexlayout_dash.min.js  # Bundled JavaScript
│
│   # The documentation site lives at the REPO ROOT — the standard
│   # *.2plot.dev satellite layout, same as dash-email / emoji_mart /
│   # dash-leaflet2 / dash-documentation-boilerplate.
├── run.py                      # Docs site entry point  (python run.py → :8055)
├── docs/<slug>/<slug>.md       # One folder per page: markdown + example.py
├── pages/markdown.py           # Walks docs/ and registers each page
├── components/                 # App shell, header, navbar
├── lib/                        # Docs constants, directives, 2plot network clients
├── templates/index.html        # Minimal Dash index — declares ONLY what Dash
│                               # omits (og auxiliaries, manifest, icons). Do
│                               # NOT delete: social scrapers never take the
│                               # prerender path. tests/test_social_card.py pins it.
├── assets/                     # Docs site static assets (served; favicon set in assets/favicon/)
├── github_assets/              # README images (NOT served)
├── requirements.txt            # The DOCS SITE's deps (not the package's)
│
├── tests/                      # Test files
├── scripts/                    # smoke_test, check_release, compat_matrix
├── package.json                # NPM dependencies / build scripts
├── pyproject.toml              # Python package metadata (authoritative version)
├── MANIFEST.in                 # Allowlist — keeps the docs site out of the wheel
├── Dockerfile / render.yaml    # Deployment to flexlayout.2plot.dev
├── webpack.config.js           # Build configuration
└── .claude/                    # Claude Code configuration
```

> There is no `documentation/` subdirectory and no `setup.py` any more (both
> removed 2026-07-31), and no R/Julia backends — `build:backends` no longer
> passes `--r-prefix`/`--jl-prefix`, matching the rest of the fleet.

---

## Quick Start

```bash
# Install build/dev dependencies (two pip commands ON PURPOSE — markdown2dash
# pins gunicorn<22 against the CVE-driven >=23 floor, so it installs --no-deps;
# its real deps are named in requirements.txt)
pip install -r requirements.txt
pip install --no-deps markdown2dash==0.1.2
npm install

# Build the component (webpack JS bundle + dash-generate-components backends)
npm run build

# Run the documentation site (needs Python 3.10+; the package needs only 3.9+)
python run.py     # http://localhost:8055
```

> **Build note:** `npm run build` runs webpack (→ `flexlayout_dash/flexlayout_dash.min.js`) then
> `dash-generate-components`. `flexlayout_dash/__init__.py` is **hand-maintained** — never delete
> it. If it is ABSENT, dash's R-package generator dies with a `TypeError` in `generate_js_metadata`
> after writing the Python components but before writing `__init__.py`, leaving the package
> unimportable; with the file present the generator completes cleanly (verified 2026-07-29).
> It must set `package_name = 'flexlayout_dash'` and register `flexlayout_dash.min.js` in
> `_js_dist`; `scripts/check_release.py` asserts both.

---

## Component Reference

### DashFlexLayout (Main Component)

```python
import flexlayout_dash as dfl

dfl.DashFlexLayout(
    id='dock-layout',
    model={...},              # FlexLayout JSON model
    children=[...],           # List of Tab components
    headers={...},            # Custom tab headers (optional)
    useStateForModel=True,    # Use internal state management
    debugMode=False,          # Enable debug logging
    colorScheme='light',      # 'light' or 'dark' (auto-detected if omitted)
    supportsPopout=False,     # Enable pop-out windows
    style={"height": "500px"},   # REQUIRED — set an explicit height (see below)
)
```

### Tab (Content Wrapper)

```python
dfl.Tab(
    id='my-tab',              # Must match tab ID in model
    children=[...]            # Content to render in tab
)
```

### Model Structure

```python
model = {
    "global": {
        "tabEnableClose": False,
        "tabEnableFloat": True,
    },
    "borders": [
        {"type": "border", "location": "left|right|bottom", "children": [...]}
    ],
    "layout": {
        "type": "row|column|tabset",
        "weight": 100,
        "children": [
            {"type": "tab", "name": "Tab Name", "id": "tab-id"}
        ]
    }
}
```

---

## Resources

- **FlexLayout-React Docs**: https://github.com/caplin/FlexLayout
- **PyPI**: https://pypi.org/project/flexlayout-dash/
- **DMC Documentation**: https://www.dash-mantine-components.com
- **DMC LLM Reference**: https://www.dash-mantine-components.com/assets/llms.txt
- **Dash Documentation**: https://dash.plotly.com
- **Dash Component Boilerplate**: https://github.com/plotly/dash-component-boilerplate

---

## Agent Reference

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `component-developer` | React/TypeScript | React component changes, TypeScript |
| `layout-specialist` | FlexLayout | Layout configuration, panel arrangement |
| `dash-integration` | Python/Dash | Python API, callbacks, Dash patterns |
| `theme-specialist` | CSS/Mantine | Theming, styling, dark mode |

See `.claude/agents/` for full agent configurations.

---

## DMC Layout Integration

flexlayout-dash integrates with the Dash Mantine Components (DMC) layout system. Understanding DMC layouts is essential for building proper applications.

### AppShell (Primary Layout)

Use `dmc.AppShell` for full application layouts with flexlayout-dash:

```python
import dash_mantine_components as dmc

app.layout = dmc.MantineProvider(
    dmc.AppShell(
        [
            dmc.AppShellHeader(
                dmc.Group([...], h="100%", px="md")  # Navigation
            ),
            dmc.AppShellMain(
                dmc.ScrollArea(
                    page_container,
                    h="calc(100vh - 60px)",  # Account for header
                    type="auto"
                )
            ),
        ],
        header={"height": 60},
        padding="md",
    )
)
```

### Container (Page Wrapper)

Wrap page content in `dmc.Container` for consistent width and centering:

```python
layout = dmc.Container([
    dmc.Stack([
        dmc.Title("Page Title", order=1),
        dmc.Paper([
            dfl.DashFlexLayout(
                ...,
                style={"height": "400px"},  # explicit height required (see below)
            )
        ], p="lg", withBorder=True, radius="md")
    ], gap="xl")
], size="lg", py="xl")
```

### flexlayout-dash Height Requirement

**IMPORTANT:** Give the component an explicit **height** via its `style` prop, set on the
component itself (its `style` is applied to `.dash-dock-container`). FlexLayout-React renders its
layout with `position: absolute`; as of the 1.1.0 build `.dash-dock-container` is
`position: relative` (in `src/lib/styles/theme.css`), so the layout is contained within the
component's own box.

```python
# ✓ Correct — height on the component itself
dfl.DashFlexLayout(
    ...,
    style={"height": "500px"},
)

# ✗ Wrong — height on an outer wrapper. The container has overflow:hidden and no
#    height of its own, so it collapses and the dock doesn't render properly.
html.Div(dfl.DashFlexLayout(...), style={"height": "500px"})
```

### Theme Toggle Pattern

Standard dark/light mode toggle:

```python
from dash import clientside_callback, Input, Output

theme_toggle = dmc.Switch(
    offLabel=DashIconify(icon="radix-icons:sun", width=15),
    onLabel=DashIconify(icon="radix-icons:moon", width=15),
    id="color-scheme-toggle",
    persistence=True,
)

clientside_callback(
    """
    (switchOn) => {
       document.documentElement.setAttribute(
           'data-mantine-color-scheme',
           switchOn ? 'dark' : 'light'
       );
       return window.dash_clientside.no_update
    }
    """,
    Output("color-scheme-toggle", "id"),
    Input("color-scheme-toggle", "checked"),
)
```

---

## Documentation Site

The docs site is a lean, Flask-only, markdown-driven app at the REPO ROOT (Dash 4.x / DMC 2.x),
adapted from the Dash Documentation Boilerplate and wired into the 2plot network.

- **Run:** `python run.py` → http://localhost:8055
- **`requirements.txt` (repo root) IS the docs site's dependency list** — the package's own are in
  `pyproject.toml` and are just `dash>=4.1,<5` + `typing_extensions`. `run.py` sits beside the built
  `flexlayout_dash/`, so the live examples import it with no `sys.path` juggling and no install.
- **Authoring:** one folder per page — `docs/<slug>/<slug>.md` (frontmatter: name, description,
  endpoint, icon, category) plus `docs/<slug>/example.py` exporting a `component`. Reference it with
  `.. exec::docs.<slug>.example`; hyphenated slugs work. Directives: `.. toc::`, `.. exec::`,
  `.. source::`, `.. llms_copy::`, `.. kwargs::flexlayout_dash.DashFlexLayout` (the kwargs directive
  was patched to parse Dash's `Keyword arguments:` docstrings). The home page is `docs/home/` with
  `endpoint: "/"` — no special-casing in run.py.

---

## Build Commands

```bash
# Build JavaScript bundle  ->  flexlayout_dash/flexlayout_dash.min.js
npm run build:js

# Generate Python components (see build note in Quick Start re: R-gen crash + __init__)
npm run build:backends

# Full build
npm run build

# Build the Python distribution (after npm run build)
python -m build        # -> dist/flexlayout_dash-<version>.tar.gz + .whl

# Verify before tagging
python scripts/check_release.py   # version drift across pyproject/package.json/
                                  # package-info.json/lib/constants.py, MANIFEST leaks
python scripts/smoke_test.py      # component + docs site, no browser, no socket
```

---

## Network role & the behavioral contract

This repo is a member of the 2plot network — either the template
itself (dash-documentation-boilerplate) or a fork of it serving one
component's documentation. **Identity derives from the repo, never
from this file**: the app key comes from `SATELLITE_APP_KEY` and
run.py's fork point, the host from `lib/constants.py`'s `BASE_URL`,
the deliberate differences from the template from `DIVERGENCES.md`
at the repo root. If those disagree with anything written here,
they win.

### The contract — every session, every prompt

1. **Check the prompt against this tree before executing.** Prompts
   are written from the template's perspective and your fork may
   legitimately differ — floors, backends, payload shapes, page
   sets. A prompt step that doesn't fit this repo is a finding to
   return, not an instruction to force.
2. **Corrections are your job, not scope creep.** If a prompt's
   reference list doesn't match its steps, if its assumed state is
   wrong, or if executing it as written would produce a
   green-but-vacuous result, say so and propose the corrected
   version before running it.
3. **Verify your own deploy on the wire before reporting.** A push
   is not a result. Run `/wire-verify` (or its manual equivalent)
   against production and paste what came back. If your sandbox
   cannot reach your own domain, say exactly that — an unverified
   claim marked as unverified is honest; the same claim unmarked is
   not.
4. **Report observed versus expected, with evidence.** Paste the
   JSON, the status code, the test count. "Should work" and summary
   claims without artifacts are not reports.
5. **Divergence is legitimate when written down.** Before syncing
   template changes, read `DIVERGENCES.md`; never let a sync
   "restore" a recorded deliberate difference. When you deliberately
   diverge, record it there in the same commit — an unrecorded
   divergence is indistinguishable from drift and will be treated
   as drift.
6. **Never touch**: environment variable VALUES, hosting dashboards,
   secrets, other repos' trees, or anything the prompt didn't put in
   scope. Enumerate what you cannot do (closing PRs, dashboard
   steps) for the owner instead of claiming it done.

- PRINT THE RESOLVED VERSION BESIDE THE RESULT, and say which tool
  produced it (1.6.44 item 10). An acceptance is a claim about a tree
  at a version: "suite green" is not a result, "458 passed, 1 skipped,
  exit 0, dimll 2.8.0 imported from .venv/.../site-packages" is.
  Resolve it by IMPORTING and printing `mod.__file__` — never by
  reading requirements.txt, which states the intent, and never by
  parsing source. Measured on excalidraw 2026-09-01: `llms_version`
  2.9.4 on the wire while its suite ran 2.8.0, so its CI and its
  production disagreed about which package's behaviour was being
  accepted, and every green tick meant the older one.
  THIS HOST CANNOT YET MAKE THAT COMPARISON: `/healthz` here carries no
  `llms_version` until 1.6.44 item 1 is deployed, so the production
  number is unreadable and the range check over the whole admissible
  floor stands in for it (DIVERGENCES 20). Say which of the two you
  are reporting.
  The same rule names the tools whose LOCAL invocation is not CI's:
  `actionlint` without shellcheck on PATH skips every `run:` block's
  shell analysis, so "actionlint clean" locally is a weaker statement
  than the CI job's; a local absence of the binary is weaker still,
  and both must be reported as what they are. MEASURED ON THIS SEAT
  2026-09-05: neither `actionlint` nor `shellcheck` is on PATH here, so
  this seat can make NO local statement about the lint job at all —
  only CI's run counts, and a report from here says exactly that.
  This repo also runs no Python linter in CI (the lint job is
  actionlint alone; there is no flake8, ruff or lint config anywhere),
  so `py_compile sweep of docs/` is the only reader of the Python the
  docs site renders — not a second opinion. Report it as "no linter in
  CI; py_compile is the syntax gate", never by quoting a flake8 line
  this repo does not have.
  The general form: when the check you ran differs from the check CI
  runs, the report says so in the same sentence as the result.

### Verification traps (fleet-learned, keep them)

- A `>=` floor can never pull a new release through a Docker cache
  hit — the requirements line changing IS the cache bust, and floors
  live in several encodings (requirements, run.py's boot floor,
  tests, CI): grep the number, move every one.
- `/healthz` build == HEAD is the deploy proof; a missing geo block
  on dimll ≥2.7 means the cache trap fired (unless DIVERGENCES.md
  says this host's healthz is deliberately minimal).
- Probe with GET, not HEAD — HEAD responses omit the Link headers.
- Run-watchers keyed on a commit sha can match Dependabot's runs on
  the same sha — key on the workflow path (cd.yml) instead.
- The browser lane and the machine lane are different documents;
  a fix proven on one is unproven on the other.
- There is ONE classifier: `dash_improve_my_llms.classify()`. Never
  add a User-Agent list to this app — `lib/analytics_tracker.py`
  carried one for a year, it filed ClaudeBot as *search* (it is
  Anthropic's TRAINING crawler), it still named the retired
  `anthropic-ai` / `claude-web` tokens, and it counted every UA-less
  or library client as a human. A token the registry lacks is a
  pushback to the package seat, not a list here;
  `tests/test_analytics_classifier.py` greps the module for the old
  tokens and goes red if one comes back.
- `build == HEAD` on `/healthz` means HEAD of **`release`**, not
  `main` (item 13, 2026-08-29). Render deploys `release`; only
  cd.yml's `deploy` job writes it, fast-forward, after the CI matrix
  is green. `main` ahead of `release` is an uncertified push pending
  — its CD run is red or still running — never "drift" and never a
  reason to deploy by hand or write `release` yourself (a
  non-fast-forward push fails the next run on purpose). Compare the
  wire against `git rev-parse origin/release`, not `origin/main`.
- WHICH BRANCH RENDER BUILDS CAN BE MEASURED ON A GREEN PUSH,
  BY TIMING — strong evidence, not proof (leaflet). `main ==
  release == wire` at every step of a promote tells you
  nothing. Sample `/healthz` every ~45 s from the push and time
  the swap against the **promote**, not the push: leaflet
  measured build+swap at 2m03s from its promote; had Render
  reacted to the push, that same interval would have put the
  build live ~1m52s before it appeared. The canonical
  discriminator is still the first push that goes RED on main
  with `release` unmoved and the wire unchanged. Four hosts
  correctly declined to call their `deploy:` fence row proven
  on a green push; that refusal is the standard.
- VERIFY THE ARTIFACT THE CLAIM IS ABOUT, AND SAY WHICH ONE.
  It runs both ways. A props table absent from the crawler
  document is a defect of the SITE, not of the harness —
  pannellum moved that assertion to the lane that passed and
  the pin held for a fortnight over a corpus serving zero
  props. WHEN A LANE DISAGREES, THAT IS THE FINDING. And the
  inverse, which is worse because it sends someone hunting a
  bug that does not exist: `curl https://…/ | grep -c
  skip-link` returns **0** on a host where the skip link ships
  and works (excalidraw), because it is a Dash component in
  `app.layout`.
- ASSERT THE CORPUS IS NON-EMPTY BEFORE TRUSTING ANY NEGATIVE,
  and print the count beside the result. A sweep that found
  nothing and a sweep that swept nothing produce the same
  green. Measured on the template 2026-09-01: its `.flake8`
  excludes `docs/*/`, so `flake8 docs/` exits **0** with a file
  in `docs/` containing `def broken(:` — the linter is not
  passing the file, it is not reading it; `py_compile` sees it
  immediately. Same family as `pytest … | tail -2 && git
  commit`, where the pipe's exit status was `tail`'s and a red
  suite committed anyway: capture exit codes on the process,
  never through a pipe. And grep a fragment as it SHIPS, not
  as your prose styles it — prefer `-ci` for any fragment
  whose case is an emphasis choice rather than an identifier.
