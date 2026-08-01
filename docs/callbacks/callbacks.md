---
name: Callbacks
description: Read layout state and drive content from Dash callbacks.
endpoint: /callbacks
icon: mdi:function-variant
---

.. llms_copy::Callbacks

.. toc::

### Reading the live model

Set `useStateForModel=False` and the layout round-trips through Dash, so you can read the
current model from any callback via `Input("your-dock-id", "model")`. Rearrange the panels
below and watch the JSON update.

.. exec::docs.callbacks.example

### How it stays callback-friendly

flexlayout-dash renders each tab's children through a **React portal** into a stable
container, so your tab content stays mounted across internal FlexLayout changes (tab
switches, splitter drags). That keeps callbacks bound to elements inside tabs working.

As of **1.1.0**, echoes of FlexLayout's own internal model changes no longer recreate the
layout model, so stateful tab content (canvases, editors, in-progress drags) is not
re-mounted on tab switch or splitter drag — only a model your *own* callbacks write
rebuilds it. `setProps` still fires on every change, so `Input(dock, "model")` keeps working.

### Tip: keep tabs mounted

For callbacks bound to elements *inside* tabs, keep every tab mounted by setting
`"tabEnableRenderOnDemand": False` in the model's `global` section.
