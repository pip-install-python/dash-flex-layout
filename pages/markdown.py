import logging
import re
from pathlib import Path
from typing import List, Optional

import dash
import dash_mantine_components as dmc
import frontmatter
from dash_improve_my_llms import register_page_metadata
from markdown2dash import Admonition, BlockExec, Divider, Image
from pydantic import BaseModel, field_validator

from lib.ad_client import inject_ad_into_aside
# Local create_parser: markdown2dash renders **bold** / *italic* / ~~struck~~
# as <p>, nesting a <p> inside the paragraph's own <p>. See lib/renderer.py.
from lib.renderer import create_parser
from lib.constants import OG_IMAGE_URL, PAGE_TITLE_PREFIX, NAME_CONTENT_MAP
from lib import aside, gate_layouts, page_tiers, page_visibility
from lib.page_visibility import published_name
from lib.directives.headings import patch_renderer
from lib.directives.kwargs import Kwargs, resolve_kwargs
from lib.directives.llms_copy import LlmsCopy
from lib.directives.source import SC
from lib.directives.toc import TOC
from lib.versions import substitute_versions

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

directory = "docs"

# read all markdown files
files = Path(directory).glob("**/*.md")


class Meta(BaseModel):
    name: str
    description: str
    endpoint: str
    package: str = "flexlayout_dash"
    category: Optional[str] = None
    icon: Optional[str] = None
    # Sidebar position within its category (item 16); ties break on name.
    order: int = 1000
    # Short sidebar label (item 18); default = name. A page whose SEO/llms.txt
    # name is long can keep it (title, og:title, the llms.txt H1 all still
    # read `name`) while the sidebar shows something shorter — shortening
    # `name:` itself would churn all three for a cosmetic nav change.
    nav: Optional[str] = None
    # Who may read this page: public | auth | admin | hidden. Absent means
    # the deployment default (PAGE_DEFAULT_TIER, else public) — see
    # lib/page_tiers.py for the tier model and why the default is open.
    tier: Optional[str] = None
    # The second axis: does the machine twin (/<page>/llms.txt, crawler HTML,
    # the prerender) stay open while the interactive page is gated? Absent
    # defers to LLMS_PUBLIC_DEFAULT (unset = open — the data-window posture).
    # Only meaningful on `auth` pages; see lib/page_tiers.get_llms_public.
    llms_public: Optional[bool] = None
    # schema.org @type for the crawler document's JSON-LD. Absent means
    # TechArticle — every page here documents software, and "WebPage" (the
    # package default) tells Google nothing it did not already know. The home
    # page declares SoftwareApplication in run.py.
    schema_type: Optional[str] = None
    # Sitemap <lastmod>, YYYY-MM-DD, emitted VERBATIM by dash-improve-my-llms
    # >= 2.6.0 — and omitted entirely when absent. Truth or silence: set it
    # when the page's content genuinely changes (the frontmatter edit rides
    # the same commit as the prose), never script it from file mtimes, which
    # reset on every Docker build and would re-invent the daily-lie sitemap
    # 2.6.0 exists to end. The validator exists because YAML parses a bare
    # `lastmod: 2026-08-01` into datetime.date before pydantic ever sees it.
    lastmod: Optional[str] = None

    @field_validator("lastmod", mode="before")
    @classmethod
    def _lastmod_to_iso(cls, value):
        return value.isoformat() if hasattr(value, "isoformat") else value


_SOURCE_DIRECTIVE = re.compile(r'^\.\. source::(.+?)$', re.MULTILINE)
_LANG_MAP = {
    'py': 'python', 'pyi': 'python',
    'js': 'javascript', 'jsx': 'jsx',
    'ts': 'typescript', 'tsx': 'tsx',
    'css': 'css', 'scss': 'scss', 'sass': 'sass', 'less': 'less',
    'html': 'html', 'htm': 'html', 'xml': 'xml',
    'json': 'json',
    'yaml': 'yaml', 'yml': 'yaml',
    'md': 'markdown', 'rst': 'rst', 'txt': 'text',
    'sh': 'bash', 'bash': 'bash',
    'sql': 'sql', 'r': 'r',
    'toml': 'toml', 'ini': 'ini', 'conf': 'conf',
}


