---
name: Getting Started
description: Build your first dockable layout with flexlayout-dash.
endpoint: /getting-started
icon: mdi:rocket-launch-outline
---

.. llms_copy::Getting Started

.. toc::

## Install

```bash
pip install flexlayout-dash
```

```python
import flexlayout_dash as dfl
```

The import name is `flexlayout_dash` (as of 1.1.0); the distribution on PyPI is `flexlayout-dash`.

## Your first layout

A `DashFlexLayout` takes a **model** (the JSON layout tree) and **children** (`Tab`
components whose `id` matches a tab `id` in the model). Wrap it in a container with an
explicit height and you have a draggable, splittable dock.

.. exec::docs.getting-started.example

## The three rules

1. **Match IDs** — every `dfl.Tab(id=...)` must correspond to a `{"type": "tab", "id": ...}` in the model.
2. **Give it height** — pass `style={"height": "400px"}` to the component (its `style` is applied to the dock container). FlexLayout positions its layout absolutely; the component sets `position: relative` on its own container, so the layout stays contained within that box.
3. **Pick a model mode** — `useStateForModel=True` keeps the layout in the browser (simplest). Use `False` when you want to read or drive the model from Dash callbacks (see [Callbacks](/callbacks)).

Next, see the full [Component Reference](/reference), or jump to [Basic Layouts](/basic).
