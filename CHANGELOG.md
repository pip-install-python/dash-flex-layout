# Changelog

All notable changes to DashDock will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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