def _expand_source_directives(markdown_content: str) -> str:
    """Inline `.. source::path` directives with the referenced file content.

    This produces the prose that dash-improve-my-llms 2.0 will serve at
    `/<page>/llms.txt`. Replacing the directive with the real file content
    is what makes the LLM output self-contained for the "paste into a chat
    window" audience.

    FENCE-AWARE, and it has to be: a directive INSIDE a fenced code block
    is documentation showing the syntax, not a directive. Expanding it
    injects a ```python fence inside the already-open fence, which CLOSES
    it early — from there the inlined file renders as markdown, every
    `# comment` line becomes an <h1>, and the machine lane of the page
    serves broken structure (found 2026-08-23 on the boilerplate by the
    single-h1 pin now in tests/test_pages.py: docs/example and
    docs/directives both teach `.. source::` inside ```markdown fences and
    served FIVE h1s; the browser lane was never affected because
    markdown2dash parses fences properly). No page in this fork's docs/
    teaches the directive yet — which is exactly when to port the fix.
    """
    def expansion(directive_line: str) -> str:
        file_path = _SOURCE_DIRECTIVE.match(directive_line).group(1).strip()
        try:
            full = Path(file_path)
            content = full.read_text()
            ext = full.suffix.lstrip('.').lower()
            lang = _LANG_MAP.get(ext, ext or 'text')
            tail = '' if content.endswith('\n') else '\n'
            return f'\n```{lang}\n# File: {file_path}\n\n{content}{tail}```\n'
        except FileNotFoundError:
            return f'\n<!-- Error: File not found: {file_path} -->\n'
        except Exception as exc:
            return f'\n<!-- Error reading {file_path}: {exc} -->\n'

    out: List[str] = []
    fence = None  # the marker that opened the block we are inside, if any
    for line in markdown_content.split('\n'):
        head = line.lstrip()[:3]
        if fence is None and head in ('```', '~~~'):
            fence = head
        elif fence is not None and head == fence:
            fence = None
        elif fence is None and _SOURCE_DIRECTIVE.match(line):
            out.append(expansion(line))
            continue
        out.append(line)
    return '\n'.join(out)


_EXEC_DIRECTIVE = re.compile(r'^\.\. exec::(.+?)$', re.MULTILINE)
_CODE_FALSE = re.compile(r'^\s*:code:\s*false\s*$', re.IGNORECASE)


def _exec_module_to_path(module_spec: str) -> Path:
    """``docs.basic.example`` -> ``docs/basic/example.py`` — the same dotted
    path the ``.. exec::`` directive's own live-component import uses."""
    return Path(*module_spec.split('.')).with_suffix('.py')


