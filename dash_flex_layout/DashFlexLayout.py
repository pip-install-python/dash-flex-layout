# AUTO GENERATED FILE - DO NOT EDIT

import typing  # noqa: F401
from typing_extensions import TypedDict, NotRequired, Literal # noqa: F401
from dash.development.base_component import Component, _explicitize_args

ComponentType = typing.Union[
    str,
    int,
    float,
    Component,
    None,
    typing.Sequence[typing.Union[str, int, float, Component, None]],
]

NumberType = typing.Union[
    typing.SupportsFloat, typing.SupportsInt, typing.SupportsComplex
]


class DashFlexLayout(Component):
    """A DashFlexLayout component.
DashFlexLayout is a wrapper around FlexLayout-React that provides
flexible docking windows for Dash applications.
*
Features:
- Dockable, resizable, and floatable window panels
- Drag-and-drop tab management
- Seamless Mantine theme integration (light/dark mode)
- Dash 2 and Dash 3 compatibility

Keyword arguments:

- children (a list of or a singular dash component, string or number; required):
    List of children to be rendered. Children are allocated to their
    respective tab based on the ID of the element.  WARNING: There is
    no validation done on whether the children here will be rendered
    in any tab. If there is no matching tab for a particular ID, that
    element will be silently ignored in rendering (although callbacks
    will still be applied).

- id (string; optional):
    Unique ID to identify this component in Dash callbacks.

- colorScheme (a value equal to: 'light', 'dark'; optional):
    Current color scheme, automatically detected from Mantine theme If
    not specified, will try to auto-detect from HTML
    data-mantine-color-scheme.

- debugMode (boolean; default False):
    Debug mode flag.

- font (boolean | number | string | dict | list; optional):
    The tab font (overrides value in css). Example:
    font={{size:\"12px\", style:\"italic\"}}.

- headers (dict with strings as keys and values of type a list of or a singular dash component, string or number; optional):
    Map of headers to render for each tab. Uses the `onRenderTab`
    function to override the default headers, where a custom header
    mapping is supplied.  Note: where possible, it is likely better to
    use classes to style the headers, rather than using this prop.

- loading_state (dict; optional):
    Loading state.

    `loading_state` is a dict with keys:

    - is_loading (boolean; required)

    - component_name (string; required)

    - prop_name (string; required)

- model (dict; required):
    Model layout.

    `model` is a dict with keys:

    - global (dict; optional)

        `global` is a dict with keys:

        - borderAutoSelectTabWhenClosed (boolean; optional):
            Value for BorderNode attribute autoSelectTabWhenClosed if
            not overridden  whether to select new/moved tabs in border
            when the border is currently closed  Default: False.

        - borderAutoSelectTabWhenOpen (boolean; optional):
            Value for BorderNode attribute autoSelectTabWhenOpen if
            not overridden  whether to select new/moved tabs in border
            when the border is already open  Default: True.

        - borderClassName (string; optional):
            Value for BorderNode attribute className if not overridden
            class applied to tab button  Default: undefined.

        - borderEnableAutoHide (boolean; optional):
            Value for BorderNode attribute enableAutoHide if not
            overridden  hide border if it has zero tabs  Default:
            False.

        - borderEnableDrop (boolean; optional):
            Value for BorderNode attribute enableDrop if not
            overridden  whether tabs can be dropped into this border
            Default: True.

        - borderEnableTabScrollbar (boolean; optional):
            Value for BorderNode attribute enableTabScrollbar if not
            overridden  whether to show a mini scrollbar for the tabs
            Default: False.

        - borderMaxSize (number; optional):
            Value for BorderNode attribute maxSize if not overridden
            the maximum size of the tab area  Default: 99999.

        - borderMinSize (number; optional):
            Value for BorderNode attribute minSize if not overridden
            the minimum size of the tab area  Default: 0.

        - borderSize (number; optional):
            Value for BorderNode attribute size if not overridden
            size of the tab area when selected  Default: 200.

        - enableEdgeDock (boolean; optional):
            enable docking to the edges of the layout, this will show
            the edge indicators  Default: True.

        - enableRotateBorderIcons (boolean; optional):
            boolean indicating if tab icons should rotate with the
            text in the left and right borders  Default: True.

        - rootOrientationVertical (boolean; optional):
            the top level 'row' will layout horizontally by default,
            set this option True to make it layout vertically
            Default: False.

        - splitterEnableHandle (boolean; optional):
            enable a small centralized handle on all splitters
            Default: False.

        - splitterExtra (number; optional):
            additional width in pixels of the splitter hit test area
            Default: 0.

        - splitterSize (number; optional):
            width in pixels of all splitters between tabsets/borders
            Default: 8.

        - tabBorderHeight (number; optional):
            Value for TabNode attribute borderHeight if not overridden
            height when added to border, -1 will use border size
            Default: -1.

        - tabBorderWidth (number; optional):
            Value for TabNode attribute borderWidth if not overridden
            width when added to border, -1 will use border size
            Default: -1.

        - tabClassName (string; optional):
            Value for TabNode attribute className if not overridden
            class applied to tab button  Default: undefined.

        - tabCloseType (a value equal to: 1, 2, 3; optional):
            Value for TabNode attribute closeType if not overridden
            see values in ICloseType  Default: 1.

        - tabContentClassName (string; optional):
            Value for TabNode attribute contentClassName if not
            overridden  class applied to tab content  Default:
            undefined.

        - tabDragSpeed (number; optional):
            Default: 0.3.

        - tabEnableClose (boolean; optional):
            Value for TabNode attribute enableClose if not overridden
            allow user to close tab via close button  Default: True.

        - tabEnableDrag (boolean; optional):
            Value for TabNode attribute enableDrag if not overridden
            allow user to drag tab to new location  Default: True.

        - tabEnablePopout (boolean; optional):
            Value for TabNode attribute enablePopout if not overridden
            enable popout (in popout capable browser)  Default: False.

        - tabEnablePopoutIcon (boolean; optional):
            Value for TabNode attribute enablePopoutIcon if not
            overridden  whether to show the popout icon in the tabset
            header if this tab enables popouts  Default: True.

        - tabEnablePopoutOverlay (boolean; optional):
            Value for TabNode attribute enablePopoutOverlay if not
            overridden  if this tab will not work correctly in a
            popout window when the main window is backgrounded
            (inactive)       then enabling this option will gray out
            this tab  Default: False.

        - tabEnableRename (boolean; optional):
            Value for TabNode attribute enableRename if not overridden
            allow user to rename tabs by double clicking  Default:
            True.

        - tabEnableRenderOnDemand (boolean; optional):
            Value for TabNode attribute enableRenderOnDemand if not
            overridden  whether to avoid rendering component until tab
            is visible  Default: True.

        - tabIcon (string; optional):
            Value for TabNode attribute icon if not overridden  the
            tab icon  Default: undefined.

        - tabMaxHeight (number; optional):
            Value for TabNode attribute maxHeight if not overridden
            the max height of this tab  Default: 99999.

        - tabMaxWidth (number; optional):
            Value for TabNode attribute maxWidth if not overridden
            the max width of this tab  Default: 99999.

        - tabMinHeight (number; optional):
            Value for TabNode attribute minHeight if not overridden
            the min height of this tab  Default: 0.

        - tabMinWidth (number; optional):
            Value for TabNode attribute minWidth if not overridden
            the min width of this tab  Default: 0.

        - tabSetAutoSelectTab (boolean; optional):
            Value for TabSetNode attribute autoSelectTab if not
            overridden  whether to select new/moved tabs in tabset
            Default: True.

        - tabSetClassNameTabStrip (string; optional):
            Value for TabSetNode attribute classNameTabStrip if not
            overridden  a class name to apply to the tab strip
            Default: undefined.

        - tabSetEnableActiveIcon (boolean; optional):
            Value for TabSetNode attribute enableActiveIcon if not
            overridden  whether the active icon (*) should be
            displayed when the tabset is active  Default: False.

        - tabSetEnableClose (boolean; optional):
            Value for TabSetNode attribute enableClose if not
            overridden  allow user to close tabset via a close button
            Default: False.

        - tabSetEnableDeleteWhenEmpty (boolean; optional):
            Value for TabSetNode attribute enableDeleteWhenEmpty if
            not overridden  whether to delete this tabset when is has
            no tabs  Default: True.

        - tabSetEnableDivide (boolean; optional):
            Value for TabSetNode attribute enableDivide if not
            overridden  allow user to drag tabs to region of this
            tabset, splitting into new tabset  Default: True.

        - tabSetEnableDrag (boolean; optional):
            Value for TabSetNode attribute enableDrag if not
            overridden  allow user to drag tabs out this tabset
            Default: True.

        - tabSetEnableDrop (boolean; optional):
            Value for TabSetNode attribute enableDrop if not
            overridden  allow user to drag tabs into this tabset
            Default: True.

        - tabSetEnableMaximize (boolean; optional):
            Value for TabSetNode attribute enableMaximize if not
            overridden  allow user to maximize tabset to fill view via
            maximize button  Default: True.

        - tabSetEnableSingleTabStretch (boolean; optional):
            Value for TabSetNode attribute enableSingleTabStretch if
            not overridden  if the tabset has only a single tab then
            stretch the single tab to fill area and display in a
            header style  Default: False.

        - tabSetEnableTabScrollbar (boolean; optional):
            Value for TabSetNode attribute enableTabScrollbar if not
            overridden  whether to show a mini scrollbar for the tabs
            Default: False.

        - tabSetEnableTabStrip (boolean; optional):
            Value for TabSetNode attribute enableTabStrip if not
            overridden  enable tab strip and allow multiple tabs in
            this tabset  Default: True.

        - tabSetEnableTabWrap (boolean; optional):
            Value for TabSetNode attribute enableTabWrap if not
            overridden  wrap tabs onto multiple lines  Default: False.

        - tabSetMaxHeight (number; optional):
            Value for TabSetNode attribute maxHeight if not overridden
            maximum height (in px) for this tabset  Default: 99999.

        - tabSetMaxWidth (number; optional):
            Value for TabSetNode attribute maxWidth if not overridden
            maximum width (in px) for this tabset  Default: 99999.

        - tabSetMinHeight (number; optional):
            Value for TabSetNode attribute minHeight if not overridden
            minimum height (in px) for this tabset  Default: 0.

        - tabSetMinWidth (number; optional):
            Value for TabSetNode attribute minWidth if not overridden
            minimum width (in px) for this tabset  Default: 0.

        - tabSetTabLocation (a value equal to: 'top', 'bottom'; optional):
            Value for TabSetNode attribute tabLocation if not
            overridden  the location of the tabs either top or bottom
            Default: \"top\".

    - borders (list of dicts; optional)

        `borders` is a list of dicts with keys:

        - location (a value equal to: 'top', 'bottom', 'left', 'right'; required)

        - children (list of dicts; required)

            `children` is a list of dicts with keys:

            - altName (string; optional):

                if there is no name specifed then this value will be used in

                the overflow menu  Default: undefined.

            - borderHeight (number; optional):

                height when added to border, -1 will use border size  Default:

                inherited from Global attribute tabBorderHeight (default -1).

            - borderWidth (number; optional):

                width when added to border, -1 will use border size  Default:

                inherited from Global attribute tabBorderWidth (default -1).

            - className (string; optional):

                class applied to tab button  Default: inherited from Global

                attribute tabClassName (default undefined).

            - closeType (a value equal to: 1, 2, 3; optional):

                see values in ICloseType  Default: inherited from Global

                attribute tabCloseType (default 1).

            - component (string; optional):

                string identifying which component to run (for factory)

                Default: undefined.

            - config (boolean | number | string | dict | list; optional):

                a place to hold json config for the hosted component  Default:

                undefined.

            - contentClassName (string; optional):

                class applied to tab content  Default: inherited from Global

                attribute tabContentClassName (default undefined).

            - enableClose (boolean; optional):

                allow user to close tab via close button  Default: inherited

                from Global attribute tabEnableClose (default True).

            - enableDrag (boolean; optional):

                allow user to drag tab to new location  Default: inherited

                from Global attribute tabEnableDrag (default True).

            - enablePopout (boolean; optional):

                enable popout (in popout capable browser)  Default: inherited

                from Global attribute tabEnablePopout (default False).

            - enablePopoutIcon (boolean; optional):

                whether to show the popout icon in the tabset header if this

                tab enables popouts  Default: inherited from Global attribute

                tabEnablePopoutIcon (default True).

            - enablePopoutOverlay (boolean; optional):

                if this tab will not work correctly in a popout window when

                the main window is backgrounded (inactive)       then enabling

                this option will gray out this tab  Default: inherited from

                Global attribute tabEnablePopoutOverlay (default False).

            - enableRename (boolean; optional):

                allow user to rename tabs by double clicking  Default:

                inherited from Global attribute tabEnableRename (default

                True).

            - enableRenderOnDemand (boolean; optional):

                whether to avoid rendering component until tab is visible

                Default: inherited from Global attribute

                tabEnableRenderOnDemand (default True).

            - enableWindowReMount (boolean; optional):

                if enabled the tab will re-mount when popped out/in  Default:

                False.

            - helpText (string; optional):

                An optional help text for the tab to be displayed upon tab

                hover.  Default: undefined.

            - icon (string; optional):

                the tab icon  Default: inherited from Global attribute tabIcon

                (default undefined).

            - id (string; optional):

                the unique id of the tab, if left undefined a uuid will be

                assigned  Default: undefined.

            - maxHeight (number; optional):

                the max height of this tab  Default: inherited from Global

                attribute tabMaxHeight (default 99999).

            - maxWidth (number; optional):

                the max width of this tab  Default: inherited from Global

                attribute tabMaxWidth (default 99999).

            - minHeight (number; optional):

                the min height of this tab  Default: inherited from Global

                attribute tabMinHeight (default 0).

            - minWidth (number; optional):

                the min width of this tab  Default: inherited from Global

                attribute tabMinWidth (default 0).

            - name (string; optional):

                name of tab to be displayed in the tab button  Default:

                \"[Unnamed Tab]\".

            - tabsetClassName (string; optional):

                class applied to parent tabset when this is the only tab and

                it is stretched to fill the tabset  Default: undefined.

            - type (string; optional):

                Fixed value: \"tab\".

        - autoSelectTabWhenClosed (boolean; optional):

            whether to select new/moved tabs in border when the border is

            currently closed  Default: inherited from Global attribute

            borderAutoSelectTabWhenClosed (default False).

        - autoSelectTabWhenOpen (boolean; optional):

            whether to select new/moved tabs in border when the border is

            already open  Default: inherited from Global attribute

            borderAutoSelectTabWhenOpen (default True).

        - className (string; optional):

            class applied to tab button  Default: inherited from Global

            attribute borderClassName (default undefined).

        - config (boolean | number | string | dict | list; optional):

            a place to hold json config used in your own code  Default:

            undefined.

        - enableAutoHide (boolean; optional):

            hide border if it has zero tabs  Default: inherited from

            Global attribute borderEnableAutoHide (default False).

        - enableDrop (boolean; optional):

            whether tabs can be dropped into this border  Default:

            inherited from Global attribute borderEnableDrop (default

            True).

        - enableTabScrollbar (boolean; optional):

            whether to show a mini scrollbar for the tabs  Default:

            inherited from Global attribute borderEnableTabScrollbar

            (default False).

        - maxSize (number; optional):

            the maximum size of the tab area  Default: inherited from

            Global attribute borderMaxSize (default 99999).

        - minSize (number; optional):

            the minimum size of the tab area  Default: inherited from

            Global attribute borderMinSize (default 0).

        - selected (number; optional):

            index of selected/visible tab in border; -1 means no tab

            selected  Default: -1.

        - show (boolean; optional):

            show/hide this border  Default: True.

        - size (number; optional):

            size of the tab area when selected  Default: inherited from

            Global attribute borderSize (default 200).

        - type (string; optional):

            Fixed value: \"border\".

    - layout (dict; required)

        `layout` is a dict with keys:

        - children (list of boolean | number | string | dict | lists; required)

        - id (string; optional):
            the unique id of the row, if left undefined a uuid will be
            assigned  Default: undefined.

        - type (string; optional):
            Fixed value: \"row\".

        - weight (number; optional):
            relative weight for sizing of this row in parent row
            Default: 100.

    - popouts (dict; optional)

        `popouts` is a dict with keys:


- popoutURL (string; default '/assets/popout.html'):
    URL of popout window relative to origin, defaults to popout.html.

- realtimeResize (boolean; optional):
    Boolean value, defaults to False, resize tabs as splitters are
    dragged. Warning: this can cause resizing to become choppy when
    tabs are slow to draw.

- supportsPopout (boolean; optional):
    If left undefined will do simple check based on userAgent.

- useStateForModel (boolean; default False):
    Flag that we should use internal state to manage the layout. If
    the layout is not being used by dash anywhere (for example, saving
    and re-hydrating the layout), it is more efficient to use the
    internal state (as this limits the number of round trips between
    JSON and the Model object).  WARNING: If you set this, do not
    expect the dash property `model` to reflect the current state of
    the layout!."""
    _children_props: typing.List[str] = ['headers{}']
    _base_nodes = ['children']
    _namespace = 'dash_flex_layout'
    _type = 'DashFlexLayout'
    ModelGlobal = TypedDict(
        "ModelGlobal",
            {
            "borderAutoSelectTabWhenClosed": NotRequired[bool],
            "borderAutoSelectTabWhenOpen": NotRequired[bool],
            "borderClassName": NotRequired[str],
            "borderEnableAutoHide": NotRequired[bool],
            "borderEnableDrop": NotRequired[bool],
            "borderEnableTabScrollbar": NotRequired[bool],
            "borderMaxSize": NotRequired[NumberType],
            "borderMinSize": NotRequired[NumberType],
            "borderSize": NotRequired[NumberType],
            "enableEdgeDock": NotRequired[bool],
            "enableRotateBorderIcons": NotRequired[bool],
            "rootOrientationVertical": NotRequired[bool],
            "splitterEnableHandle": NotRequired[bool],
            "splitterExtra": NotRequired[NumberType],
            "splitterSize": NotRequired[NumberType],
            "tabBorderHeight": NotRequired[NumberType],
            "tabBorderWidth": NotRequired[NumberType],
            "tabClassName": NotRequired[str],
            "tabCloseType": NotRequired[Literal[1, 2, 3]],
            "tabContentClassName": NotRequired[str],
            "tabDragSpeed": NotRequired[NumberType],
            "tabEnableClose": NotRequired[bool],
            "tabEnableDrag": NotRequired[bool],
            "tabEnablePopout": NotRequired[bool],
            "tabEnablePopoutIcon": NotRequired[bool],
            "tabEnablePopoutOverlay": NotRequired[bool],
            "tabEnableRename": NotRequired[bool],
            "tabEnableRenderOnDemand": NotRequired[bool],
            "tabIcon": NotRequired[str],
            "tabMaxHeight": NotRequired[NumberType],
            "tabMaxWidth": NotRequired[NumberType],
            "tabMinHeight": NotRequired[NumberType],
            "tabMinWidth": NotRequired[NumberType],
            "tabSetAutoSelectTab": NotRequired[bool],
            "tabSetClassNameTabStrip": NotRequired[str],
            "tabSetEnableActiveIcon": NotRequired[bool],
            "tabSetEnableClose": NotRequired[bool],
            "tabSetEnableDeleteWhenEmpty": NotRequired[bool],
            "tabSetEnableDivide": NotRequired[bool],
            "tabSetEnableDrag": NotRequired[bool],
            "tabSetEnableDrop": NotRequired[bool],
            "tabSetEnableMaximize": NotRequired[bool],
            "tabSetEnableSingleTabStretch": NotRequired[bool],
            "tabSetEnableTabScrollbar": NotRequired[bool],
            "tabSetEnableTabStrip": NotRequired[bool],
            "tabSetEnableTabWrap": NotRequired[bool],
            "tabSetMaxHeight": NotRequired[NumberType],
            "tabSetMaxWidth": NotRequired[NumberType],
            "tabSetMinHeight": NotRequired[NumberType],
            "tabSetMinWidth": NotRequired[NumberType],
            "tabSetTabLocation": NotRequired[Literal["top", "bottom"]]
        }
    )

    ModelBordersChildren = TypedDict(
        "ModelBordersChildren",
            {
            "altName": NotRequired[str],
            "borderHeight": NotRequired[NumberType],
            "borderWidth": NotRequired[NumberType],
            "className": NotRequired[str],
            "closeType": NotRequired[Literal[1, 2, 3]],
            "component": NotRequired[str],
            "config": NotRequired[typing.Any],
            "contentClassName": NotRequired[str],
            "enableClose": NotRequired[bool],
            "enableDrag": NotRequired[bool],
            "enablePopout": NotRequired[bool],
            "enablePopoutIcon": NotRequired[bool],
            "enablePopoutOverlay": NotRequired[bool],
            "enableRename": NotRequired[bool],
            "enableRenderOnDemand": NotRequired[bool],
            "enableWindowReMount": NotRequired[bool],
            "helpText": NotRequired[str],
            "icon": NotRequired[str],
            "id": NotRequired[str],
            "maxHeight": NotRequired[NumberType],
            "maxWidth": NotRequired[NumberType],
            "minHeight": NotRequired[NumberType],
            "minWidth": NotRequired[NumberType],
            "name": NotRequired[str],
            "tabsetClassName": NotRequired[str],
            "type": NotRequired[str]
        }
    )

    ModelBorders = TypedDict(
        "ModelBorders",
            {
            "location": Literal["top", "bottom", "left", "right"],
            "children": typing.Sequence["ModelBordersChildren"],
            "autoSelectTabWhenClosed": NotRequired[bool],
            "autoSelectTabWhenOpen": NotRequired[bool],
            "className": NotRequired[str],
            "config": NotRequired[typing.Any],
            "enableAutoHide": NotRequired[bool],
            "enableDrop": NotRequired[bool],
            "enableTabScrollbar": NotRequired[bool],
            "maxSize": NotRequired[NumberType],
            "minSize": NotRequired[NumberType],
            "selected": NotRequired[NumberType],
            "show": NotRequired[bool],
            "size": NotRequired[NumberType],
            "type": NotRequired[str]
        }
    )

    ModelLayout = TypedDict(
        "ModelLayout",
            {
            "children": typing.Sequence[typing.Union[typing.Any]],
            "id": NotRequired[str],
            "type": NotRequired[str],
            "weight": NotRequired[NumberType]
        }
    )

    ModelPopouts = TypedDict(
        "ModelPopouts",
            {

        }
    )

    Model = TypedDict(
        "Model",
            {
            "global": NotRequired["ModelGlobal"],
            "borders": NotRequired[typing.Sequence["ModelBorders"]],
            "layout": "ModelLayout",
            "popouts": NotRequired["ModelPopouts"]
        }
    )

    LoadingState = TypedDict(
        "LoadingState",
            {
            "is_loading": bool,
            "component_name": str,
            "prop_name": str
        }
    )


    def __init__(
        self,
        children: typing.Optional[ComponentType] = None,
        id: typing.Optional[typing.Union[str, dict]] = None,
        font: typing.Optional[typing.Any] = None,
        supportsPopout: typing.Optional[bool] = None,
        popoutURL: typing.Optional[str] = None,
        realtimeResize: typing.Optional[bool] = None,
        model: typing.Optional["Model"] = None,
        headers: typing.Optional[typing.Dict[typing.Union[str, float, int], ComponentType]] = None,
        useStateForModel: typing.Optional[bool] = None,
        debugMode: typing.Optional[bool] = None,
        colorScheme: typing.Optional[Literal["light", "dark"]] = None,
        style: typing.Optional[typing.Any] = None,
        loading_state: typing.Optional["LoadingState"] = None,
        **kwargs
    ):
        self._prop_names = ['children', 'id', 'colorScheme', 'debugMode', 'font', 'headers', 'loading_state', 'model', 'popoutURL', 'realtimeResize', 'style', 'supportsPopout', 'useStateForModel']
        self._valid_wildcard_attributes =            []
        self.available_properties = ['children', 'id', 'colorScheme', 'debugMode', 'font', 'headers', 'loading_state', 'model', 'popoutURL', 'realtimeResize', 'style', 'supportsPopout', 'useStateForModel']
        self.available_wildcard_properties =            []
        _explicit_args = kwargs.pop('_explicit_args')
        _locals = locals()
        _locals.update(kwargs)  # For wildcard attrs and excess named props
        args = {k: _locals[k] for k in _explicit_args if k != 'children'}

        for k in ['model']:
            if k not in args:
                raise TypeError(
                    'Required argument `' + k + '` was not specified.')

        if 'children' not in _explicit_args:
            raise TypeError('Required argument children was not specified.')

        super(DashFlexLayout, self).__init__(children=children, **args)

setattr(DashFlexLayout, "__init__", _explicitize_args(DashFlexLayout.__init__))
