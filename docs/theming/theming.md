---
name: Theming
description: Automatic Mantine light/dark integration.
endpoint: /theming
icon: mdi:palette-outline
---

.. llms_copy::Theming

.. toc::

### Follows your Mantine theme

`DashFlexLayout` watches the document's `data-mantine-color-scheme` attribute with a
`MutationObserver`, so it restyles itself whenever your app toggles light/dark — no extra
wiring needed. Try the sun/moon switch in the header: the dock below follows it.

.. exec::docs.theming.example

### Forcing a scheme

To pin the scheme regardless of the page, pass the `colorScheme` prop:

```python
dfl.DashFlexLayout(id="dock", model=model, children=tabs, colorScheme="dark")
```

### Custom styling

The component renders under `.dash-dock-container` with a `.dash-dock-light` or
`.dash-dock-dark` modifier, so you can target FlexLayout's classes in your own CSS:

```css
.dash-dock-dark .flexlayout__tabset { background: #1a1b1e; }
.dash-dock-dark .flexlayout__tab    { background: #16213e; color: #eee; }
```