def _expand_exec_directives(markdown_content: str) -> str:
    """Inline `.. exec::module.path` with the example's own source.

    A markdown2dash directive that renders a live Dash component (BlockExec)
    puts its output ONLY in the React tree — dash-improve-my-llms builds the
    machine lane from this markdown SOURCE and silently drops any `.. `
    directive line it does not itself recognise, so an un-expanded
    `.. exec::` line vanishes with no trace: measured on every one of this
    fork's six example pages, `/basic/llms.txt` went from "Drag tabs between
    tabsets..." straight to "### Notes" with the entire live-demo source
    between them gone. Same defect class as `.. kwargs::` above
    (item 18, muicharts' /api instance; this fork's own instance was found
    on /reference — see tests/test_kwargs_machine_lane.py), different
    directive.

    Three-step precedence, in order, per doc author (item 18 amendment):

    1. **Dedupe, silently.** A page that ALSO has a `.. source::` directive
       naming the SAME file is already showing that source deliberately —
       expanding the exec block too would duplicate it. Leave the exec
       line untouched; the package's own silent-drop handles it, which is
       the correct outcome here (the content is already present, once).
    2. **`:code: false` — a marker, not a copy.** An author who wants the
       live demo WITHOUT dumping its source into the machine lane says so
       explicitly, on an indented option line directly under the
       directive. Respected as a marker naming the module, never silently
       treated the same as case 1 (a reader should be able to tell "the
       source is elsewhere" from "the author chose not to show it").
    3. **Otherwise, expand** — the same fenced-code treatment
       `_expand_source_directives` gives `.. source::`, sourced from the
       dotted module path's own file. Measured on this fork: 0 of 6
       `.. exec::` directives use either #1 or #2, so all six expand.

    FENCE-AWARE for the same reason `_expand_source_directives` is: a
    directive inside a ```markdown fence is a syntax example, not a live
    one.
    """
    lines = markdown_content.split('\n')
    sourced_paths = {
        Path(m.group(1).strip()).resolve()
        for m in _SOURCE_DIRECTIVE.finditer(markdown_content)
    }

    def expand_file(module_spec: str) -> str:
        file_path = _exec_module_to_path(module_spec)
        try:
            content = file_path.read_text()
            tail = '' if content.endswith('\n') else '\n'
            return f'\n```python\n# File: {file_path}\n\n{content}{tail}```\n'
        except FileNotFoundError:
            return f'\n<!-- Error: File not found: {file_path} -->\n'
        except Exception as exc:
            return f'\n<!-- Error reading {file_path}: {exc} -->\n'

    out: List[str] = []
    fence = None
    i = 0
    while i < len(lines):
        line = lines[i]
        head = line.lstrip()[:3]
        if fence is None and head in ('```', '~~~'):
            fence = head
            out.append(line)
            i += 1
            continue
        if fence is not None and head == fence:
            fence = None
            out.append(line)
            i += 1
            continue
        m = _EXEC_DIRECTIVE.match(line) if fence is None else None
        if not m:
            out.append(line)
            i += 1
            continue

        module_spec = m.group(1).strip()
        # Consume any indented RST option lines (":code: false" etc.)
        # directly below the directive, before the next blank line —
        # whether or not they change the outcome, they must not leak
        # into the prose as literal text.
        j = i + 1
        code_false = False
        while j < len(lines) and lines[j].strip() and lines[j].startswith((' ', '\t')):
            if _CODE_FALSE.match(lines[j]):
                code_false = True
            j += 1

        file_path = _exec_module_to_path(module_spec)
        if file_path.resolve() in sourced_paths:
            # Dedupe, explicitly: the source is already shown via a
            # hand-paired `.. source::` elsewhere on the page, so drop
            # this line ourselves rather than trust that dash-improve-
            # my-llms silently strips whatever `.. ` syntax it doesn't
            # recognise — observed empirically for `.. exec::` and
            # `.. kwargs::`, but not a documented contract to lean on.
            pass
        elif code_false:
            out.append(f'\n<!-- {module_spec} ({file_path.name}): source withheld (:code: false) -->\n')
        else:
            out.append(expand_file(module_spec))
        i = j
    return '\n'.join(out)


_KWARGS_DIRECTIVE = re.compile(r'^\.\. kwargs::(.+?)$', re.MULTILINE)


def _cell(text) -> str:
    """One Markdown table cell: no newlines, no unescaped pipes."""
    return str(text).replace('\n', ' ').replace('|', '\\|')


def _expand_kwargs_directives(markdown_content: str) -> str:
    """Inline `.. kwargs::pkg.Component` as a Markdown prop table.

    The 4th empty-machine-lane mechanism (item 18, muicharts 1b2ac12): a
    markdown2dash DIRECTIVE that renders Dash components (lib/directives/
    kwargs.py's Kwargs) puts its output ONLY in the React tree — the
    machine lane, the prerender and the crawler HTML are all built from
    the markdown SOURCE, where the directive line survives verbatim (or,
    before this fix, was silently dropped) and the browser's rich prop
    table simply never reached an agent. docs/reference/reference.md is
    THIS fork's own instance: `/reference/llms.txt` served `### DashFlexLayout`
    straight into `### Tab` with the entire prop table between them missing.

    ONE SHARED PARSE (the item's own requirement): `resolve_kwargs()` in
    lib/directives/kwargs.py is what BOTH the browser's Kwargs directive
    and this expansion call — a spec can never resolve to one table in
    the browser and a different (or empty) one here. FENCE-AWARE for the
    same reason `_expand_source_directives` is: docs/directives teaches
    `.. kwargs::` inside a ```markdown fence as a syntax example, which
    must not be expanded.
    """
    def expansion(directive_line: str) -> str:
        spec = _KWARGS_DIRECTIVE.match(directive_line).group(1).strip()
        params = resolve_kwargs(spec)
        if not params:
            return f'\n<!-- kwargs: {spec} resolved to no props -->\n'
        lines = ['', f'**{spec}** props:', '',
                 '| prop | type | description |', '|---|---|---|']
        for p in params:
            lines.append(f"| `{_cell(p['name'])}` | {_cell(p['type'])} | {_cell(p['description'])} |")
        lines.append('')
        return '\n'.join(lines)

    out: List[str] = []
    fence = None
    for line in markdown_content.split('\n'):
        head = line.lstrip()[:3]
        if fence is None and head in ('```', '~~~'):
            fence = head
        elif fence is not None and head == fence:
            fence = None
        elif fence is None and _KWARGS_DIRECTIVE.match(line):
            out.append(expansion(line))
            continue
        out.append(line)
    return '\n'.join(out)


def _first_heading_level(markdown_content: str) -> int:
    """The level of the document's first real heading, 0 if it has none.

    Fence-aware for the same reason `_expand_source_directives` is: a
    `# comment` line inside a ```python block is not a heading, and this
    fork's docs are full of them.
    """
    fence = None
    for line in markdown_content.split('\n'):
        head = line.lstrip()[:3]
        if fence is None and head in ('```', '~~~'):
            fence = head
            continue
        if fence is not None:
            if head == fence:
                fence = None
            continue
        match = re.match(r'(#{1,6})\s', line)
        if match:
            return len(match.group(1))
    return 0


def _build_llms_doc(name: str, description: str, expanded_markdown: str, path: str) -> str:
    """Wrap the expanded markdown with the heading/description preamble that
    /llms.txt readers expect.

    A doc whose body opens with its OWN H1 supplies its own title, so the
    preamble is skipped: prepending `# {name}` on top of it makes the machine
    lane a duplicate-H1 document — precisely the defect dash-improve-my-llms
    2.7.0 removed from the package's side (the injected prerender header vs
    the body's markdown H1), reintroduced one layer up. docs/home/home.md is
    the case that has it: its H1 is the site brand, pinned by
    tests/test_site_identity.py, and its own blockquote is the tagline. Every
    other page here starts at h2/h3 and gets the preamble as before.
    """
    parts: List[str] = []
    if _first_heading_level(expanded_markdown) != 1:
        parts.append(f"# {name}\n")
        if description:
            parts.append(f"> {description}\n")
        parts.append("---\n")
    parts.append(expanded_markdown.rstrip() + "\n")
    parts.append("\n---\n")
    parts.append(f"*Source: {path}*\n")
    return "\n".join(parts)


# Heading ids that survive inline formatting, and inline `![alt](src)` image
# rendering. Must run before create_parser() instantiates the renderer.
# lib/renderer.py's PatchedDashRenderer subclasses markdown2dash's
# DashRenderer without overriding heading/image, so it inherits the patch.
patch_renderer()

directives = [Admonition(), BlockExec(), Divider(), Image(), Kwargs(), LlmsCopy(), SC(), TOC()]
parse = create_parser(directives)

for file in files:
    logger.info("Loading %s..", file)
    metadata, content = frontmatter.parse(file.read_text())
    metadata = Meta(**metadata)

    # Substitute derived facts BEFORE any consumer sees the text, so the
    # browser page, the copy button, and /<page>/llms.txt all publish the
    # same truth. A doc writes {{VERSION:<distribution>}} instead of a
    # version number — any INSTALLED distribution (see lib/versions.py).
    # NOTE: flexlayout-dash itself does not qualify — the docs import the
    # local build from flexlayout_dash/ without pip-installing it (see the
    # tail of requirements.txt), so {{VERSION:flexlayout-dash}} would raise
    # at boot in the Docker image, where no such distribution exists.
    content = substitute_versions(content, source=str(file))

    # Store raw markdown content in NAME_CONTENT_MAP for the LLM copy button.
    NAME_CONTENT_MAP[metadata.name] = content

    # Pages with a `.. toc::` fill the aside; the shell collapses it for
    # every other page (lib/aside.py, item 16 — full-width /changelog).
    if ".. toc::" in content:
        aside.register(metadata.endpoint)

    layout = parse(content)

    # add heading and description to the layout
    section = [
        dmc.Title(metadata.name, order=2, className="m2d-heading"),
        dmc.Text(metadata.description, className="m2d-paragraph"),
    ]
    layout = section + layout

    # 2plot.dev ad slot, appended below the TOC links in the page aside. Pages
    # without a `.. toc::` have no aside and simply get no slot; the call is
    # fail-silent either way, so it can never block page registration.
    inject_ad_into_aside(layout, metadata.endpoint)

    # Wrap the whole page in ONE container with a page-unique id (item 18).
    # dash-renderer keys React children by component id, and markdown2dash
    # gives every heading an id derived from its text ("usage",
    # "introduction", ...) so TOC anchors work. Those ids repeat within and
    # across pages, so when fast navigation swaps _pages_content.children
    # between two flat layout lists, React reconciles by colliding keys and
    # splices stale headings from the previous page into the new one
    # (TOC-only ghost page until you scroll). A single keyed wrapper per
    # page makes every swap old-node -> new-node: atomic unmount/mount, no
    # cross-page key matching. Do not flatten this back into a list.
    layout = dmc.Box(layout, id="m2d-page" + metadata.endpoint.replace("/", "-"))

    # register with dash — the layout goes in behind the interactive gate.
    # The tree is still built once, above; gated_layout only decides per
    # render whether the visitor gets it or the sign-in/forbidden/404 card
    # (lib/gate_layouts.py). With every tier public the verdict is a dict
    # lookup that always says allow, so an ungated fork pays ~nothing.
    dash.register_page(
        metadata.name,
        metadata.endpoint,
        name=metadata.name,
        title=PAGE_TITLE_PREFIX + metadata.name,
        description=metadata.description,
        layout=gate_layouts.gated_layout(
            metadata.endpoint, metadata.name, layout
        ),
        category=metadata.category,
        icon=metadata.icon,
        order=metadata.order,
        nav=metadata.nav,
        # Dash emits og:image/twitter:image for EVERY page and writes
        # content="" when it finds no image (dash/_pages.py) — and an empty
        # og:image unfurls as a blank card. Every register_page passes the CDN
        # card explicitly; a single missing one reintroduces the bug on that
        # page. See lib.constants.OG_IMAGE_URL.
        image_url=OG_IMAGE_URL,
    )

    # Feed the expanded markdown into dash-improve-my-llms so /<page>/llms.txt
    # serves the directive-expanded prose. This replaces the custom Flask
    # route that used to live in run.py and works across all three backends.
    # Record the declared tier before the prose is registered, so a gate can
    # never be applied later than the content it is meant to gate.
    #
    # ONE declared value, TWO ledgers. The control board's row first —
    # overrides written there win at resolution time (lib.access.local_tier),
    # which is what makes a board toggle apply live. Then the network ledger:
    # what the hub's tier ceiling compares against and what lib.access
    # enforces underneath any override.
    page_visibility.register_default(metadata.endpoint, metadata.name,
                                     visibility=metadata.tier,
                                     llms_public=metadata.llms_public)
    page_tiers.register(metadata.endpoint, metadata.tier,
                        llms_public=metadata.llms_public)

    # ORDER MATTERS: exec must run BEFORE source. _expand_exec_directives'
    # dedupe scan looks for `.. source::` lines naming its own target in
    # the text it receives — if source expansion ran first, every
    # `.. source::` line would already be a fenced block and the dedupe
    # scan would find nothing to dedupe against, silently doubling every
    # hand-paired page's source. kwargs has no such dependency and stays
    # last.
    expanded = _expand_kwargs_directives(
        _expand_source_directives(_expand_exec_directives(content))
    )
    # The full record, matching the dash.register_page call above. These two
    # calls must never describe the same page differently: the thinner record
    # here is exactly how the fleet shipped "flexlayout-dash | Theming" to
    # browsers and a bare "Theming" to Google (the one bug behind every SEO
    # defect measured across the network, 2026-08). title and image_url are
    # read by dash-improve-my-llms 2.5.0+; older packages ignore them.
    register_page_metadata(
        path=metadata.endpoint,
        name=metadata.name,
        description=metadata.description,
        title=PAGE_TITLE_PREFIX + metadata.name,
        image_url=OG_IMAGE_URL,
        schema_type=metadata.schema_type or "TechArticle",
        # Pre-2.6 packages swallow this into **kwargs and ignore it (no
        # TypeError — measured on 2.5.1); the floor in run.py guarantees
        # >= 2.6.1, where a real date is emitted and None omits the tag.
        lastmod=metadata.lastmod,
        # The PUBLISHED name, not the nav label (item 18): a home page
        # named "Home" would put `# Home` in the preamble while the
        # package injects the site brand. On this fork _build_llms_doc's
        # own fence-aware guard already skips the preamble for `/`
        # (DIVERGENCES.md §5), so this only matters for a future page
        # whose body has no H1 of its own.
        llms_doc=_build_llms_doc(
            published_name(metadata.endpoint, metadata.name),
            metadata.description,
            expanded,
            metadata.endpoint,
        ),
    )
