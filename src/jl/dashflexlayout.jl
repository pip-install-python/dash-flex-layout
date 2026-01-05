# AUTO GENERATED FILE - DO NOT EDIT

export dashflexlayout

"""
    dashflexlayout(;kwargs...)
    dashflexlayout(children::Any;kwargs...)
    dashflexlayout(children_maker::Function;kwargs...)


A DashFlexLayout component.
DashFlexLayout is a wrapper around FlexLayout-React that provides
flexible docking windows for Dash applications.
*
Features:
- Dockable, resizable, and floatable window panels
- Drag-and-drop tab management
- Seamless Mantine theme integration (light/dark mode)
- Dash 2 and Dash 3 compatibility
Keyword arguments:
- `children` (a list of or a singular dash component, string or number; required): List of children to be rendered. Children are allocated to their respective tab
based on the ID of the element.

WARNING: There is no validation done on whether the children here will be rendered in any tab.
If there is no matching tab for a particular ID, that element will be silently ignored in
rendering (although callbacks will still be applied).
- `id` (String; optional): Unique ID to identify this component in Dash callbacks.
- `colorScheme` (a value equal to: 'light', 'dark'; optional): Current color scheme, automatically detected from Mantine theme
If not specified, will try to auto-detect from HTML data-mantine-color-scheme
- `debugMode` (Bool; optional): Debug mode flag
- `font` (Bool | Real | String | Dict | Array; optional): The tab font (overrides value in css).
Example: font={{size:"12px", style:"italic"}}
- `headers` (Dict with Strings as keys and values of type a list of or a singular dash component, string or number; optional): Map of headers to render for each tab. Uses the `onRenderTab` function to override
the default headers, where a custom header mapping is supplied.

Note: where possible, it is likely better to use classes to style the headers, rather than
using this prop.
- `loading_state` (optional): Loading state.. loading_state has the following type: lists containing elements 'is_loading', 'component_name', 'prop_name'.
Those elements have the following types:
  - `is_loading` (Bool; required)
  - `component_name` (String; required)
  - `prop_name` (String; required)
- `model` (required): Model layout.. model has the following type: lists containing elements 'global', 'borders', 'layout', 'popouts'.
Those elements have the following types:
  - `global` (optional): . global has the following type: lists containing elements 'borderAutoSelectTabWhenClosed', 'borderAutoSelectTabWhenOpen', 'borderClassName', 'borderEnableAutoHide', 'borderEnableDrop', 'borderEnableTabScrollbar', 'borderMaxSize', 'borderMinSize', 'borderSize', 'enableEdgeDock', 'enableRotateBorderIcons', 'rootOrientationVertical', 'splitterEnableHandle', 'splitterExtra', 'splitterSize', 'tabBorderHeight', 'tabBorderWidth', 'tabClassName', 'tabCloseType', 'tabContentClassName', 'tabDragSpeed', 'tabEnableClose', 'tabEnableDrag', 'tabEnablePopout', 'tabEnablePopoutIcon', 'tabEnablePopoutOverlay', 'tabEnableRename', 'tabEnableRenderOnDemand', 'tabIcon', 'tabMaxHeight', 'tabMaxWidth', 'tabMinHeight', 'tabMinWidth', 'tabSetAutoSelectTab', 'tabSetClassNameTabStrip', 'tabSetEnableActiveIcon', 'tabSetEnableClose', 'tabSetEnableDeleteWhenEmpty', 'tabSetEnableDivide', 'tabSetEnableDrag', 'tabSetEnableDrop', 'tabSetEnableMaximize', 'tabSetEnableSingleTabStretch', 'tabSetEnableTabScrollbar', 'tabSetEnableTabStrip', 'tabSetEnableTabWrap', 'tabSetMaxHeight', 'tabSetMaxWidth', 'tabSetMinHeight', 'tabSetMinWidth', 'tabSetTabLocation'.
Those elements have the following types:
  - `borderAutoSelectTabWhenClosed` (Bool; optional): Value for BorderNode attribute autoSelectTabWhenClosed if not overridden

whether to select new/moved tabs in border when the border is currently closed

Default: false
  - `borderAutoSelectTabWhenOpen` (Bool; optional): Value for BorderNode attribute autoSelectTabWhenOpen if not overridden

whether to select new/moved tabs in border when the border is already open

Default: true
  - `borderClassName` (String; optional): Value for BorderNode attribute className if not overridden

class applied to tab button

Default: undefined
  - `borderEnableAutoHide` (Bool; optional): Value for BorderNode attribute enableAutoHide if not overridden

hide border if it has zero tabs

Default: false
  - `borderEnableDrop` (Bool; optional): Value for BorderNode attribute enableDrop if not overridden

whether tabs can be dropped into this border

Default: true
  - `borderEnableTabScrollbar` (Bool; optional): Value for BorderNode attribute enableTabScrollbar if not overridden

whether to show a mini scrollbar for the tabs

Default: false
  - `borderMaxSize` (Real; optional): Value for BorderNode attribute maxSize if not overridden

the maximum size of the tab area

Default: 99999
  - `borderMinSize` (Real; optional): Value for BorderNode attribute minSize if not overridden

the minimum size of the tab area

Default: 0
  - `borderSize` (Real; optional): Value for BorderNode attribute size if not overridden

size of the tab area when selected

Default: 200
  - `enableEdgeDock` (Bool; optional): enable docking to the edges of the layout, this will show the edge indicators

Default: true
  - `enableRotateBorderIcons` (Bool; optional): boolean indicating if tab icons should rotate with the text in the left and right borders

Default: true
  - `rootOrientationVertical` (Bool; optional): the top level 'row' will layout horizontally by default, set this option true to make it layout vertically

Default: false
  - `splitterEnableHandle` (Bool; optional): enable a small centralized handle on all splitters

Default: false
  - `splitterExtra` (Real; optional): additional width in pixels of the splitter hit test area

Default: 0
  - `splitterSize` (Real; optional): width in pixels of all splitters between tabsets/borders

Default: 8
  - `tabBorderHeight` (Real; optional): Value for TabNode attribute borderHeight if not overridden

height when added to border, -1 will use border size

Default: -1
  - `tabBorderWidth` (Real; optional): Value for TabNode attribute borderWidth if not overridden

width when added to border, -1 will use border size

Default: -1
  - `tabClassName` (String; optional): Value for TabNode attribute className if not overridden

class applied to tab button

Default: undefined
  - `tabCloseType` (a value equal to: 1, 2, 3; optional): Value for TabNode attribute closeType if not overridden

see values in ICloseType

Default: 1
  - `tabContentClassName` (String; optional): Value for TabNode attribute contentClassName if not overridden

class applied to tab content

Default: undefined
  - `tabDragSpeed` (Real; optional): 

Default: 0.3
  - `tabEnableClose` (Bool; optional): Value for TabNode attribute enableClose if not overridden

allow user to close tab via close button

Default: true
  - `tabEnableDrag` (Bool; optional): Value for TabNode attribute enableDrag if not overridden

allow user to drag tab to new location

Default: true
  - `tabEnablePopout` (Bool; optional): Value for TabNode attribute enablePopout if not overridden

enable popout (in popout capable browser)

Default: false
  - `tabEnablePopoutIcon` (Bool; optional): Value for TabNode attribute enablePopoutIcon if not overridden

whether to show the popout icon in the tabset header if this tab enables popouts

Default: true
  - `tabEnablePopoutOverlay` (Bool; optional): Value for TabNode attribute enablePopoutOverlay if not overridden

if this tab will not work correctly in a popout window when the main window is backgrounded (inactive)
      then enabling this option will gray out this tab

Default: false
  - `tabEnableRename` (Bool; optional): Value for TabNode attribute enableRename if not overridden

allow user to rename tabs by double clicking

Default: true
  - `tabEnableRenderOnDemand` (Bool; optional): Value for TabNode attribute enableRenderOnDemand if not overridden

whether to avoid rendering component until tab is visible

Default: true
  - `tabIcon` (String; optional): Value for TabNode attribute icon if not overridden

the tab icon

Default: undefined
  - `tabMaxHeight` (Real; optional): Value for TabNode attribute maxHeight if not overridden

the max height of this tab

Default: 99999
  - `tabMaxWidth` (Real; optional): Value for TabNode attribute maxWidth if not overridden

the max width of this tab

Default: 99999
  - `tabMinHeight` (Real; optional): Value for TabNode attribute minHeight if not overridden

the min height of this tab

Default: 0
  - `tabMinWidth` (Real; optional): Value for TabNode attribute minWidth if not overridden

the min width of this tab

Default: 0
  - `tabSetAutoSelectTab` (Bool; optional): Value for TabSetNode attribute autoSelectTab if not overridden

whether to select new/moved tabs in tabset

Default: true
  - `tabSetClassNameTabStrip` (String; optional): Value for TabSetNode attribute classNameTabStrip if not overridden

a class name to apply to the tab strip

Default: undefined
  - `tabSetEnableActiveIcon` (Bool; optional): Value for TabSetNode attribute enableActiveIcon if not overridden

whether the active icon (*) should be displayed when the tabset is active

Default: false
  - `tabSetEnableClose` (Bool; optional): Value for TabSetNode attribute enableClose if not overridden

allow user to close tabset via a close button

Default: false
  - `tabSetEnableDeleteWhenEmpty` (Bool; optional): Value for TabSetNode attribute enableDeleteWhenEmpty if not overridden

whether to delete this tabset when is has no tabs

Default: true
  - `tabSetEnableDivide` (Bool; optional): Value for TabSetNode attribute enableDivide if not overridden

allow user to drag tabs to region of this tabset, splitting into new tabset

Default: true
  - `tabSetEnableDrag` (Bool; optional): Value for TabSetNode attribute enableDrag if not overridden

allow user to drag tabs out this tabset

Default: true
  - `tabSetEnableDrop` (Bool; optional): Value for TabSetNode attribute enableDrop if not overridden

allow user to drag tabs into this tabset

Default: true
  - `tabSetEnableMaximize` (Bool; optional): Value for TabSetNode attribute enableMaximize if not overridden

allow user to maximize tabset to fill view via maximize button

Default: true
  - `tabSetEnableSingleTabStretch` (Bool; optional): Value for TabSetNode attribute enableSingleTabStretch if not overridden

if the tabset has only a single tab then stretch the single tab to fill area and display in a header style

Default: false
  - `tabSetEnableTabScrollbar` (Bool; optional): Value for TabSetNode attribute enableTabScrollbar if not overridden

whether to show a mini scrollbar for the tabs

Default: false
  - `tabSetEnableTabStrip` (Bool; optional): Value for TabSetNode attribute enableTabStrip if not overridden

enable tab strip and allow multiple tabs in this tabset

Default: true
  - `tabSetEnableTabWrap` (Bool; optional): Value for TabSetNode attribute enableTabWrap if not overridden

wrap tabs onto multiple lines

Default: false
  - `tabSetMaxHeight` (Real; optional): Value for TabSetNode attribute maxHeight if not overridden

maximum height (in px) for this tabset

Default: 99999
  - `tabSetMaxWidth` (Real; optional): Value for TabSetNode attribute maxWidth if not overridden

maximum width (in px) for this tabset

Default: 99999
  - `tabSetMinHeight` (Real; optional): Value for TabSetNode attribute minHeight if not overridden

minimum height (in px) for this tabset

Default: 0
  - `tabSetMinWidth` (Real; optional): Value for TabSetNode attribute minWidth if not overridden

minimum width (in px) for this tabset

Default: 0
  - `tabSetTabLocation` (a value equal to: 'top', 'bottom'; optional): Value for TabSetNode attribute tabLocation if not overridden

the location of the tabs either top or bottom

Default: "top"
  - `borders` (optional): . borders has the following type: Array of lists containing elements 'location', 'children', 'autoSelectTabWhenClosed', 'autoSelectTabWhenOpen', 'className', 'config', 'enableAutoHide', 'enableDrop', 'enableTabScrollbar', 'maxSize', 'minSize', 'selected', 'show', 'size', 'type'.
Those elements have the following types:
  - `location` (a value equal to: 'top', 'bottom', 'left', 'right'; required)
  - `children` (required): . children has the following type: Array of lists containing elements 'altName', 'borderHeight', 'borderWidth', 'className', 'closeType', 'component', 'config', 'contentClassName', 'enableClose', 'enableDrag', 'enablePopout', 'enablePopoutIcon', 'enablePopoutOverlay', 'enableRename', 'enableRenderOnDemand', 'enableWindowReMount', 'helpText', 'icon', 'id', 'maxHeight', 'maxWidth', 'minHeight', 'minWidth', 'name', 'tabsetClassName', 'type'.
Those elements have the following types:
  - `altName` (String; optional): if there is no name specifed then this value will be used in the overflow menu

Default: undefined
  - `borderHeight` (Real; optional): height when added to border, -1 will use border size

Default: inherited from Global attribute tabBorderHeight (default -1)
  - `borderWidth` (Real; optional): width when added to border, -1 will use border size

Default: inherited from Global attribute tabBorderWidth (default -1)
  - `className` (String; optional): class applied to tab button

Default: inherited from Global attribute tabClassName (default undefined)
  - `closeType` (a value equal to: 1, 2, 3; optional): see values in ICloseType

Default: inherited from Global attribute tabCloseType (default 1)
  - `component` (String; optional): string identifying which component to run (for factory)

Default: undefined
  - `config` (Bool | Real | String | Dict | Array; optional): a place to hold json config for the hosted component

Default: undefined
  - `contentClassName` (String; optional): class applied to tab content

Default: inherited from Global attribute tabContentClassName (default undefined)
  - `enableClose` (Bool; optional): allow user to close tab via close button

Default: inherited from Global attribute tabEnableClose (default true)
  - `enableDrag` (Bool; optional): allow user to drag tab to new location

Default: inherited from Global attribute tabEnableDrag (default true)
  - `enablePopout` (Bool; optional): enable popout (in popout capable browser)

Default: inherited from Global attribute tabEnablePopout (default false)
  - `enablePopoutIcon` (Bool; optional): whether to show the popout icon in the tabset header if this tab enables popouts

Default: inherited from Global attribute tabEnablePopoutIcon (default true)
  - `enablePopoutOverlay` (Bool; optional): if this tab will not work correctly in a popout window when the main window is backgrounded (inactive)
      then enabling this option will gray out this tab

Default: inherited from Global attribute tabEnablePopoutOverlay (default false)
  - `enableRename` (Bool; optional): allow user to rename tabs by double clicking

Default: inherited from Global attribute tabEnableRename (default true)
  - `enableRenderOnDemand` (Bool; optional): whether to avoid rendering component until tab is visible

Default: inherited from Global attribute tabEnableRenderOnDemand (default true)
  - `enableWindowReMount` (Bool; optional): if enabled the tab will re-mount when popped out/in

Default: false
  - `helpText` (String; optional): An optional help text for the tab to be displayed upon tab hover.

Default: undefined
  - `icon` (String; optional): the tab icon

Default: inherited from Global attribute tabIcon (default undefined)
  - `id` (String; optional): the unique id of the tab, if left undefined a uuid will be assigned

Default: undefined
  - `maxHeight` (Real; optional): the max height of this tab

Default: inherited from Global attribute tabMaxHeight (default 99999)
  - `maxWidth` (Real; optional): the max width of this tab

Default: inherited from Global attribute tabMaxWidth (default 99999)
  - `minHeight` (Real; optional): the min height of this tab

Default: inherited from Global attribute tabMinHeight (default 0)
  - `minWidth` (Real; optional): the min width of this tab

Default: inherited from Global attribute tabMinWidth (default 0)
  - `name` (String; optional): name of tab to be displayed in the tab button

Default: "[Unnamed Tab]"
  - `tabsetClassName` (String; optional): class applied to parent tabset when this is the only tab and it is stretched to fill the tabset

Default: undefined
  - `type` (String; optional): 

Fixed value: "tab"s
  - `autoSelectTabWhenClosed` (Bool; optional): whether to select new/moved tabs in border when the border is currently closed

Default: inherited from Global attribute borderAutoSelectTabWhenClosed (default false)
  - `autoSelectTabWhenOpen` (Bool; optional): whether to select new/moved tabs in border when the border is already open

Default: inherited from Global attribute borderAutoSelectTabWhenOpen (default true)
  - `className` (String; optional): class applied to tab button

Default: inherited from Global attribute borderClassName (default undefined)
  - `config` (Bool | Real | String | Dict | Array; optional): a place to hold json config used in your own code

Default: undefined
  - `enableAutoHide` (Bool; optional): hide border if it has zero tabs

Default: inherited from Global attribute borderEnableAutoHide (default false)
  - `enableDrop` (Bool; optional): whether tabs can be dropped into this border

Default: inherited from Global attribute borderEnableDrop (default true)
  - `enableTabScrollbar` (Bool; optional): whether to show a mini scrollbar for the tabs

Default: inherited from Global attribute borderEnableTabScrollbar (default false)
  - `maxSize` (Real; optional): the maximum size of the tab area

Default: inherited from Global attribute borderMaxSize (default 99999)
  - `minSize` (Real; optional): the minimum size of the tab area

Default: inherited from Global attribute borderMinSize (default 0)
  - `selected` (Real; optional): index of selected/visible tab in border; -1 means no tab selected

Default: -1
  - `show` (Bool; optional): show/hide this border

Default: true
  - `size` (Real; optional): size of the tab area when selected

Default: inherited from Global attribute borderSize (default 200)
  - `type` (String; optional): 

Fixed value: "border"s
  - `layout` (required): . layout has the following type: lists containing elements 'children', 'id', 'type', 'weight'.
Those elements have the following types:
  - `children` (Array of Bool | Real | String | Dict | Arrays; required)
  - `id` (String; optional): the unique id of the row, if left undefined a uuid will be assigned

Default: undefined
  - `type` (String; optional): 

Fixed value: "row"
  - `weight` (Real; optional): relative weight for sizing of this row in parent row

Default: 100
  - `popouts` (optional): . popouts has the following type: lists containing elements .
Those elements have the following types:

- `popoutURL` (String; optional): URL of popout window relative to origin, defaults to popout.html
- `realtimeResize` (Bool; optional): Boolean value, defaults to false, resize tabs as splitters are dragged.
Warning: this can cause resizing to become choppy when tabs are slow to draw
- `style` (optional): CSS styles to apply to the root container element. style has the following type: lists containing elements 'accentColor', 'alignContent', 'alignItems', 'alignSelf', 'alignTracks', 'alignmentBaseline', 'anchorName', 'anchorScope', 'animationComposition', 'animationDelay', 'animationDirection', 'animationDuration', 'animationFillMode', 'animationIterationCount', 'animationName', 'animationPlayState', 'animationRangeEnd', 'animationRangeStart', 'animationTimeline', 'animationTimingFunction', 'appearance', 'aspectRatio', 'backdropFilter', 'backfaceVisibility', 'backgroundAttachment', 'backgroundBlendMode', 'backgroundClip', 'backgroundColor', 'backgroundImage', 'backgroundOrigin', 'backgroundPositionX', 'backgroundPositionY', 'backgroundRepeat', 'backgroundSize', 'baselineShift', 'blockSize', 'borderBlockEndColor', 'borderBlockEndStyle', 'borderBlockEndWidth', 'borderBlockStartColor', 'borderBlockStartStyle', 'borderBlockStartWidth', 'borderBottomColor', 'borderBottomLeftRadius', 'borderBottomRightRadius', 'borderBottomStyle', 'borderBottomWidth', 'borderCollapse', 'borderEndEndRadius', 'borderEndStartRadius', 'borderImageOutset', 'borderImageRepeat', 'borderImageSlice', 'borderImageSource', 'borderImageWidth', 'borderInlineEndColor', 'borderInlineEndStyle', 'borderInlineEndWidth', 'borderInlineStartColor', 'borderInlineStartStyle', 'borderInlineStartWidth', 'borderLeftColor', 'borderLeftStyle', 'borderLeftWidth', 'borderRightColor', 'borderRightStyle', 'borderRightWidth', 'borderSpacing', 'borderStartEndRadius', 'borderStartStartRadius', 'borderTopColor', 'borderTopLeftRadius', 'borderTopRightRadius', 'borderTopStyle', 'borderTopWidth', 'bottom', 'boxDecorationBreak', 'boxShadow', 'boxSizing', 'breakAfter', 'breakBefore', 'breakInside', 'captionSide', 'caretColor', 'caretShape', 'clear', 'clipPath', 'clipRule', 'color', 'colorAdjust', 'colorInterpolationFilters', 'colorScheme', 'columnCount', 'columnFill', 'columnGap', 'columnRuleColor', 'columnRuleStyle', 'columnRuleWidth', 'columnSpan', 'columnWidth', 'contain', 'containIntrinsicBlockSize', 'containIntrinsicHeight', 'containIntrinsicInlineSize', 'containIntrinsicWidth', 'containerName', 'containerType', 'content', 'contentVisibility', 'counterIncrement', 'counterReset', 'counterSet', 'cursor', 'cx', 'cy', 'd', 'direction', 'display', 'dominantBaseline', 'emptyCells', 'fieldSizing', 'fill', 'fillOpacity', 'fillRule', 'filter', 'flexBasis', 'flexDirection', 'flexGrow', 'flexShrink', 'flexWrap', 'float', 'floodColor', 'floodOpacity', 'fontFamily', 'fontFeatureSettings', 'fontKerning', 'fontLanguageOverride', 'fontOpticalSizing', 'fontPalette', 'fontSize', 'fontSizeAdjust', 'fontSmooth', 'fontStyle', 'fontSynthesis', 'fontSynthesisPosition', 'fontSynthesisSmallCaps', 'fontSynthesisStyle', 'fontSynthesisWeight', 'fontVariant', 'fontVariantAlternates', 'fontVariantCaps', 'fontVariantEastAsian', 'fontVariantEmoji', 'fontVariantLigatures', 'fontVariantNumeric', 'fontVariantPosition', 'fontVariationSettings', 'fontWeight', 'fontWidth', 'forcedColorAdjust', 'gridAutoColumns', 'gridAutoFlow', 'gridAutoRows', 'gridColumnEnd', 'gridColumnStart', 'gridRowEnd', 'gridRowStart', 'gridTemplateAreas', 'gridTemplateColumns', 'gridTemplateRows', 'hangingPunctuation', 'height', 'hyphenateCharacter', 'hyphenateLimitChars', 'hyphens', 'imageOrientation', 'imageRendering', 'imageResolution', 'initialLetter', 'initialLetterAlign', 'inlineSize', 'insetBlockEnd', 'insetBlockStart', 'insetInlineEnd', 'insetInlineStart', 'interpolateSize', 'isolation', 'justifyContent', 'justifyItems', 'justifySelf', 'justifyTracks', 'left', 'letterSpacing', 'lightingColor', 'lineBreak', 'lineHeight', 'lineHeightStep', 'listStyleImage', 'listStylePosition', 'listStyleType', 'marginBlockEnd', 'marginBlockStart', 'marginBottom', 'marginInlineEnd', 'marginInlineStart', 'marginLeft', 'marginRight', 'marginTop', 'marginTrim', 'marker', 'markerEnd', 'markerMid', 'markerStart', 'maskBorderMode', 'maskBorderOutset', 'maskBorderRepeat', 'maskBorderSlice', 'maskBorderSource', 'maskBorderWidth', 'maskClip', 'maskComposite', 'maskImage', 'maskMode', 'maskOrigin', 'maskPosition', 'maskRepeat', 'maskSize', 'maskType', 'masonryAutoFlow', 'mathDepth', 'mathShift', 'mathStyle', 'maxBlockSize', 'maxHeight', 'maxInlineSize', 'maxLines', 'maxWidth', 'minBlockSize', 'minHeight', 'minInlineSize', 'minWidth', 'mixBlendMode', 'motionDistance', 'motionPath', 'motionRotation', 'objectFit', 'objectPosition', 'objectViewBox', 'offsetAnchor', 'offsetDistance', 'offsetPath', 'offsetPosition', 'offsetRotate', 'offsetRotation', 'opacity', 'order', 'orphans', 'outlineColor', 'outlineOffset', 'outlineStyle', 'outlineWidth', 'overflowAnchor', 'overflowBlock', 'overflowClipBox', 'overflowClipMargin', 'overflowInline', 'overflowWrap', 'overflowX', 'overflowY', 'overlay', 'overscrollBehaviorBlock', 'overscrollBehaviorInline', 'overscrollBehaviorX', 'overscrollBehaviorY', 'paddingBlockEnd', 'paddingBlockStart', 'paddingBottom', 'paddingInlineEnd', 'paddingInlineStart', 'paddingLeft', 'paddingRight', 'paddingTop', 'page', 'paintOrder', 'perspective', 'perspectiveOrigin', 'pointerEvents', 'position', 'positionAnchor', 'positionArea', 'positionTryFallbacks', 'positionTryOrder', 'positionVisibility', 'printColorAdjust', 'quotes', 'r', 'resize', 'right', 'rotate', 'rowGap', 'rubyAlign', 'rubyMerge', 'rubyOverhang', 'rubyPosition', 'rx', 'ry', 'scale', 'scrollBehavior', 'scrollInitialTarget', 'scrollMarginBlockEnd', 'scrollMarginBlockStart', 'scrollMarginBottom', 'scrollMarginInlineEnd', 'scrollMarginInlineStart', 'scrollMarginLeft', 'scrollMarginRight', 'scrollMarginTop', 'scrollPaddingBlockEnd', 'scrollPaddingBlockStart', 'scrollPaddingBottom', 'scrollPaddingInlineEnd', 'scrollPaddingInlineStart', 'scrollPaddingLeft', 'scrollPaddingRight', 'scrollPaddingTop', 'scrollSnapAlign', 'scrollSnapMarginBottom', 'scrollSnapMarginLeft', 'scrollSnapMarginRight', 'scrollSnapMarginTop', 'scrollSnapStop', 'scrollSnapType', 'scrollTimelineAxis', 'scrollTimelineName', 'scrollbarColor', 'scrollbarGutter', 'scrollbarWidth', 'shapeImageThreshold', 'shapeMargin', 'shapeOutside', 'shapeRendering', 'speakAs', 'stopColor', 'stopOpacity', 'stroke', 'strokeColor', 'strokeDasharray', 'strokeDashoffset', 'strokeLinecap', 'strokeLinejoin', 'strokeMiterlimit', 'strokeOpacity', 'strokeWidth', 'tabSize', 'tableLayout', 'textAlign', 'textAlignLast', 'textAnchor', 'textAutospace', 'textBox', 'textBoxEdge', 'textBoxTrim', 'textCombineUpright', 'textDecorationColor', 'textDecorationLine', 'textDecorationSkip', 'textDecorationSkipInk', 'textDecorationStyle', 'textDecorationThickness', 'textEmphasisColor', 'textEmphasisPosition', 'textEmphasisStyle', 'textIndent', 'textJustify', 'textOrientation', 'textOverflow', 'textRendering', 'textShadow', 'textSizeAdjust', 'textSpacingTrim', 'textTransform', 'textUnderlineOffset', 'textUnderlinePosition', 'textWrapMode', 'textWrapStyle', 'timelineScope', 'top', 'touchAction', 'transform', 'transformBox', 'transformOrigin', 'transformStyle', 'transitionBehavior', 'transitionDelay', 'transitionDuration', 'transitionProperty', 'transitionTimingFunction', 'translate', 'unicodeBidi', 'userSelect', 'vectorEffect', 'verticalAlign', 'viewTimelineAxis', 'viewTimelineInset', 'viewTimelineName', 'viewTransitionClass', 'viewTransitionName', 'visibility', 'whiteSpace', 'whiteSpaceCollapse', 'widows', 'width', 'willChange', 'wordBreak', 'wordSpacing', 'wordWrap', 'writingMode', 'x', 'y', 'zIndex', 'zoom', 'all', 'animation', 'animationRange', 'background', 'backgroundPosition', 'border', 'borderBlock', 'borderBlockColor', 'borderBlockEnd', 'borderBlockStart', 'borderBlockStyle', 'borderBlockWidth', 'borderBottom', 'borderColor', 'borderImage', 'borderInline', 'borderInlineColor', 'borderInlineEnd', 'borderInlineStart', 'borderInlineStyle', 'borderInlineWidth', 'borderLeft', 'borderRadius', 'borderRight', 'borderStyle', 'borderTop', 'borderWidth', 'caret', 'columnRule', 'columns', 'containIntrinsicSize', 'container', 'flex', 'flexFlow', 'font', 'gap', 'grid', 'gridArea', 'gridColumn', 'gridRow', 'gridTemplate', 'inset', 'insetBlock', 'insetInline', 'lineClamp', 'listStyle', 'margin', 'marginBlock', 'marginInline', 'mask', 'maskBorder', 'motion', 'offset', 'outline', 'overflow', 'overscrollBehavior', 'padding', 'paddingBlock', 'paddingInline', 'placeContent', 'placeItems', 'placeSelf', 'positionTry', 'scrollMargin', 'scrollMarginBlock', 'scrollMarginInline', 'scrollPadding', 'scrollPaddingBlock', 'scrollPaddingInline', 'scrollSnapMargin', 'scrollTimeline', 'textDecoration', 'textEmphasis', 'textWrap', 'transition', 'viewTimeline', 'MozAnimationDelay', 'MozAnimationDirection', 'MozAnimationDuration', 'MozAnimationFillMode', 'MozAnimationIterationCount', 'MozAnimationName', 'MozAnimationPlayState', 'MozAnimationTimingFunction', 'MozAppearance', 'MozBackfaceVisibility', 'MozBinding', 'MozBorderBottomColors', 'MozBorderEndColor', 'MozBorderEndStyle', 'MozBorderEndWidth', 'MozBorderLeftColors', 'MozBorderRightColors', 'MozBorderStartColor', 'MozBorderStartStyle', 'MozBorderTopColors', 'MozBoxSizing', 'MozColumnRuleColor', 'MozColumnRuleStyle', 'MozColumnRuleWidth', 'MozColumnWidth', 'MozContextProperties', 'MozFontFeatureSettings', 'MozFontLanguageOverride', 'MozHyphens', 'MozMarginEnd', 'MozMarginStart', 'MozOrient', 'MozOsxFontSmoothing', 'MozOutlineRadiusBottomleft', 'MozOutlineRadiusBottomright', 'MozOutlineRadiusTopleft', 'MozOutlineRadiusTopright', 'MozPaddingEnd', 'MozPaddingStart', 'MozPerspective', 'MozPerspectiveOrigin', 'MozStackSizing', 'MozTabSize', 'MozTextBlink', 'MozTextSizeAdjust', 'MozTransform', 'MozTransformOrigin', 'MozTransformStyle', 'MozUserModify', 'MozUserSelect', 'MozWindowDragging', 'MozWindowShadow', 'msAccelerator', 'msBlockProgression', 'msContentZoomChaining', 'msContentZoomLimitMax', 'msContentZoomLimitMin', 'msContentZoomSnapPoints', 'msContentZoomSnapType', 'msContentZooming', 'msFilter', 'msFlexDirection', 'msFlexPositive', 'msFlowFrom', 'msFlowInto', 'msGridColumns', 'msGridRows', 'msHighContrastAdjust', 'msHyphenateLimitChars', 'msHyphenateLimitLines', 'msHyphenateLimitZone', 'msHyphens', 'msImeAlign', 'msLineBreak', 'msOrder', 'msOverflowStyle', 'msOverflowX', 'msOverflowY', 'msScrollChaining', 'msScrollLimitXMax', 'msScrollLimitXMin', 'msScrollLimitYMax', 'msScrollLimitYMin', 'msScrollRails', 'msScrollSnapPointsX', 'msScrollSnapPointsY', 'msScrollSnapType', 'msScrollTranslation', 'msScrollbar3dlightColor', 'msScrollbarArrowColor', 'msScrollbarBaseColor', 'msScrollbarDarkshadowColor', 'msScrollbarFaceColor', 'msScrollbarHighlightColor', 'msScrollbarShadowColor', 'msScrollbarTrackColor', 'msTextAutospace', 'msTextCombineHorizontal', 'msTextOverflow', 'msTouchAction', 'msTouchSelect', 'msTransform', 'msTransformOrigin', 'msTransitionDelay', 'msTransitionDuration', 'msTransitionProperty', 'msTransitionTimingFunction', 'msUserSelect', 'msWordBreak', 'msWrapFlow', 'msWrapMargin', 'msWrapThrough', 'msWritingMode', 'WebkitAlignContent', 'WebkitAlignItems', 'WebkitAlignSelf', 'WebkitAnimationDelay', 'WebkitAnimationDirection', 'WebkitAnimationDuration', 'WebkitAnimationFillMode', 'WebkitAnimationIterationCount', 'WebkitAnimationName', 'WebkitAnimationPlayState', 'WebkitAnimationTimingFunction', 'WebkitAppearance', 'WebkitBackdropFilter', 'WebkitBackfaceVisibility', 'WebkitBackgroundClip', 'WebkitBackgroundOrigin', 'WebkitBackgroundSize', 'WebkitBorderBeforeColor', 'WebkitBorderBeforeStyle', 'WebkitBorderBeforeWidth', 'WebkitBorderBottomLeftRadius', 'WebkitBorderBottomRightRadius', 'WebkitBorderImageSlice', 'WebkitBorderTopLeftRadius', 'WebkitBorderTopRightRadius', 'WebkitBoxDecorationBreak', 'WebkitBoxReflect', 'WebkitBoxShadow', 'WebkitBoxSizing', 'WebkitClipPath', 'WebkitColumnCount', 'WebkitColumnFill', 'WebkitColumnRuleColor', 'WebkitColumnRuleStyle', 'WebkitColumnRuleWidth', 'WebkitColumnSpan', 'WebkitColumnWidth', 'WebkitFilter', 'WebkitFlexBasis', 'WebkitFlexDirection', 'WebkitFlexGrow', 'WebkitFlexShrink', 'WebkitFlexWrap', 'WebkitFontFeatureSettings', 'WebkitFontKerning', 'WebkitFontSmoothing', 'WebkitFontVariantLigatures', 'WebkitHyphenateCharacter', 'WebkitHyphens', 'WebkitInitialLetter', 'WebkitJustifyContent', 'WebkitLineBreak', 'WebkitLineClamp', 'WebkitLogicalHeight', 'WebkitLogicalWidth', 'WebkitMarginEnd', 'WebkitMarginStart', 'WebkitMaskAttachment', 'WebkitMaskBoxImageOutset', 'WebkitMaskBoxImageRepeat', 'WebkitMaskBoxImageSlice', 'WebkitMaskBoxImageSource', 'WebkitMaskBoxImageWidth', 'WebkitMaskClip', 'WebkitMaskComposite', 'WebkitMaskImage', 'WebkitMaskOrigin', 'WebkitMaskPosition', 'WebkitMaskPositionX', 'WebkitMaskPositionY', 'WebkitMaskRepeat', 'WebkitMaskRepeatX', 'WebkitMaskRepeatY', 'WebkitMaskSize', 'WebkitMaxInlineSize', 'WebkitOrder', 'WebkitOverflowScrolling', 'WebkitPaddingEnd', 'WebkitPaddingStart', 'WebkitPerspective', 'WebkitPerspectiveOrigin', 'WebkitPrintColorAdjust', 'WebkitRubyPosition', 'WebkitScrollSnapType', 'WebkitShapeMargin', 'WebkitTapHighlightColor', 'WebkitTextCombine', 'WebkitTextDecorationColor', 'WebkitTextDecorationLine', 'WebkitTextDecorationSkip', 'WebkitTextDecorationStyle', 'WebkitTextEmphasisColor', 'WebkitTextEmphasisPosition', 'WebkitTextEmphasisStyle', 'WebkitTextFillColor', 'WebkitTextOrientation', 'WebkitTextSizeAdjust', 'WebkitTextStrokeColor', 'WebkitTextStrokeWidth', 'WebkitTextUnderlinePosition', 'WebkitTouchCallout', 'WebkitTransform', 'WebkitTransformOrigin', 'WebkitTransformStyle', 'WebkitTransitionDelay', 'WebkitTransitionDuration', 'WebkitTransitionProperty', 'WebkitTransitionTimingFunction', 'WebkitUserModify', 'WebkitUserSelect', 'WebkitWritingMode', 'MozAnimation', 'MozBorderImage', 'MozColumnRule', 'MozColumns', 'MozOutlineRadius', 'MozTransition', 'msContentZoomLimit', 'msContentZoomSnap', 'msFlex', 'msScrollLimit', 'msScrollSnapX', 'msScrollSnapY', 'msTransition', 'WebkitAnimation', 'WebkitBorderBefore', 'WebkitBorderImage', 'WebkitBorderRadius', 'WebkitColumnRule', 'WebkitColumns', 'WebkitFlex', 'WebkitFlexFlow', 'WebkitMask', 'WebkitMaskBoxImage', 'WebkitTextEmphasis', 'WebkitTextStroke', 'WebkitTransition', 'boxAlign', 'boxDirection', 'boxFlex', 'boxFlexGroup', 'boxLines', 'boxOrdinalGroup', 'boxOrient', 'boxPack', 'clip', 'fontStretch', 'gridColumnGap', 'gridGap', 'gridRowGap', 'imeMode', 'insetArea', 'offsetBlock', 'offsetBlockEnd', 'offsetBlockStart', 'offsetInline', 'offsetInlineEnd', 'offsetInlineStart', 'pageBreakAfter', 'pageBreakBefore', 'pageBreakInside', 'positionTryOptions', 'scrollSnapCoordinate', 'scrollSnapDestination', 'scrollSnapPointsX', 'scrollSnapPointsY', 'scrollSnapTypeX', 'scrollSnapTypeY', 'KhtmlBoxAlign', 'KhtmlBoxDirection', 'KhtmlBoxFlex', 'KhtmlBoxFlexGroup', 'KhtmlBoxLines', 'KhtmlBoxOrdinalGroup', 'KhtmlBoxOrient', 'KhtmlBoxPack', 'KhtmlLineBreak', 'KhtmlOpacity', 'KhtmlUserSelect', 'MozBackgroundClip', 'MozBackgroundOrigin', 'MozBackgroundSize', 'MozBorderRadius', 'MozBorderRadiusBottomleft', 'MozBorderRadiusBottomright', 'MozBorderRadiusTopleft', 'MozBorderRadiusTopright', 'MozBoxAlign', 'MozBoxDirection', 'MozBoxFlex', 'MozBoxOrdinalGroup', 'MozBoxOrient', 'MozBoxPack', 'MozBoxShadow', 'MozColumnCount', 'MozColumnFill', 'MozFloatEdge', 'MozForceBrokenImageIcon', 'MozOpacity', 'MozOutline', 'MozOutlineColor', 'MozOutlineStyle', 'MozOutlineWidth', 'MozTextAlignLast', 'MozTextDecorationColor', 'MozTextDecorationLine', 'MozTextDecorationStyle', 'MozTransitionDelay', 'MozTransitionDuration', 'MozTransitionProperty', 'MozTransitionTimingFunction', 'MozUserFocus', 'MozUserInput', 'msImeMode', 'OAnimation', 'OAnimationDelay', 'OAnimationDirection', 'OAnimationDuration', 'OAnimationFillMode', 'OAnimationIterationCount', 'OAnimationName', 'OAnimationPlayState', 'OAnimationTimingFunction', 'OBackgroundSize', 'OBorderImage', 'OObjectFit', 'OObjectPosition', 'OTabSize', 'OTextOverflow', 'OTransform', 'OTransformOrigin', 'OTransition', 'OTransitionDelay', 'OTransitionDuration', 'OTransitionProperty', 'OTransitionTimingFunction', 'WebkitBoxAlign', 'WebkitBoxDirection', 'WebkitBoxFlex', 'WebkitBoxFlexGroup', 'WebkitBoxLines', 'WebkitBoxOrdinalGroup', 'WebkitBoxOrient', 'WebkitBoxPack', 'colorInterpolation', 'colorRendering', 'glyphOrientationVertical'.
Those elements have the following types:
  - `accentColor` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | <color>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **93** | **92**  | **15.4** | **93** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/accent-color
  - `alignContent` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position>`

**Initial value**: `normal`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/align-content
  - `alignItems` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | stretch | <baseline-position> | [ <overflow-position>? <self-position> ] | anchor-center`

**Initial value**: `normal`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/align-items
  - `alignSelf` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? <self-position> | anchor-center`

**Initial value**: `auto`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **10** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/align-self
  - `alignTracks` (optional): **Syntax**: `[ normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position> ]#`

**Initial value**: `normal`
  - `alignmentBaseline` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'baseline', 'alphabetic', 'central', 'ideographic', 'mathematical', 'middle', 'text-after-edge', 'text-before-edge'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `baseline | alphabetic | ideographic | middle | central | mathematical | text-before-edge | text-after-edge`

**Initial value**: `baseline`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **1**  |   No    | **5.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/alignment-baseline
  - `anchorName` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <dashed-ident>#`

**Initial value**: `none`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/anchor-name
  - `anchorScope` (optional): **Syntax**: `none | all | <dashed-ident>#`

**Initial value**: `none`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **131** | **preview** | **26** | **131** | No  |
  - `animationComposition` (optional): Since July 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<single-animation-composition>#`

**Initial value**: `replace`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **112** | **115** | **16** | **112** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-composition
  - `animationDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-delay
  - `animationDirection` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-direction>#`

**Initial value**: `normal`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-direction
  - `animationDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ auto | <time [0s,∞]> ]#`

**Initial value**: `0s`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-duration
  - `animationFillMode` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-fill-mode>#`

**Initial value**: `none`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 5 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-fill-mode
  - `animationIterationCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-iteration-count>#`

**Initial value**: `1`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-iteration-count
  - `animationName` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ none | <keyframes-name> ]#`

**Initial value**: `none`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-name
  - `animationPlayState` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-play-state>#`

**Initial value**: `running`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-play-state
  - `animationRangeEnd` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ normal | <length-percentage> | <timeline-range-name> <length-percentage>? ]#`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-range-end
  - `animationRangeStart` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ normal | <length-percentage> | <timeline-range-name> <length-percentage>? ]#`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-range-start
  - `animationTimeline` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<single-animation-timeline>#`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-timeline
  - `animationTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-timing-function
  - `appearance` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'meter', 'progress-bar', 'radio', 'searchfield', 'textarea', 'menulist-button', 'textfield'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | auto | <compat-auto> | <compat-special>`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |   Edge   | IE  |
| :-----: | :-----: | :------: | :------: | :-: |
| **84**  | **80**  | **15.4** |  **84**  | No  |
| 1 _-x-_ | 1 _-x-_ | 3 _-x-_  | 12 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/appearance
  - `aspectRatio` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `auto || <ratio>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **88** | **89**  | **15** | **88** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/aspect-ratio
  - `backdropFilter` (optional): Since September 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | <filter-value-list>`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **76** | **103** | **18**  | **79** | No  |
|        |         | 9 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/backdrop-filter
  - `backfaceVisibility` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `visible | hidden`

**Initial value**: `visible`

|  Chrome  | Firefox  |  Safari   |  Edge  |   IE   |
| :------: | :------: | :-------: | :----: | :----: |
|  **36**  |  **16**  | **15.4**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 5.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/backface-visibility
  - `backgroundAttachment` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<attachment>#`

**Initial value**: `scroll`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-attachment
  - `backgroundBlendMode` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<blend-mode>#`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **35** | **30**  | **8**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-blend-mode
  - `backgroundClip` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-clip>#`

**Initial value**: `border-box`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **4**  |  **5**  | **12** | **9** |
|        |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-clip
  - `backgroundColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `transparent`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-color
  - `backgroundImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-image>#`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-image
  - `backgroundOrigin` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<visual-box>#`

**Initial value**: `padding-box`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **4**  | **3**  | **12** | **9** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-origin
  - `backgroundPositionX` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2016.

**Syntax**: `[ center | [ [ left | right | x-start | x-end ]? <length-percentage>? ]! ]#`

**Initial value**: `0%`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **49**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-position-x
  - `backgroundPositionY` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2016.

**Syntax**: `[ center | [ [ top | bottom | y-start | y-end ]? <length-percentage>? ]! ]#`

**Initial value**: `0%`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **49**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-position-y
  - `backgroundRepeat` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<repeat-style>#`

**Initial value**: `repeat`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-repeat
  - `backgroundSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-size>#`

**Initial value**: `auto auto`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **3**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-size
  - `baselineShift` (String | Real; optional): **Syntax**: `<length-percentage> | sub | super | baseline`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |   No    | **4**  | **79** | No  |
  - `blockSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'width'>`

**Initial value**: `auto`

|            Chrome            | Firefox |             Safari             |  Edge  | IE  |
| :--------------------------: | :-----: | :----------------------------: | :----: | :-: |
|            **57**            | **41**  |            **12.1**            | **79** | No  |
| 8 _(-webkit-logical-height)_ |         | 5.1 _(-webkit-logical-height)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/block-size
  - `borderBlockEndColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-end-color
  - `borderBlockEndStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-end-style
  - `borderBlockEndWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'>`

**Initial value**: `medium`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-end-width
  - `borderBlockStartColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-start-color
  - `borderBlockStartStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-start-style
  - `borderBlockStartWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'>`

**Initial value**: `medium`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-start-width
  - `borderBottomColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom-color
  - `borderBottomLeftRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom-left-radius
  - `borderBottomRightRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom-right-radius
  - `borderBottomStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-style>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom-style
  - `borderBottomWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom-width
  - `borderCollapse` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'collapse', 'separate'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `separate | collapse`

**Initial value**: `separate`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.1** | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-collapse
  - `borderEndEndRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<'border-top-left-radius'>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-end-end-radius
  - `borderEndStartRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<'border-top-left-radius'>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-end-start-radius
  - `borderImageOutset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <length [0,∞]> | <number [0,∞]> ]{1,4}  `

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image-outset
  - `borderImageRepeat` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2016.

**Syntax**: `[ stretch | repeat | round | space ]{1,2}`

**Initial value**: `stretch`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image-repeat
  - `borderImageSlice` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <number [0,∞]> | <percentage [0,∞]> ]{1,4}  && fill?`

**Initial value**: `100%`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image-slice
  - `borderImageSource` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <image>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image-source
  - `borderImageWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <length-percentage [0,∞]> | <number [0,∞]> | auto ]{1,4}`

**Initial value**: `1`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **16** | **13**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image-width
  - `borderInlineEndColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`

| Chrome |           Firefox           |  Safari  |  Edge  | IE  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | No  |
|        | 3 _(-moz-border-end-color)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-end-color
  - `borderInlineEndStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`

| Chrome |           Firefox           |  Safari  |  Edge  | IE  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | No  |
|        | 3 _(-moz-border-end-style)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-end-style
  - `borderInlineEndWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'>`

**Initial value**: `medium`

| Chrome |           Firefox           |  Safari  |  Edge  | IE  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | No  |
|        | 3 _(-moz-border-end-width)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-end-width
  - `borderInlineStartColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`

| Chrome |            Firefox            |  Safari  |  Edge  | IE  |
| :----: | :---------------------------: | :------: | :----: | :-: |
| **69** |            **41**             | **12.1** | **79** | No  |
|        | 3 _(-moz-border-start-color)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-start-color
  - `borderInlineStartStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`

| Chrome |            Firefox            |  Safari  |  Edge  | IE  |
| :----: | :---------------------------: | :------: | :----: | :-: |
| **69** |            **41**             | **12.1** | **79** | No  |
|        | 3 _(-moz-border-start-style)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-start-style
  - `borderInlineStartWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'>`

**Initial value**: `medium`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-start-width
  - `borderLeftColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-left-color
  - `borderLeftStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-style>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-left-style
  - `borderLeftWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-left-width
  - `borderRightColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-right-color
  - `borderRightStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-style>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-right-style
  - `borderRightWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-right-width
  - `borderSpacing` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length>{1,2}`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-spacing
  - `borderStartEndRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<'border-top-left-radius'>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-start-end-radius
  - `borderStartStartRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<'border-top-left-radius'>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-start-start-radius
  - `borderTopColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top-color
  - `borderTopLeftRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top-left-radius
  - `borderTopRightRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top-right-radius
  - `borderTopStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-style>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top-style
  - `borderTopWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top-width
  - `bottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/bottom
  - `boxDecorationBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'clone', 'slice'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `slice | clone`

**Initial value**: `slice`

|  Chrome  | Firefox |   Safari    |   Edge   | IE  |
| :------: | :-----: | :---------: | :------: | :-: |
| **130**  | **32**  | **7** _-x-_ | **130**  | No  |
| 22 _-x-_ |         |             | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/box-decoration-break
  - `boxShadow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <shadow>#`

**Initial value**: `none`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
| **10**  |  **4**  | **5.1** | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/box-shadow
  - `boxSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `content-box | border-box`

**Initial value**: `content-box`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
| **10**  | **29**  | **5.1** | **12** | **8** |
| 1 _-x-_ | 1 _-x-_ | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/box-sizing
  - `breakAfter` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'all', 'always', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region', 'column', 'page', 'recto', 'region', 'verso'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2019.

**Syntax**: `auto | avoid | always | all | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/break-after
  - `breakBefore` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'all', 'always', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region', 'column', 'page', 'recto', 'region', 'verso'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2019.

**Syntax**: `auto | avoid | always | all | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/break-before
  - `breakInside` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2019.

**Syntax**: `auto | avoid | avoid-page | avoid-column | avoid-region`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/break-inside
  - `captionSide` (a value equal to: 'top', 'bottom', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `top | bottom`

**Initial value**: `top`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/caption-side
  - `caretColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | <color>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **53**  | **11.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/caret-color
  - `caretShape` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'bar', 'block', 'underscore'; optional): **Syntax**: `auto | bar | block | underscore`

**Initial value**: `auto`

| Chrome | Firefox | Safari | Edge | IE  |
| :----: | :-----: | :----: | :--: | :-: |
|   No   |   No    |   No   |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/caret-shape
  - `clear` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'both', 'inline-end', 'inline-start'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | left | right | both | inline-start | inline-end`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/clear
  - `clipPath` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<clip-source> | [ <basic-shape> || <geometry-box> ] | none`

**Initial value**: `none`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **55**  | **3.5** | **9.1** | **79** | **10** |
| 23 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/clip-path
  - `clipRule` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'evenodd', 'nonzero'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `nonzero | evenodd`

**Initial value**: `nonzero`

| Chrome  | Firefox | Safari |  Edge  | IE  |
| :-----: | :-----: | :----: | :----: | :-: |
| **≤15** | **3.5** | **≤5** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/clip-rule
  - `color` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `canvastext`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/color
  - `colorAdjust` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): Since May 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `economy | exact`

**Initial value**: `economy`

|  Chrome  |       Firefox       |  Safari  |   Edge   | IE  |
| :------: | :-----------------: | :------: | :------: | :-: |
| **136**  |       **97**        | **15.4** | **136**  | No  |
| 17 _-x-_ | 48 _(color-adjust)_ | 6 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/print-color-adjust
  - `colorInterpolationFilters` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'linearRGB', 'sRGB'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | sRGB | linearRGB`

**Initial value**: `linearRGB`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **3**  | **3**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/color-interpolation-filters
  - `colorScheme` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2022.

**Syntax**: `normal | [ light | dark | <custom-ident> ]+ && only?`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **81** | **96**  | **13** | **81** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/color-scheme
  - `columnCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<integer> | auto`

**Initial value**: `auto`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-count
  - `columnFill` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `auto | balance`

**Initial value**: `balance`

| Chrome | Firefox | Safari  |  Edge  |   IE   |
| :----: | :-----: | :-----: | :----: | :----: |
| **50** | **52**  |  **9**  | **12** | **10** |
|        |         | 8 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-fill
  - `columnGap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | <length-percentage>`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **1**  | **1.5** | **3**  | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-gap
  - `columnRuleColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-rule-color
  - `columnRuleStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-style'>`

**Initial value**: `none`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-rule-style
  - `columnRuleWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-width'>`

**Initial value**: `medium`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-rule-width
  - `columnSpan` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `none | all`

**Initial value**: `none`

| Chrome  | Firefox |  Safari   |  Edge  |   IE   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **50**  | **71**  |   **9**   | **12** | **10** |
| 6 _-x-_ |         | 5.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-span
  - `columnWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since November 2016.

**Syntax**: `<length> | auto`

**Initial value**: `auto`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **50**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-width
  - `contain` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | strict | content | [ [ size || inline-size ] || layout || style || paint ]`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **52** | **69**  | **15.4** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain
  - `containIntrinsicBlockSize` (String | Real; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto? [ none | <length> ]`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain-intrinsic-block-size
  - `containIntrinsicHeight` (String | Real; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto? [ none | <length> ]`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain-intrinsic-height
  - `containIntrinsicInlineSize` (String | Real; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto? [ none | <length> ]`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain-intrinsic-inline-size
  - `containIntrinsicWidth` (String | Real; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto? [ none | <length> ]`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain-intrinsic-width
  - `containerName` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since February 2023.

**Syntax**: `none | <custom-ident>+`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/container-name
  - `containerType` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since February 2023.

**Syntax**: `normal | [ [ size | inline-size ] || scroll-state ]`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/container-type
  - `content` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | none | [ <content-replacement> | <content-list> ] [ / [ <string> | <counter> | <attr()> ]+ ]?`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/content
  - `contentVisibility` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible'; optional): Since September 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `visible | auto | hidden`

**Initial value**: `visible`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **85** | **125** | **18** | **85** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/content-visibility
  - `counterIncrement` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <counter-name> <integer>? ]+ | none`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **3**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/counter-increment
  - `counterReset` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <counter-name> <integer>? | <reversed-counter-name> <integer>? ]+ | none`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **3**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/counter-reset
  - `counterSet` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ <counter-name> <integer>? ]+ | none`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **85** | **68**  | **17.2** | **85** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/counter-set
  - `cursor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since December 2021.

**Syntax**: `[ [ <url> [ <x> <y> ]? , ]* <cursor-predefined> ]`

**Initial value**: `auto`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.2** | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/cursor
  - `cx` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/cx
  - `cy` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/cy
  - `d` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | path(<string>)`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **52** | **97**  |   No   | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/d
  - `direction` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'ltr', 'rtl'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `ltr | rtl`

**Initial value**: `ltr`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **2**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/direction
  - `display` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <display-outside> || <display-inside> ] | <display-listitem> | <display-internal> | <display-box> | <display-legacy>`

**Initial value**: `inline`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/display
  - `dominantBaseline` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'alphabetic', 'central', 'ideographic', 'mathematical', 'middle', 'hanging', 'text-bottom', 'text-top'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | text-bottom | alphabetic | ideographic | middle | central | mathematical | hanging | text-top`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **1**  | **4**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/dominant-baseline
  - `emptyCells` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hide', 'show'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `show | hide`

**Initial value**: `show`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/empty-cells
  - `fieldSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'fixed', 'content'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `content | fixed`

**Initial value**: `fixed`

| Chrome  | Firefox |   Safari    |  Edge   | IE  |
| :-----: | :-----: | :---------: | :-----: | :-: |
| **123** |   No    | **preview** | **123** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/field-sizing
  - `fill` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<paint>`

**Initial value**: `black`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/fill
  - `fillOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<'opacity'>`

**Initial value**: `1`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **1**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/fill-opacity
  - `fillRule` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'evenodd', 'nonzero'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `nonzero | evenodd`

**Initial value**: `nonzero`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/fill-rule
  - `filter` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2016.

**Syntax**: `none | <filter-value-list>`

**Initial value**: `none`

|  Chrome  | Firefox | Safari  |  Edge  | IE  |
| :------: | :-----: | :-----: | :----: | :-: |
|  **53**  | **35**  | **9.1** | **12** | No  |
| 18 _-x-_ |         | 6 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/filter
  - `flexBasis` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `content | <'width'>`

**Initial value**: `auto`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **22**  |  **9**  | **12** | **11** |
| 22 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-basis
  - `flexDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `row | row-reverse | column | column-reverse`

**Initial value**: `row`

|  Chrome  | Firefox | Safari  |  Edge  |    IE    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **22**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-direction
  - `flexGrow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<number>`

**Initial value**: `0`

|  Chrome  | Firefox | Safari  |  Edge  |            IE            |
| :------: | :-----: | :-----: | :----: | :----------------------: |
|  **29**  | **20**  |  **9**  | **12** |          **11**          |
| 22 _-x-_ |         | 7 _-x-_ |        | 10 _(-ms-flex-positive)_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-grow
  - `flexShrink` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<number>`

**Initial value**: `1`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **10** |
| 22 _-x-_ |         | 8 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-shrink
  - `flexWrap` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap', 'wrap-reverse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `nowrap | wrap | wrap-reverse`

**Initial value**: `nowrap`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-wrap
  - `float` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'inline-end', 'inline-start'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `left | right | none | inline-start | inline-end`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/float
  - `floodColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `black`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flood-color
  - `floodOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'opacity'>`

**Initial value**: `black`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flood-opacity
  - `fontFamily` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <family-name> | <generic-family> ]#`

**Initial value**: depends on user agent

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-family
  - `fontFeatureSettings` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `normal | <feature-tag-value>#`

**Initial value**: `normal`

|  Chrome  | Firefox  | Safari  |  Edge  |   IE   |
| :------: | :------: | :-----: | :----: | :----: |
|  **48**  |  **34**  | **9.1** | **15** | **10** |
| 16 _-x-_ | 15 _-x-_ |         |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-feature-settings
  - `fontKerning` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | normal | none`

**Initial value**: `auto`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **33** | **32**  |  **9**  | **79** | No  |
|        |         | 6 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-kerning
  - `fontLanguageOverride` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | <string>`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **143** | **34**  |   No   | **143** | No  |
|         | 4 _-x-_ |        |         |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-language-override
  - `fontOpticalSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2020.

**Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **79** | **62**  | **13.1** | **17** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-optical-sizing
  - `fontPalette` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since November 2022.

**Syntax**: `normal | light | dark | <palette-identifier> | <palette-mix()>`

**Initial value**: `normal`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **101** | **107** | **15.4** | **101** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-palette
  - `fontSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<absolute-size> | <relative-size> | <length-percentage [0,∞]> | math`

**Initial value**: `medium`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-size
  - `fontSizeAdjust` (optional): Since July 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | [ ex-height | cap-height | ch-width | ic-width | ic-height ]? [ from-font | <number> ]`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **127** |  **3**  | **16.4** | **127** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-size-adjust
  - `fontSmooth` (String | Real; optional): The **`font-smooth`** CSS property controls the application of anti-aliasing when fonts are rendered.

**Syntax**: `auto | never | always | <absolute-size> | <length>`

**Initial value**: `auto`

|              Chrome              |              Firefox               |              Safari              |               Edge                | IE  |
| :------------------------------: | :--------------------------------: | :------------------------------: | :-------------------------------: | :-: |
| **5** _(-webkit-font-smoothing)_ | **25** _(-moz-osx-font-smoothing)_ | **4** _(-webkit-font-smoothing)_ | **79** _(-webkit-font-smoothing)_ | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-smooth
  - `fontStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | italic | oblique <angle>?`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-style
  - `fontSynthesis` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2022.

**Syntax**: `none | [ weight || style || small-caps || position]`

**Initial value**: `weight style small-caps position `

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **97** | **34**  | **9**  | **97** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-synthesis
  - `fontSynthesisPosition` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | none`

**Initial value**: `none`

| Chrome | Firefox | Safari | Edge | IE  |
| :----: | :-----: | :----: | :--: | :-: |
|   No   | **118** |   No   |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-synthesis-position
  - `fontSynthesisSmallCaps` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-synthesis-small-caps
  - `fontSynthesisStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-synthesis-style
  - `fontSynthesisWeight` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-synthesis-weight
  - `fontVariant` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant
  - `fontVariantAlternates` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `normal | [ stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) ]`

**Initial value**: `normal`

| Chrome  | Firefox | Safari  |  Edge   | IE  |
| :-----: | :-----: | :-----: | :-----: | :-: |
| **111** | **34**  | **9.1** | **111** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-alternates
  - `fontVariantCaps` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'small-caps', 'all-petite-caps', 'all-small-caps', 'petite-caps', 'titling-caps', 'unicase'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps`

**Initial value**: `normal`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **52** | **34**  | **9.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-caps
  - `fontVariantEastAsian` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]`

**Initial value**: `normal`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **63** | **34**  | **9.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-east-asian
  - `fontVariantEmoji` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'text', 'emoji', 'unicode'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | text | emoji | unicode`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **131** | **141** |   No   | **131** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-emoji
  - `fontVariantLigatures` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]`

**Initial value**: `normal`

|  Chrome  | Firefox | Safari  |  Edge  | IE  |
| :------: | :-----: | :-----: | :----: | :-: |
|  **34**  | **34**  | **9.1** | **79** | No  |
| 31 _-x-_ |         | 7 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-ligatures
  - `fontVariantNumeric` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]`

**Initial value**: `normal`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **52** | **34**  | **9.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-numeric
  - `fontVariantPosition` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'sub', 'super'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | sub | super`

**Initial value**: `normal`

| Chrome | Firefox | Safari  | Edge | IE  |
| :----: | :-----: | :-----: | :--: | :-: |
|   No   | **34**  | **9.1** |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variant-position
  - `fontVariationSettings` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2018.

**Syntax**: `normal | [ <string> <number> ]#`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **62** | **62**  | **11** | **17** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-variation-settings
  - `fontWeight` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<font-weight-absolute> | bolder | lighter`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font-weight
  - `fontWidth` (optional): **Syntax**: `normal | <percentage [0,∞]> | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded`

**Initial value**: `normal`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
|   No   |   No    | **18.4** |  No  | No  |
  - `forcedColorAdjust` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'preserve-parent-color'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | none | preserve-parent-color`

**Initial value**: `auto`

| Chrome | Firefox | Safari |              Edge               |                 IE                  |
| :----: | :-----: | :----: | :-----------------------------: | :---------------------------------: |
| **89** | **113** |   No   |             **79**              | **10** _(-ms-high-contrast-adjust)_ |
|        |         |        | 12 _(-ms-high-contrast-adjust)_ |                                     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/forced-color-adjust
  - `gridAutoColumns` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<track-size>+`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  |             IE              |
| :----: | :-----: | :------: | :----: | :-------------------------: |
| **57** | **70**  | **10.1** | **16** | **10** _(-ms-grid-columns)_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-auto-columns
  - `gridAutoFlow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `[ row | column ] || dense`

**Initial value**: `row`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-auto-flow
  - `gridAutoRows` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<track-size>+`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  |            IE            |
| :----: | :-----: | :------: | :----: | :----------------------: |
| **57** | **70**  | **10.1** | **16** | **10** _(-ms-grid-rows)_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-auto-rows
  - `gridColumnEnd` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-column-end
  - `gridColumnStart` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-column-start
  - `gridRowEnd` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-row-end
  - `gridRowStart` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-row-start
  - `gridTemplateAreas` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `none | <string>+`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-template-areas
  - `gridTemplateColumns` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `none | <track-list> | <auto-track-list> | subgrid <line-name-list>?`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  |             IE              |
| :----: | :-----: | :------: | :----: | :-------------------------: |
| **57** | **52**  | **10.1** | **16** | **10** _(-ms-grid-columns)_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-template-columns
  - `gridTemplateRows` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `none | <track-list> | <auto-track-list> | subgrid <line-name-list>?`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  |            IE            |
| :----: | :-----: | :------: | :----: | :----------------------: |
| **57** | **52**  | **10.1** | **16** | **10** _(-ms-grid-rows)_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-template-rows
  - `hangingPunctuation` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | [ first || [ force-end | allow-end ] || last ]`

**Initial value**: `none`

| Chrome | Firefox | Safari | Edge | IE  |
| :----: | :-----: | :----: | :--: | :-: |
|   No   |   No    | **10** |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/hanging-punctuation
  - `height` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/height
  - `hyphenateCharacter` (optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | <string>`

**Initial value**: `auto`

| Chrome  | Firefox |  Safari   |   Edge   | IE  |
| :-----: | :-----: | :-------: | :------: | :-: |
| **106** | **98**  |  **17**   | **106**  | No  |
| 6 _-x-_ |         | 5.1 _-x-_ | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/hyphenate-character
  - `hyphenateLimitChars` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ auto | <integer> ]{1,3}`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** | **137** |   No   | **109** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/hyphenate-limit-chars
  - `hyphens` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | manual | auto`

**Initial value**: `manual`

|  Chrome  | Firefox |  Safari   |  Edge  |      IE      |
| :------: | :-----: | :-------: | :----: | :----------: |
|  **55**  | **43**  |  **17**   | **79** | **10** _-x-_ |
| 13 _-x-_ | 6 _-x-_ | 5.1 _-x-_ |        |              |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/hyphens
  - `imageOrientation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2020.

**Syntax**: `from-image | <angle> | [ <angle>? flip ]`

**Initial value**: `from-image`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **81** | **26**  | **13.1** | **81** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/image-orientation
  - `imageRendering` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', '-moz-crisp-edges', '-webkit-optimize-contrast', 'crisp-edges', 'pixelated', 'smooth'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | crisp-edges | pixelated | smooth`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **13** | **3.6** | **6**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/image-rendering
  - `imageResolution` (optional): The **`image-resolution`** CSS property specifies the intrinsic resolution of all raster images used in or on the element. It affects content images such as replaced elements and generated content, and decorative images such as `background-image` images.

**Syntax**: `[ from-image || <resolution> ] && snap?`

**Initial value**: `1dppx`
  - `initialLetter` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | [ <number> <integer>? ]`

**Initial value**: `normal`

| Chrome  | Firefox |   Safari    |  Edge   | IE  |
| :-----: | :-----: | :---------: | :-----: | :-: |
| **110** |   No    | **9** _-x-_ | **110** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/initial-letter
  - `initialLetterAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'alphabetic', 'ideographic', 'hanging'; optional): **Syntax**: `[ auto | alphabetic | hanging | ideographic ]`

**Initial value**: `auto`
  - `inlineSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'width'>`

**Initial value**: `auto`

|           Chrome            | Firefox |            Safari             |  Edge  | IE  |
| :-------------------------: | :-----: | :---------------------------: | :----: | :-: |
|           **57**            | **41**  |           **12.1**            | **79** | No  |
| 8 _(-webkit-logical-width)_ |         | 5.1 _(-webkit-logical-width)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inline-size
  - `insetBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-block-end
  - `insetBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-block-start
  - `insetInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-inline-end
  - `insetInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-inline-start
  - `interpolateSize` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'allow-keywords', 'numeric-only'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `numeric-only | allow-keywords`

**Initial value**: `numeric-only`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **129** |   No    |   No   | **129** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/interpolate-size
  - `isolation` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'isolate'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | isolate`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **41** | **36**  | **8**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/isolation
  - `justifyContent` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ]`

**Initial value**: `normal`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/justify-content
  - `justifyItems` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2016.

**Syntax**: `normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | legacy | legacy && [ left | right | center ] | anchor-center`

**Initial value**: `legacy`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **52** | **20**  | **9**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/justify-items
  - `justifySelf` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | anchor-center`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  |   IE   |
| :----: | :-----: | :------: | :----: | :----: |
| **57** | **45**  | **10.1** | **16** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/justify-self
  - `justifyTracks` (optional): **Syntax**: `[ normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ] ]#`

**Initial value**: `normal`
  - `left` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/left
  - `letterSpacing` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | <length>`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/letter-spacing
  - `lightingColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>`

**Initial value**: `white`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/lighting-color
  - `lineBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | loose | normal | strict | anywhere`

**Initial value**: `auto`

| Chrome  | Firefox | Safari  |  Edge  |   IE    |
| :-----: | :-----: | :-----: | :----: | :-----: |
| **58**  | **69**  | **11**  | **14** | **5.5** |
| 1 _-x-_ |         | 3 _-x-_ |        |         |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/line-break
  - `lineHeight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | <number> | <length> | <percentage>`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/line-height
  - `lineHeightStep` (String | Real; optional): The **`line-height-step`** CSS property sets the step unit for line box heights. When the property is set, line box heights are rounded up to the closest multiple of the unit.

**Syntax**: `<length>`

**Initial value**: `0`
  - `listStyleImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<image> | none`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/list-style-image
  - `listStylePosition` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'inside', 'outside'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `inside | outside`

**Initial value**: `outside`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/list-style-position
  - `listStyleType` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<counter-style> | <string> | none`

**Initial value**: `disc`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/list-style-type
  - `marginBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-block-end
  - `marginBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-block-start
  - `marginBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage> | auto | <anchor-size()>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-bottom
  - `marginInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`

|          Chrome          |        Firefox        |          Safari          |  Edge  | IE  |
| :----------------------: | :-------------------: | :----------------------: | :----: | :-: |
|          **69**          |        **41**         |         **12.1**         | **79** | No  |
| 2 _(-webkit-margin-end)_ | 3 _(-moz-margin-end)_ | 3 _(-webkit-margin-end)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-inline-end
  - `marginInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`

|           Chrome           |         Firefox         |           Safari           |  Edge  | IE  |
| :------------------------: | :---------------------: | :------------------------: | :----: | :-: |
|           **69**           |         **41**          |          **12.1**          | **79** | No  |
| 2 _(-webkit-margin-start)_ | 3 _(-moz-margin-start)_ | 3 _(-webkit-margin-start)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-inline-start
  - `marginLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage> | auto | <anchor-size()>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-left
  - `marginRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage> | auto | <anchor-size()>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-right
  - `marginTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage> | auto | <anchor-size()>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-top
  - `marginTrim` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all', 'in-flow'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | in-flow | all`

**Initial value**: `none`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
|   No   |   No    | **16.4** |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-trim
  - `marker` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `none | <url>`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/marker
  - `markerEnd` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `none | <url>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/marker-end
  - `markerMid` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `none | <url>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/marker-mid
  - `markerStart` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `none | <url>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/marker-start
  - `maskBorderMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'alpha', 'luminance'; optional): The **`mask-border-mode`** CSS property specifies the blending mode used in a mask border.

**Syntax**: `luminance | alpha`

**Initial value**: `alpha`
  - `maskBorderOutset` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <length> | <number> ]{1,4}`

**Initial value**: `0`

|                 Chrome                  | Firefox |                Safari                 |                   Edge                   | IE  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-outset)_ |   No    |               **17.2**                | **79** _(-webkit-mask-box-image-outset)_ | No  |
|                                         |         | 3.1 _(-webkit-mask-box-image-outset)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border-outset
  - `maskBorderRepeat` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ stretch | repeat | round | space ]{1,2}`

**Initial value**: `stretch`

|                 Chrome                  | Firefox |                Safari                 |                   Edge                   | IE  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-repeat)_ |   No    |               **17.2**                | **79** _(-webkit-mask-box-image-repeat)_ | No  |
|                                         |         | 3.1 _(-webkit-mask-box-image-repeat)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border-repeat
  - `maskBorderSlice` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<number-percentage>{1,4} fill?`

**Initial value**: `0`

|                 Chrome                 | Firefox |                Safari                |                  Edge                   | IE  |
| :------------------------------------: | :-----: | :----------------------------------: | :-------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-slice)_ |   No    |               **17.2**               | **79** _(-webkit-mask-box-image-slice)_ | No  |
|                                        |         | 3.1 _(-webkit-mask-box-image-slice)_ |                                         |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border-slice
  - `maskBorderSource` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <image>`

**Initial value**: `none`

|                 Chrome                  | Firefox |                Safari                 |                   Edge                   | IE  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-source)_ |   No    |               **17.2**                | **79** _(-webkit-mask-box-image-source)_ | No  |
|                                         |         | 3.1 _(-webkit-mask-box-image-source)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border-source
  - `maskBorderWidth` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <length-percentage> | <number> | auto ]{1,4}`

**Initial value**: `auto`

|                 Chrome                 | Firefox |                Safari                |                  Edge                   | IE  |
| :------------------------------------: | :-----: | :----------------------------------: | :-------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-width)_ |   No    |               **17.2**               | **79** _(-webkit-mask-box-image-width)_ | No  |
|                                        |         | 3.1 _(-webkit-mask-box-image-width)_ |                                         |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border-width
  - `maskClip` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ <coord-box> | no-clip ]#`

**Initial value**: `border-box`

| Chrome  | Firefox |  Safari  |   Edge   | IE  |
| :-----: | :-----: | :------: | :------: | :-: |
| **120** | **53**  | **15.4** | **120**  | No  |
| 1 _-x-_ |         | 4 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-clip
  - `maskComposite` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<compositing-operator>#`

**Initial value**: `add`

| Chrome  | Firefox |  Safari  | Edge  | IE  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 18-79 | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-composite
  - `maskImage` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<mask-reference>#`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  | Edge  | IE  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 16-79 | No  |
| 1 _-x-_ |         | 4 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-image
  - `maskMode` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<masking-mode>#`

**Initial value**: `match-source`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **120** | **53**  | **15.4** | **120** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-mode
  - `maskOrigin` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<coord-box>#`

**Initial value**: `border-box`

| Chrome  | Firefox |  Safari  |   Edge   | IE  |
| :-----: | :-----: | :------: | :------: | :-: |
| **120** | **53**  | **15.4** | **120**  | No  |
| 1 _-x-_ |         | 4 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-origin
  - `maskPosition` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<position>#`

**Initial value**: `0% 0%`

| Chrome  | Firefox |  Safari   | Edge  | IE  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 18-79 | No  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-position
  - `maskRepeat` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<repeat-style>#`

**Initial value**: `repeat`

| Chrome  | Firefox |  Safari   | Edge  | IE  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 18-79 | No  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-repeat
  - `maskSize` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<bg-size>#`

**Initial value**: `auto`

| Chrome  | Firefox |  Safari  | Edge  | IE  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 18-79 | No  |
| 4 _-x-_ |         | 4 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-size
  - `maskType` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'alpha', 'luminance'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `luminance | alpha`

**Initial value**: `luminance`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **24** | **35**  | **7**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-type
  - `masonryAutoFlow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `[ pack | next ] || [ definite-first | ordered ]`

**Initial value**: `pack`
  - `mathDepth` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto-add | add(<integer>) | <integer>`

**Initial value**: `0`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** | **117** |   No   | **109** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/math-depth
  - `mathShift` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'compact'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | compact`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** |   No    |   No   | **109** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/math-shift
  - `mathStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'compact'; optional): Since August 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `normal | compact`

**Initial value**: `normal`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **109** | **117** | **14.1** | **109** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/math-style
  - `maxBlockSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'max-width'>`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/max-block-size
  - `maxHeight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.3** | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/max-height
  - `maxInlineSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'max-width'>`

**Initial value**: `none`

| Chrome | Firefox |   Safari   |  Edge  | IE  |
| :----: | :-----: | :--------: | :----: | :-: |
| **57** | **41**  |  **12.1**  | **79** | No  |
|        |         | 10.1 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/max-inline-size
  - `maxLines` (optional): **Syntax**: `none | <integer>`

**Initial value**: `none`
  - `maxWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/max-width
  - `minBlockSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'min-width'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/min-block-size
  - `minHeight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **3**  | **1.3** | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/min-height
  - `minInlineSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'min-width'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/min-inline-size
  - `minWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/min-width
  - `mixBlendMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'color', 'color-burn', 'color-dodge', 'darken', 'difference', 'exclusion', 'hard-light', 'hue', 'lighten', 'luminosity', 'multiply', 'overlay', 'saturation', 'screen', 'soft-light', 'plus-darker', 'plus-lighter'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<blend-mode> | plus-darker | plus-lighter`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **41** | **32**  | **8**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mix-blend-mode
  - `motionDistance` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `<length-percentage>`

**Initial value**: `0`

|         Chrome         | Firefox | Safari |  Edge  | IE  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **55**         | **72**  | **16** | **79** | No  |
| 46 _(motion-distance)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-distance
  - `motionPath` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | <offset-path> || <coord-box>`

**Initial value**: `none`

|       Chrome       | Firefox |  Safari  |  Edge  | IE  |
| :----------------: | :-----: | :------: | :----: | :-: |
|       **55**       | **72**  | **15.4** | **79** | No  |
| 46 _(motion-path)_ |         |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-path
  - `motionRotation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ auto | reverse ] || <angle>`

**Initial value**: `auto`

|         Chrome         | Firefox | Safari |  Edge  | IE  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | No  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-rotate
  - `objectFit` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'contain', 'cover', 'fill', 'scale-down'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `fill | contain | cover | none | scale-down`

**Initial value**: `fill`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **32** | **36**  | **10** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/object-fit
  - `objectPosition` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<position>`

**Initial value**: `50% 50%`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **32** | **36**  | **10** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/object-position
  - `objectViewBox` (optional): **Syntax**: `none | <basic-shape-rect>`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **104** |   No    |   No   | **104** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/object-view-box
  - `offsetAnchor` (String | Real; optional): Since August 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | <position>`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** | **72**  | **16** | **116** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-anchor
  - `offsetDistance` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `<length-percentage>`

**Initial value**: `0`

|         Chrome         | Firefox | Safari |  Edge  | IE  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **55**         | **72**  | **16** | **79** | No  |
| 46 _(motion-distance)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-distance
  - `offsetPath` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | <offset-path> || <coord-box>`

**Initial value**: `none`

|       Chrome       | Firefox |  Safari  |  Edge  | IE  |
| :----------------: | :-----: | :------: | :----: | :-: |
|       **55**       | **72**  | **15.4** | **79** | No  |
| 46 _(motion-path)_ |         |          |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-path
  - `offsetPosition` (String | Real; optional): Since January 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `normal | auto | <position>`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** | **122** | **16** | **116** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-position
  - `offsetRotate` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ auto | reverse ] || <angle>`

**Initial value**: `auto`

|         Chrome         | Firefox | Safari |  Edge  | IE  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | No  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-rotate
  - `offsetRotation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ auto | reverse ] || <angle>`

**Initial value**: `auto`

|         Chrome         | Firefox | Safari |  Edge  | IE  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | No  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset-rotate
  - `opacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<opacity-value>`

**Initial value**: `1`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **2**  | **12** | **9** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/opacity
  - `order` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<integer>`

**Initial value**: `0`

|  Chrome  | Firefox | Safari  |  Edge  |    IE    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **20**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/order
  - `orphans` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<integer>`

**Initial value**: `2`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **25** |   No    | **1.3** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/orphans
  - `outlineColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <color>`

**Initial value**: `auto`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/outline-color
  - `outlineOffset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **1**  | **1.5** | **1.2** | **15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/outline-offset
  - `outlineStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <outline-line-style>`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/outline-style
  - `outlineWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/outline-width
  - `overflowAnchor` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |   Safari    |  Edge  | IE  |
| :----: | :-----: | :---------: | :----: | :-: |
| **56** | **66**  | **preview** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-anchor
  - `overflowBlock` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'clip'; optional): Since September 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **135** | **69**  | **26** | **135** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-block
  - `overflowClipBox` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'content-box', 'padding-box'; optional): **Syntax**: `padding-box | content-box`

**Initial value**: `padding-box`
  - `overflowClipMargin` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<visual-box> || <length [0,∞]>`

**Initial value**: `0px`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **90** | **102** |   No   | **90** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-clip-margin
  - `overflowInline` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'clip'; optional): Since September 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **135** | **69**  | **26** | **135** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-inline
  - `overflowWrap` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'anywhere', 'break-word'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2018.

**Syntax**: `normal | break-word | anywhere`

**Initial value**: `normal`

|     Chrome      |      Firefox      |     Safari      |       Edge       |          IE           |
| :-------------: | :---------------: | :-------------: | :--------------: | :-------------------: |
|     **23**      |      **49**       |      **7**      |      **18**      | **5.5** _(word-wrap)_ |
| 1 _(word-wrap)_ | 3.5 _(word-wrap)_ | 1 _(word-wrap)_ | 12 _(word-wrap)_ |                       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-wrap
  - `overflowX` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `visible`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **3.5** | **3**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-x
  - `overflowY` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `visible`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **3.5** | **3**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow-y
  - `overlay` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | auto`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **117** |   No    |   No   | **117** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overlay
  - `overscrollBehaviorBlock` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `contain | none | auto`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **77** | **73**  | **16** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overscroll-behavior-block
  - `overscrollBehaviorInline` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `contain | none | auto`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **77** | **73**  | **16** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overscroll-behavior-inline
  - `overscrollBehaviorX` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `contain | none | auto`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overscroll-behavior-x
  - `overscrollBehaviorY` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `contain | none | auto`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overscroll-behavior-y
  - `paddingBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-block-end
  - `paddingBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-block-start
  - `paddingBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-bottom
  - `paddingInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`

|          Chrome           |        Firefox         |          Safari           |  Edge  | IE  |
| :-----------------------: | :--------------------: | :-----------------------: | :----: | :-: |
|          **69**           |         **41**         |         **12.1**          | **79** | No  |
| 2 _(-webkit-padding-end)_ | 3 _(-moz-padding-end)_ | 3 _(-webkit-padding-end)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-inline-end
  - `paddingInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`

|           Chrome            |         Firefox          |           Safari            |  Edge  | IE  |
| :-------------------------: | :----------------------: | :-------------------------: | :----: | :-: |
|           **69**            |          **41**          |          **12.1**           | **79** | No  |
| 2 _(-webkit-padding-start)_ | 3 _(-moz-padding-start)_ | 3 _(-webkit-padding-start)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-inline-start
  - `paddingLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-left
  - `paddingRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-right
  - `paddingTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-top
  - `page` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since February 2023.

**Syntax**: `auto | <custom-ident>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **85** | **110** | **1**  | **85** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/page
  - `paintOrder` (optional): Since March 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `normal | [ fill || stroke || markers ]`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **123** | **60**  | **11** | **123** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/paint-order
  - `perspective` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <length>`

**Initial value**: `none`

|  Chrome  | Firefox  | Safari  |  Edge  |   IE   |
| :------: | :------: | :-----: | :----: | :----: |
|  **36**  |  **16**  |  **9**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/perspective
  - `perspectiveOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<position>`

**Initial value**: `50% 50%`

|  Chrome  | Firefox  | Safari  |  Edge  |   IE   |
| :------: | :------: | :-----: | :----: | :----: |
|  **36**  |  **16**  |  **9**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/perspective-origin
  - `pointerEvents` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'visible', 'fill', 'stroke', 'painted', 'visibleFill', 'visiblePainted', 'visibleStroke'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | none | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | inherit`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE   |
| :----: | :-----: | :----: | :----: | :----: |
| **1**  | **1.5** | **4**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/pointer-events
  - `position` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'fixed', '-webkit-sticky', 'absolute', 'relative', 'static', 'sticky'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `static | relative | absolute | sticky | fixed`

**Initial value**: `static`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position
  - `positionAnchor` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | <anchor-name>`

**Initial value**: `auto`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-anchor
  - `positionArea` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <position-area>`

**Initial value**: `none`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **129** | **preview** | **26** | **129** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-area
  - `positionTryFallbacks` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | [ [<dashed-ident> || <try-tactic>] | <'position-area'> ]#`

**Initial value**: `none`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **128** | **preview** | **26** | **128** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-try-fallbacks
  - `positionTryOrder` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'most-block-size', 'most-height', 'most-inline-size', 'most-width'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | <try-size>`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **125** |   No    | **26** | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-try-order
  - `positionVisibility` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `always | [ anchors-valid || anchors-visible || no-overflow ]`

**Initial value**: `anchors-visible`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** |   No   | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-visibility
  - `printColorAdjust` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): Since May 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `economy | exact`

**Initial value**: `economy`

|  Chrome  |       Firefox       |  Safari  |   Edge   | IE  |
| :------: | :-----------------: | :------: | :------: | :-: |
| **136**  |       **97**        | **15.4** | **136**  | No  |
| 17 _-x-_ | 48 _(color-adjust)_ | 6 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/print-color-adjust
  - `quotes` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | auto | [ <string> <string> ]+`

**Initial value**: depends on user agent

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **11** | **1.5** | **9**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/quotes
  - `r` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/r
  - `resize` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'both', 'block', 'inline', 'horizontal', 'vertical'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | both | horizontal | vertical | block | inline`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **4**  | **3**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/resize
  - `right` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/right
  - `rotate` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2022.

**Syntax**: `none | <angle> | [ x | y | z | <number>{3} ] && <angle>`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/rotate
  - `rowGap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `normal | <length-percentage>`

**Initial value**: `normal`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **47** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/row-gap
  - `rubyAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'space-around', 'space-between', 'center', 'start'; optional): Since December 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `start | center | space-between | space-around`

**Initial value**: `space-around`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **128** | **38**  | **18.2** | **128** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/ruby-align
  - `rubyMerge` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'collapse', 'separate'; optional): **Syntax**: `separate | collapse | auto`

**Initial value**: `separate`
  - `rubyOverhang` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): **Syntax**: `auto | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
|   No   |   No    | **18.2** |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/ruby-overhang
  - `rubyPosition` (optional): Since December 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ alternate || [ over | under ] ] | inter-character`

**Initial value**: `alternate`

| Chrome  | Firefox |  Safari  | Edge  | IE  |
| :-----: | :-----: | :------: | :---: | :-: |
| **84**  | **38**  | **18.2** | 12-79 | No  |
| 1 _-x-_ |         | 7 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/ruby-position
  - `rx` (String | Real; optional): Since March 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **43** | **69**  | **17.4** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/rx
  - `ry` (String | Real; optional): Since March 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **43** | **69**  | **17.4** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/ry
  - `scale` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2022.

**Syntax**: `none | [ <number> | <percentage> ]{1,3}`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scale
  - `scrollBehavior` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'smooth'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `auto | smooth`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **61** | **36**  | **15.4** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-behavior
  - `scrollInitialTarget` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'nearest'; optional): **Syntax**: `none | nearest`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **133** |   No    |   No   | **133** | No  |
  - `scrollMarginBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-block-end
  - `scrollMarginBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-block-start
  - `scrollMarginBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |              Safari              |  Edge  | IE  |
| :----: | :-----: | :------------------------------: | :----: | :-: |
| **69** | **68**  |             **14.1**             | **79** | No  |
|        |         | 11 _(scroll-snap-margin-bottom)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-bottom
  - `scrollMarginInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-inline-end
  - `scrollMarginInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-inline-start
  - `scrollMarginLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |             Safari             |  Edge  | IE  |
| :----: | :-----: | :----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**            | **79** | No  |
|        |         | 11 _(scroll-snap-margin-left)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-left
  - `scrollMarginRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |             Safari              |  Edge  | IE  |
| :----: | :-----: | :-----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**             | **79** | No  |
|        |         | 11 _(scroll-snap-margin-right)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-right
  - `scrollMarginTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |            Safari             |  Edge  | IE  |
| :----: | :-----: | :---------------------------: | :----: | :-: |
| **69** | **68**  |           **14.1**            | **79** | No  |
|        |         | 11 _(scroll-snap-margin-top)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-top
  - `scrollPaddingBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-block-end
  - `scrollPaddingBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-block-start
  - `scrollPaddingBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-bottom
  - `scrollPaddingInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-inline-end
  - `scrollPaddingInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-inline-start
  - `scrollPaddingLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-left
  - `scrollPaddingRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-right
  - `scrollPaddingTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `auto | <length-percentage>`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-top
  - `scrollSnapAlign` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `[ none | start | end | center ]{1,2}`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **11** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-snap-align
  - `scrollSnapMarginBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |              Safari              |  Edge  | IE  |
| :----: | :-----: | :------------------------------: | :----: | :-: |
| **69** | **68**  |             **14.1**             | **79** | No  |
|        |         | 11 _(scroll-snap-margin-bottom)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-bottom
  - `scrollSnapMarginLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |             Safari             |  Edge  | IE  |
| :----: | :-----: | :----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**            | **79** | No  |
|        |         | 11 _(scroll-snap-margin-left)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-left
  - `scrollSnapMarginRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |             Safari              |  Edge  | IE  |
| :----: | :-----: | :-----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**             | **79** | No  |
|        |         | 11 _(scroll-snap-margin-right)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-right
  - `scrollSnapMarginTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<length>`

**Initial value**: `0`

| Chrome | Firefox |            Safari             |  Edge  | IE  |
| :----: | :-----: | :---------------------------: | :----: | :-: |
| **69** | **68**  |           **14.1**            | **79** | No  |
|        |         | 11 _(scroll-snap-margin-top)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-top
  - `scrollSnapStop` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'always'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2022.

**Syntax**: `normal | always`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **75** | **103** | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-snap-stop
  - `scrollSnapType` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2022.

**Syntax**: `none | [ x | y | block | inline | both ] [ mandatory | proximity ]?`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  |      IE      |
| :----: | :-----: | :-----: | :----: | :----------: |
| **69** |  39-68  | **11**  | **79** | **10** _-x-_ |
|        |         | 9 _-x-_ |        |              |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-snap-type
  - `scrollTimelineAxis` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ block | inline | x | y ]#`

**Initial value**: `block`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-timeline-axis
  - `scrollTimelineName` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ none | <dashed-ident> ]#`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-timeline-name
  - `scrollbarColor` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | <color>{2}`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **121** | **64**  |   No   | **121** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scrollbar-color
  - `scrollbarGutter` (optional): Since December 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | stable && both-edges?`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **94** | **97**  | **18.2** | **94** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scrollbar-gutter
  - `scrollbarWidth` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'thin'; optional): Since December 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | thin | none`

**Initial value**: `auto`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **121** | **64**  | **18.2** | **121** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scrollbar-width
  - `shapeImageThreshold` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<opacity-value>`

**Initial value**: `0.0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/shape-image-threshold
  - `shapeMargin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<length-percentage>`

**Initial value**: `0`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/shape-margin
  - `shapeOutside` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `none | [ <shape-box> || <basic-shape> ] | <image>`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/shape-outside
  - `shapeRendering` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'crispEdges', 'geometricPrecision', 'optimizeSpeed'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | optimizeSpeed | crispEdges | geometricPrecision`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **3**  | **4**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/shape-rendering
  - `speakAs` (optional): **Syntax**: `normal | spell-out || digits || [ literal-punctuation | no-punctuation ]`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
|   No   |   No    | **11.1** |  No  | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/speak-as
  - `stopColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<'color'>`

**Initial value**: `black`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stop-color
  - `stopOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<'opacity'>`

**Initial value**: `black`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stop-opacity
  - `stroke` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<paint>`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke
  - `strokeColor` (optional): **Syntax**: `<color>`

**Initial value**: `transparent`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
|   No   |   No    | **11.1** |  No  | No  |
  - `strokeDasharray` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `none | <dasharray>`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-dasharray
  - `strokeDashoffset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<length-percentage> | <number>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-dashoffset
  - `strokeLinecap` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'round', 'butt', 'square'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `butt | round | square`

**Initial value**: `butt`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-linecap
  - `strokeLinejoin` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'round', 'arcs', 'bevel', 'miter', 'miter-clip'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `miter | miter-clip | round | bevel | arcs`

**Initial value**: `miter`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-linejoin
  - `strokeMiterlimit` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<number>`

**Initial value**: `4`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-miterlimit
  - `strokeOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<'opacity'>`

**Initial value**: `1`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-opacity
  - `strokeWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<length-percentage> | <number>`

**Initial value**: `1px`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/stroke-width
  - `tabSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2021.

**Syntax**: `<integer> | <length>`

**Initial value**: `8`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **21** | **91**  | **7**  | **79** | No  |
|        | 4 _-x-_ |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/tab-size
  - `tableLayout` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'fixed'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | fixed`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **14** |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/table-layout
  - `textAlign` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', '-khtml-center', '-khtml-left', '-khtml-right', '-moz-center', '-moz-left', '-moz-right', '-webkit-center', '-webkit-left', '-webkit-match-parent', '-webkit-right', 'justify', 'match-parent'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `start | end | left | right | center | justify | match-parent`

**Initial value**: `start`, or a nameless value that acts as `left` if _direction_ is `ltr`, `right` if _direction_ is `rtl` if `start` is not supported by the browser.

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-align
  - `textAlignLast` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'center', 'end', 'start', 'justify'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `auto | start | end | left | right | center | justify`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **47** | **49**  | **16** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-align-last
  - `textAnchor` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'end', 'start', 'middle'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2016.

**Syntax**: `start | middle | end`

**Initial value**: `start`

| Chrome | Firefox | Safari |  Edge   | IE  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤14** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-anchor
  - `textAutospace` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | <autospace> | auto`

**Initial value**: `normal`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **140** | **145** | **18.4** | **140** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-autospace
  - `textBox` (optional): **Syntax**: `normal | <'text-box-trim'> || <'text-box-edge'>`

**Initial value**: `normal`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   No    | **18.2** | **133** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-box
  - `textBoxEdge` (optional): **Syntax**: `auto | <text-edge>`

**Initial value**: `auto`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   No    | **18.2** | **133** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-box-edge
  - `textBoxTrim` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'trim-both', 'trim-end', 'trim-start'; optional): **Syntax**: `none | trim-start | trim-end | trim-both`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   No    | **18.2** | **133** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-box-trim
  - `textCombineUpright` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | all | [ digits <integer>? ]`

**Initial value**: `none`

|           Chrome           | Firefox |            Safari            |  Edge  |                   IE                   |
| :------------------------: | :-----: | :--------------------------: | :----: | :------------------------------------: |
|           **48**           | **48**  |           **15.4**           | **79** | **11** _(-ms-text-combine-horizontal)_ |
| 9 _(-webkit-text-combine)_ |         | 5.1 _(-webkit-text-combine)_ |        |                                        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-combine-upright
  - `textDecorationColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | No  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-color
  - `textDecorationLine` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | No  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-line
  - `textDecorationSkip` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | [ objects || [ spaces | [ leading-spaces || trailing-spaces ] ] || edges || box-decoration ]`

**Initial value**: `objects`

| Chrome | Firefox |  Safari  | Edge | IE  |
| :----: | :-----: | :------: | :--: | :-: |
| 57-64  |   No    | **12.1** |  No  | No  |
|        |         | 7 _-x-_  |      |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-skip
  - `textDecorationSkipInk` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `auto | all | none`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **64** | **70**  | **15.4** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-skip-ink
  - `textDecorationStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `solid | double | dotted | dashed | wavy`

**Initial value**: `solid`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | No  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-style
  - `textDecorationThickness` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2021.

**Syntax**: `auto | from-font | <length> | <percentage> `

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **89** | **70**  | **12.1** | **89** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration-thickness
  - `textEmphasisColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `<color>`

**Initial value**: `currentcolor`

|  Chrome  | Firefox | Safari |   Edge   | IE  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | No  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-emphasis-color
  - `textEmphasisPosition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `auto | [ over | under ] && [ right | left ]?`

**Initial value**: `auto`

|  Chrome  | Firefox | Safari |   Edge   | IE  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | No  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-emphasis-position
  - `textEmphasisStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | [ [ filled | open ] || [ dot | circle | double-circle | triangle | sesame ] ] | <string>`

**Initial value**: `none`

|  Chrome  | Firefox | Safari |   Edge   | IE  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | No  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-emphasis-style
  - `textIndent` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage> && hanging? && each-line?`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-indent
  - `textJustify` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'inter-character', 'distribute', 'inter-word'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | inter-character | inter-word | none`

**Initial value**: `auto`

| Chrome | Firefox | Safari | Edge  |   IE   |
| :----: | :-----: | :----: | :---: | :----: |
|   No   | **55**  |   No   | 12-79 | **11** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-justify
  - `textOrientation` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'mixed', 'sideways', 'sideways-right', 'upright'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2020.

**Syntax**: `mixed | upright | sideways`

**Initial value**: `mixed`

|  Chrome  | Firefox |  Safari   |  Edge  | IE  |
| :------: | :-----: | :-------: | :----: | :-: |
|  **48**  | **41**  |  **14**   | **79** | No  |
| 12 _-x-_ |         | 5.1 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-orientation
  - `textOverflow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**Initial value**: `clip`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **7**  | **1.3** | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-overflow
  - `textRendering` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'geometricPrecision', 'optimizeSpeed', 'optimizeLegibility'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | optimizeSpeed | optimizeLegibility | geometricPrecision`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **4**  |  **1**  | **5**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-rendering
  - `textShadow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <shadow-t>#`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  |   IE   |
| :----: | :-----: | :-----: | :----: | :----: |
| **2**  | **3.5** | **1.1** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-shadow
  - `textSizeAdjust` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | auto | <percentage>`

**Initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **54** |   No    |   No   | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-size-adjust
  - `textSpacingTrim` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'trim-start', 'space-all', 'space-first'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `space-all | normal | space-first | trim-start`

**Initial value**: `normal`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **123** |   No    |   No   | **123** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-spacing-trim
  - `textTransform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | [ capitalize | uppercase | lowercase ] || full-width || full-size-kana | math-auto`

**Initial value**: `none`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-transform
  - `textUnderlineOffset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since November 2020.

**Syntax**: `auto | <length> | <percentage> `

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **70**  | **12.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-underline-offset
  - `textUnderlinePosition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | from-font | [ under || [ left | right ] ]`

**Initial value**: `auto`

| Chrome | Firefox |  Safari  |  Edge  |  IE   |
| :----: | :-----: | :------: | :----: | :---: |
| **33** | **74**  | **12.1** | **12** | **6** |
|        |         | 9 _-x-_  |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-underline-position
  - `textWrapMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap'; optional): Since October 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `wrap | nowrap`

**Initial value**: `wrap`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **130** | **124** | **17.4** | **130** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-wrap-mode
  - `textWrapStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance', 'stable', 'pretty'; optional): Since October 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | balance | stable | pretty`

**Initial value**: `auto`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **130** | **124** | **17.5** | **130** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-wrap-style
  - `timelineScope` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <dashed-ident>#`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** |   No    | **26** | **116** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/timeline-scope
  - `top` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/top
  - `touchAction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2019.

**Syntax**: `auto | none | [ [ pan-x | pan-left | pan-right ] || [ pan-y | pan-up | pan-down ] || pinch-zoom ] | manipulation`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |    IE    |
| :----: | :-----: | :----: | :----: | :------: |
| **36** | **52**  | **13** | **12** |  **11**  |
|        |         |        |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/touch-action
  - `transform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <transform-list>`

**Initial value**: `none`

| Chrome  |  Firefox  |  Safari   |  Edge  |   IE    |
| :-----: | :-------: | :-------: | :----: | :-----: |
| **36**  |  **16**   |   **9**   | **12** | **10**  |
| 1 _-x-_ | 3.5 _-x-_ | 3.1 _-x-_ |        | 9 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transform
  - `transformBox` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box', 'fill-box', 'stroke-box', 'view-box'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `content-box | border-box | fill-box | stroke-box | view-box`

**Initial value**: `view-box`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **64** | **55**  | **11** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transform-box
  - `transformOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**Initial value**: `50% 50% 0`

| Chrome  |  Firefox  | Safari  |  Edge  |   IE    |
| :-----: | :-------: | :-----: | :----: | :-----: |
| **36**  |  **16**   |  **9**  | **12** | **10**  |
| 1 _-x-_ | 3.5 _-x-_ | 2 _-x-_ |        | 9 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transform-origin
  - `transformStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `flat | preserve-3d`

**Initial value**: `flat`

|  Chrome  | Firefox  | Safari  |  Edge  | IE  |
| :------: | :------: | :-----: | :----: | :-: |
|  **36**  |  **16**  |  **9**  | **12** | No  |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transform-style
  - `transitionBehavior` (optional): Since August 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<transition-behavior-value>#`

**Initial value**: `normal`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **117** | **129** | **17.4** | **117** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition-behavior
  - `transitionDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **26**  | **16**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition-delay
  - `transitionDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`

| Chrome  | Firefox |  Safari   |  Edge  |   IE   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition-duration
  - `transitionProperty` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <single-transition-property>#`

**Initial value**: all

| Chrome  | Firefox |  Safari   |  Edge  |   IE   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition-property
  - `transitionTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`

| Chrome  | Firefox |  Safari   |  Edge  |   IE   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition-timing-function
  - `translate` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2022.

**Syntax**: `none | <length-percentage> [ <length-percentage> <length>? ]?`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/translate
  - `unicodeBidi` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'isolate', '-moz-isolate', '-moz-isolate-override', '-moz-plaintext', '-webkit-isolate', '-webkit-isolate-override', '-webkit-plaintext', 'bidi-override', 'embed', 'isolate-override', 'plaintext'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | embed | isolate | bidi-override | isolate-override | plaintext`

**Initial value**: `normal`

| Chrome | Firefox | Safari  |  Edge  |   IE    |
| :----: | :-----: | :-----: | :----: | :-----: |
| **2**  |  **1**  | **1.3** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/unicode-bidi
  - `userSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | text | none | all`

**Initial value**: `auto`

| Chrome  | Firefox |   Safari    |   Edge   |      IE      |
| :-----: | :-----: | :---------: | :------: | :----------: |
| **54**  | **69**  | **3** _-x-_ |  **79**  | **10** _-x-_ |
| 1 _-x-_ | 1 _-x-_ |             | 12 _-x-_ |              |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/user-select
  - `vectorEffect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'fixed-position', 'non-rotation', 'non-scaling-size', 'non-scaling-stroke'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `none | non-scaling-stroke | non-scaling-size | non-rotation | fixed-position`

**Initial value**: `none`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **6**  | **15**  | **5.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/vector-effect
  - `verticalAlign` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `baseline | sub | super | text-top | text-bottom | middle | top | bottom | <percentage> | <length>`

**Initial value**: `baseline`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/vertical-align
  - `viewTimelineAxis` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ block | inline | x | y ]#`

**Initial value**: `block`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-timeline-axis
  - `viewTimelineInset` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ [ auto | <length-percentage> ]{1,2} ]#`

**Initial value**: `auto`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-timeline-inset
  - `viewTimelineName` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ none | <dashed-ident> ]#`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-timeline-name
  - `viewTransitionClass` (optional): **Syntax**: `none | <custom-ident>+`

**Initial value**: `none`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **125** | **144** | **18.2** | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-transition-class
  - `viewTransitionName` (optional): Since October 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | <custom-ident> | match-element`

**Initial value**: `none`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **111** | **144** | **18** | **111** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-transition-name
  - `visibility` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible', 'collapse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `visible | hidden | collapse`

**Initial value**: `visible`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/visibility
  - `whiteSpace` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | pre | pre-wrap | pre-line | <'white-space-collapse'> || <'text-wrap-mode'>`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/white-space
  - `whiteSpaceCollapse` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'collapse', 'break-spaces', 'preserve', 'preserve-breaks', 'preserve-spaces'; optional): Since March 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `collapse | preserve | preserve-breaks | preserve-spaces | break-spaces`

**Initial value**: `collapse`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **114** | **124** | **17.4** | **114** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/white-space-collapse
  - `widows` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<integer>`

**Initial value**: `2`

| Chrome | Firefox | Safari  |  Edge  |  IE   |
| :----: | :-----: | :-----: | :----: | :---: |
| **25** |   No    | **1.3** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/widows
  - `width` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/width
  - `willChange` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | <animateable-feature>#`

**Initial value**: `auto`

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **36** | **36**  | **9.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/will-change
  - `wordBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word', 'auto-phrase', 'break-all', 'keep-all'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | break-all | keep-all | break-word | auto-phrase`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  | **15**  | **3**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/word-break
  - `wordSpacing` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | <length>`

**Initial value**: `normal`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/word-spacing
  - `wordWrap` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2018.

**Syntax**: `normal | break-word`

**Initial value**: `normal`
  - `writingMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**Initial value**: `horizontal-tb`

| Chrome  | Firefox |  Safari   |  Edge  |  IE   |
| :-----: | :-----: | :-------: | :----: | :---: |
| **48**  | **41**  | **10.1**  | **12** | **9** |
| 8 _-x-_ |         | 5.1 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/writing-mode
  - `x` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **42** | **69**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/x
  - `y` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `<length> | <percentage>`

**Initial value**: `0`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **42** | **69**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/y
  - `zIndex` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <integer>`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/z-index
  - `zoom` (optional): Since May 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `normal | reset | <number [0,∞]> || <percentage [0,∞]>`

**Initial value**: `1`

| Chrome | Firefox | Safari  |  Edge  |   IE    |
| :----: | :-----: | :-----: | :----: | :-----: |
| **1**  | **126** | **3.1** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/zoom
  - `all` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `initial | inherit | unset | revert | revert-layer`

**Initial value**: There is no practical initial value for it.

| Chrome | Firefox | Safari  |  Edge  | IE  |
| :----: | :-----: | :-----: | :----: | :-: |
| **37** | **27**  | **9.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/all
  - `animation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation>#`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation
  - `animationRange` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <'animation-range-start'> <'animation-range-end'>? ]#`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/animation-range
  - `background` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-layer>#? , <final-bg-layer>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background
  - `backgroundPosition` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-position>#`

**Initial value**: `0% 0%`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/background-position
  - `border` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width> || <line-style> || <color>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border
  - `borderBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-block-start'>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block
  - `borderBlockColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-color'>{1,2}`

**Initial value**: `currentcolor`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-color
  - `borderBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-end
  - `borderBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-start
  - `borderBlockStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-style'>{1,2}`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-style
  - `borderBlockWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-width'>{1,2}`

**Initial value**: `medium`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-block-width
  - `borderBottom` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width> || <line-style> || <color>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-bottom
  - `borderColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<color>{1,4}`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-color
  - `borderImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`

| Chrome  |  Firefox  | Safari  |  Edge  |   IE   |
| :-----: | :-------: | :-----: | :----: | :----: |
| **16**  |  **15**   |  **6**  | **12** | **11** |
| 7 _-x-_ | 3.5 _-x-_ | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-image
  - `borderInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-block-start'>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline
  - `borderInlineColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-color'>{1,2}`

**Initial value**: `currentcolor`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-color
  - `borderInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-end
  - `borderInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-start
  - `borderInlineStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-style'>{1,2}`

**Initial value**: `none`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-style
  - `borderInlineWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'border-top-width'>{1,2}`

**Initial value**: `medium`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-inline-width
  - `borderLeft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width> || <line-style> || <color>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-left
  - `borderRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`

| Chrome  | Firefox | Safari  |  Edge  |  IE   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-radius
  - `borderRight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width> || <line-style> || <color>`

| Chrome | Firefox | Safari |  Edge  |   IE    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-right
  - `borderStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-style>{1,4}`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-style
  - `borderTop` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width> || <line-style> || <color>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-top
  - `borderWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>{1,4}`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/border-width
  - `caret` (optional): **Syntax**: `<'caret-color'> || <'caret-shape'>`
  - `columnRule` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`

| Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/column-rule
  - `columns` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-width'> || <'column-count'>`

| Chrome | Firefox | Safari  |  Edge  |   IE   |
| :----: | :-----: | :-----: | :----: | :----: |
| **50** | **52**  |  **9**  | **12** | **10** |
|        |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/columns
  - `containIntrinsicSize` (String | Real; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ auto? [ none | <length> ] ]{1,2}`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **83** | **107** | **17** | **83** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/contain-intrinsic-size
  - `container` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since February 2023.

**Syntax**: `<'container-name'> [ / <'container-type'> ]?`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/container
  - `flex` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`

|  Chrome  | Firefox | Safari  |  Edge  |    IE    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **22**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex
  - `flexFlow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<'flex-direction'> || <'flex-wrap'>`

|  Chrome  | Firefox | Safari  |  Edge  |   IE   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/flex-flow
  - `font` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ [ <'font-style'> || <font-variant-css2> || <'font-weight'> || <font-width-css3> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'># ] | <system-family-name>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/font
  - `gap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<'row-gap'> <'column-gap'>?`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/gap
  - `grid` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<'grid-template'> | <'grid-template-rows'> / [ auto-flow && dense? ] <'grid-auto-columns'>? | [ auto-flow && dense? ] <'grid-auto-rows'>? / <'grid-template-columns'>`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid
  - `gridArea` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line> [ / <grid-line> ]{0,3}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-area
  - `gridColumn` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line> [ / <grid-line> ]?`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-column
  - `gridRow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<grid-line> [ / <grid-line> ]?`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-row
  - `gridTemplate` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `none | [ <'grid-template-rows'> / <'grid-template-columns'> ] | [ <line-names>? <string> <track-size>? <line-names>? ]+ [ / <explicit-track-list> ]?`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/grid-template
  - `inset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>{1,4}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset
  - `insetBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-block
  - `insetInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/inset-inline
  - `lineClamp` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <integer>`

**Initial value**: `none`

|   Chrome    |   Firefox    |  Safari   |     Edge     | IE  |
| :---------: | :----------: | :-------: | :----------: | :-: |
| **6** _-x-_ | **68** _-x-_ | 18.2-18.4 | **17** _-x-_ | No  |
|             |              |  5 _-x-_  |              |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/line-clamp
  - `listStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'list-style-type'> || <'list-style-position'> || <'list-style-image'>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/list-style
  - `margin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'margin-top'>{1,4}`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin
  - `marginBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'margin-top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-block
  - `marginInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'margin-top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/margin-inline
  - `mask` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<mask-layer>#`

| Chrome  | Firefox |  Safari   | Edge  | IE  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 12-79 | No  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask
  - `maskBorder` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<'mask-border-source'> || <'mask-border-slice'> [ / <'mask-border-width'>? [ / <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>`

|              Chrome              | Firefox |             Safari             |               Edge                | IE  |
| :------------------------------: | :-----: | :----------------------------: | :-------------------------------: | :-: |
| **1** _(-webkit-mask-box-image)_ |   No    |            **17.2**            | **79** _(-webkit-mask-box-image)_ | No  |
|                                  |         | 3.1 _(-webkit-mask-box-image)_ |                                   |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/mask-border
  - `motion` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?`

|    Chrome     | Firefox | Safari |  Edge  | IE  |
| :-----------: | :-----: | :----: | :----: | :-: |
|    **55**     | **72**  | **16** | **79** | No  |
| 46 _(motion)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset
  - `offset` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?`

|    Chrome     | Firefox | Safari |  Edge  | IE  |
| :-----------: | :-----: | :----: | :----: | :-: |
|    **55**     | **72**  | **16** | **79** | No  |
| 46 _(motion)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/offset
  - `outline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `<'outline-width'> || <'outline-style'> || <'outline-color'>`

| Chrome | Firefox |  Safari  |  Edge  |  IE   |
| :----: | :-----: | :------: | :----: | :---: |
| **94** | **88**  | **16.4** | **94** | **8** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/outline
  - `overflow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ visible | hidden | clip | scroll | auto ]{1,2}`

**Initial value**: `visible`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overflow
  - `overscrollBehavior` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `[ contain | none | auto ]{1,2}`

**Initial value**: `auto`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/overscroll-behavior
  - `padding` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'padding-top'>{1,4}`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding
  - `paddingBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'padding-top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-block
  - `paddingInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'padding-top'>{1,2}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/padding-inline
  - `placeContent` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'align-content'> <'justify-content'>?`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **9**  | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/place-content
  - `placeItems` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'align-items'> <'justify-items'>?`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **11** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/place-items
  - `placeSelf` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'align-self'> <'justify-self'>?`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **11** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/place-self
  - `positionTry` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<'position-try-order'>? <'position-try-fallbacks'>`

| Chrome  |   Firefox   | Safari |  Edge   | IE  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/position-try
  - `scrollMargin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2021.

**Syntax**: `<length>{1,4}`

| Chrome | Firefox |          Safari           |  Edge  | IE  |
| :----: | :-----: | :-----------------------: | :----: | :-: |
| **69** | **90**  |         **14.1**          | **79** | No  |
|        |         | 11 _(scroll-snap-margin)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin
  - `scrollMarginBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>{1,2}`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-block
  - `scrollMarginInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `<length>{1,2}`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin-inline
  - `scrollPadding` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `[ auto | <length-percentage> ]{1,4}`

| Chrome | Firefox |  Safari  |  Edge  | IE  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding
  - `scrollPaddingBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `[ auto | <length-percentage> ]{1,2}`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-block
  - `scrollPaddingInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2021.

**Syntax**: `[ auto | <length-percentage> ]{1,2}`

| Chrome | Firefox | Safari |  Edge  | IE  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-padding-inline
  - `scrollSnapMargin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2021.

**Syntax**: `<length>{1,4}`

| Chrome | Firefox |          Safari           |  Edge  | IE  |
| :----: | :-----: | :-----------------------: | :----: | :-: |
| **69** |  68-90  |         **14.1**          | **79** | No  |
|        |         | 11 _(scroll-snap-margin)_ |        |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-margin
  - `scrollTimeline` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <'scroll-timeline-name'> <'scroll-timeline-axis'>? ]#`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/scroll-timeline
  - `textDecoration` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'> || <'text-decoration-thickness'>`

| Chrome | Firefox | Safari |  Edge  |  IE   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-decoration
  - `textEmphasis` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `<'text-emphasis-style'> || <'text-emphasis-color'>`

|  Chrome  | Firefox | Safari |   Edge   | IE  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | No  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-emphasis
  - `textWrap` (optional): Since March 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<'text-wrap-mode'> || <'text-wrap-style'>`

**Initial value**: `wrap`

| Chrome  | Firefox |  Safari  |  Edge   | IE  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **114** | **121** | **17.4** | **114** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/text-wrap
  - `transition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-transition>#`

| Chrome  | Firefox |  Safari   |  Edge  |   IE   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/transition
  - `viewTimeline` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <'view-timeline-name'> [ <'view-timeline-axis'> || <'view-timeline-inset'> ]? ]#`

| Chrome  | Firefox | Safari |  Edge   | IE  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   No    | **26** | **115** | No  |
@,see,https,://developer.mozilla.org/docs/Web/CSS/Reference/Properties/view-timeline
  - `MozAnimationDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `MozAnimationDirection` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-direction>#`

**Initial value**: `normal`
  - `MozAnimationDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ auto | <time [0s,∞]> ]#`

**Initial value**: `0s`
  - `MozAnimationFillMode` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-fill-mode>#`

**Initial value**: `none`
  - `MozAnimationIterationCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-iteration-count>#`

**Initial value**: `1`
  - `MozAnimationName` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ none | <keyframes-name> ]#`

**Initial value**: `none`
  - `MozAnimationPlayState` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-play-state>#`

**Initial value**: `running`
  - `MozAnimationTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
  - `MozAppearance` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'radio', 'searchfield', 'menulist-button', 'textfield', '-moz-mac-unified-toolbar', '-moz-win-borderless-glass', '-moz-win-browsertabbar-toolbox', '-moz-win-communications-toolbox', '-moz-win-communicationstext', '-moz-win-exclude-glass', '-moz-win-glass', '-moz-win-media-toolbox', '-moz-win-mediatext', '-moz-window-button-box', '-moz-window-button-box-maximized', '-moz-window-button-close', '-moz-window-button-maximize', '-moz-window-button-minimize', '-moz-window-button-restore', '-moz-window-frame-bottom', '-moz-window-frame-left', '-moz-window-frame-right', '-moz-window-titlebar', '-moz-window-titlebar-maximized', 'button-arrow-down', 'button-arrow-next', 'button-arrow-previous', 'button-arrow-up', 'button-bevel', 'button-focus', 'caret', 'checkbox-container', 'checkbox-label', 'checkmenuitem', 'dualbutton', 'groupbox', 'listitem', 'menuarrow', 'menubar', 'menucheckbox', 'menuimage', 'menuitem', 'menuitemtext', 'menulist-text', 'menulist-textfield', 'menupopup', 'menuradio', 'menuseparator', 'meterbar', 'meterchunk', 'progressbar', 'progressbar-vertical', 'progresschunk', 'progresschunk-vertical', 'radio-container', 'radio-label', 'radiomenuitem', 'range', 'range-thumb', 'resizer', 'resizerpanel', 'scale-horizontal', 'scale-vertical', 'scalethumb-horizontal', 'scalethumb-vertical', 'scalethumbend', 'scalethumbstart', 'scalethumbtick', 'scrollbarbutton-down', 'scrollbarbutton-left', 'scrollbarbutton-right', 'scrollbarbutton-up', 'scrollbarthumb-horizontal', 'scrollbarthumb-vertical', 'scrollbartrack-horizontal', 'scrollbartrack-vertical', 'separator', 'sheet', 'spinner', 'spinner-downbutton', 'spinner-textfield', 'spinner-upbutton', 'splitter', 'statusbar', 'statusbarpanel', 'tab', 'tab-scroll-arrow-back', 'tab-scroll-arrow-forward', 'tabpanel', 'tabpanels', 'textfield-multiline', 'toolbar', 'toolbarbutton', 'toolbarbutton-dropdown', 'toolbargripper', 'toolbox', 'tooltip', 'treeheader', 'treeheadercell', 'treeheadersortarrow', 'treeitem', 'treeline', 'treetwisty', 'treetwistyopen', 'treeview'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | button | button-arrow-down | button-arrow-next | button-arrow-previous | button-arrow-up | button-bevel | button-focus | caret | checkbox | checkbox-container | checkbox-label | checkmenuitem | dualbutton | groupbox | listbox | listitem | menuarrow | menubar | menucheckbox | menuimage | menuitem | menuitemtext | menulist | menulist-button | menulist-text | menulist-textfield | menupopup | menuradio | menuseparator | meterbar | meterchunk | progressbar | progressbar-vertical | progresschunk | progresschunk-vertical | radio | radio-container | radio-label | radiomenuitem | range | range-thumb | resizer | resizerpanel | scale-horizontal | scalethumbend | scalethumb-horizontal | scalethumbstart | scalethumbtick | scalethumb-vertical | scale-vertical | scrollbarbutton-down | scrollbarbutton-left | scrollbarbutton-right | scrollbarbutton-up | scrollbarthumb-horizontal | scrollbarthumb-vertical | scrollbartrack-horizontal | scrollbartrack-vertical | searchfield | separator | sheet | spinner | spinner-downbutton | spinner-textfield | spinner-upbutton | splitter | statusbar | statusbarpanel | tab | tabpanel | tabpanels | tab-scroll-arrow-back | tab-scroll-arrow-forward | textfield | textfield-multiline | toolbar | toolbarbutton | toolbarbutton-dropdown | toolbargripper | toolbox | tooltip | treeheader | treeheadercell | treeheadersortarrow | treeitem | treeline | treetwisty | treetwistyopen | treeview | -moz-mac-unified-toolbar | -moz-win-borderless-glass | -moz-win-browsertabbar-toolbox | -moz-win-communicationstext | -moz-win-communications-toolbox | -moz-win-exclude-glass | -moz-win-glass | -moz-win-mediatext | -moz-win-media-toolbox | -moz-window-button-box | -moz-window-button-box-maximized | -moz-window-button-close | -moz-window-button-maximize | -moz-window-button-minimize | -moz-window-button-restore | -moz-window-frame-bottom | -moz-window-frame-left | -moz-window-frame-right | -moz-window-titlebar | -moz-window-titlebar-maximized`

**Initial value**: `none` (but this value is overridden in the user agent CSS)
  - `MozBackfaceVisibility` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `visible | hidden`

**Initial value**: `visible`
  - `MozBinding` (optional): **Syntax**: `<url> | none`

**Initial value**: `none`
  - `MozBorderBottomColors` (optional): **Syntax**: `<color>+ | none`

**Initial value**: `none`
  - `MozBorderEndColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`
  - `MozBorderEndStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`
  - `MozBorderEndWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-width'>`

**Initial value**: `medium`
  - `MozBorderLeftColors` (optional): **Syntax**: `<color>+ | none`

**Initial value**: `none`
  - `MozBorderRightColors` (optional): **Syntax**: `<color>+ | none`

**Initial value**: `none`
  - `MozBorderStartColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-color'>`

**Initial value**: `currentcolor`
  - `MozBorderStartStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'border-top-style'>`

**Initial value**: `none`
  - `MozBorderTopColors` (optional): **Syntax**: `<color>+ | none`

**Initial value**: `none`
  - `MozBoxSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `content-box | border-box`

**Initial value**: `content-box`
  - `MozColumnRuleColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `MozColumnRuleStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-style'>`

**Initial value**: `none`
  - `MozColumnRuleWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-width'>`

**Initial value**: `medium`
  - `MozColumnWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since November 2016.

**Syntax**: `<length> | auto`

**Initial value**: `auto`
  - `MozContextProperties` (optional): **Syntax**: `none | [ fill | fill-opacity | stroke | stroke-opacity ]#`

**Initial value**: `none`
  - `MozFontFeatureSettings` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `normal | <feature-tag-value>#`

**Initial value**: `normal`
  - `MozFontLanguageOverride` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | <string>`

**Initial value**: `normal`
  - `MozHyphens` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | manual | auto`

**Initial value**: `manual`
  - `MozMarginEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`
  - `MozMarginStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`
  - `MozOrient` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'block', 'inline', 'horizontal', 'vertical'; optional): The **`-moz-orient`** CSS property specifies the orientation of the element to which it's applied.

**Syntax**: `inline | block | horizontal | vertical`

**Initial value**: `inline`
  - `MozOsxFontSmoothing` (String | Real; optional): The **`font-smooth`** CSS property controls the application of anti-aliasing when fonts are rendered.

**Syntax**: `auto | never | always | <absolute-size> | <length>`

**Initial value**: `auto`
  - `MozOutlineRadiusBottomleft` (String | Real; optional): **Syntax**: `<outline-radius>`

**Initial value**: `0`
  - `MozOutlineRadiusBottomright` (String | Real; optional): **Syntax**: `<outline-radius>`

**Initial value**: `0`
  - `MozOutlineRadiusTopleft` (String | Real; optional): **Syntax**: `<outline-radius>`

**Initial value**: `0`
  - `MozOutlineRadiusTopright` (String | Real; optional): **Syntax**: `<outline-radius>`

**Initial value**: `0`
  - `MozPaddingEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`
  - `MozPaddingStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`
  - `MozPerspective` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <length>`

**Initial value**: `none`
  - `MozPerspectiveOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<position>`

**Initial value**: `50% 50%`
  - `MozStackSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'ignore', 'stretch-to-fit'; optional): **Syntax**: `ignore | stretch-to-fit`

**Initial value**: `stretch-to-fit`
  - `MozTabSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2021.

**Syntax**: `<integer> | <length>`

**Initial value**: `8`
  - `MozTextBlink` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'blink'; optional): **Syntax**: `none | blink`

**Initial value**: `none`
  - `MozTextSizeAdjust` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | auto | <percentage>`

**Initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).
  - `MozTransform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <transform-list>`

**Initial value**: `none`
  - `MozTransformOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**Initial value**: `50% 50% 0`
  - `MozTransformStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `flat | preserve-3d`

**Initial value**: `flat`
  - `MozUserModify` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'read-only', 'read-write', 'write-only'; optional): The **`user-modify`** property has no effect in Firefox. It was originally planned to determine whether or not the content of an element can be edited by a user.

**Syntax**: `read-only | read-write | write-only`

**Initial value**: `read-only`
  - `MozUserSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | text | none | all`

**Initial value**: `auto`
  - `MozWindowDragging` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'drag', 'no-drag'; optional): **Syntax**: `drag | no-drag`

**Initial value**: `drag`
  - `MozWindowShadow` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'default', 'menu', 'sheet', 'tooltip'; optional): **Syntax**: `default | menu | tooltip | sheet | none`

**Initial value**: `default`
  - `msAccelerator` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'false', 'true'; optional): **Syntax**: `false | true`

**Initial value**: `false`
  - `msBlockProgression` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'bt', 'lr', 'rl', 'tb'; optional): **Syntax**: `tb | rl | bt | lr`

**Initial value**: `tb`
  - `msContentZoomChaining` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'chained'; optional): **Syntax**: `none | chained`

**Initial value**: `none`
  - `msContentZoomLimitMax` (optional): **Syntax**: `<percentage>`

**Initial value**: `400%`
  - `msContentZoomLimitMin` (optional): **Syntax**: `<percentage>`

**Initial value**: `100%`
  - `msContentZoomSnapPoints` (optional): **Syntax**: `snapInterval( <percentage>, <percentage> ) | snapList( <percentage># )`

**Initial value**: `snapInterval(0%, 100%)`
  - `msContentZoomSnapType` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **Syntax**: `none | proximity | mandatory`

**Initial value**: `none`
  - `msContentZooming` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'zoom'; optional): **Syntax**: `none | zoom`

**Initial value**: zoom for the top level element, none for all other elements
  - `msFilter` (optional): **Syntax**: `<string>`

**Initial value**: "" (the empty string)
  - `msFlexDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `row | row-reverse | column | column-reverse`

**Initial value**: `row`
  - `msFlexPositive` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<number>`

**Initial value**: `0`
  - `msFlowFrom` (optional): **Syntax**: `[ none | <custom-ident> ]#`

**Initial value**: `none`
  - `msFlowInto` (optional): **Syntax**: `[ none | <custom-ident> ]#`

**Initial value**: `none`
  - `msGridColumns` (String | Real; optional): **Syntax**: `none | <track-list> | <auto-track-list>`

**Initial value**: `none`
  - `msGridRows` (String | Real; optional): **Syntax**: `none | <track-list> | <auto-track-list>`

**Initial value**: `none`
  - `msHighContrastAdjust` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): **Syntax**: `auto | none`

**Initial value**: `auto`
  - `msHyphenateLimitChars` (optional): **Syntax**: `auto | <integer>{1,3}`

**Initial value**: `auto`
  - `msHyphenateLimitLines` (optional): **Syntax**: `no-limit | <integer>`

**Initial value**: `no-limit`
  - `msHyphenateLimitZone` (String | Real; optional): **Syntax**: `<percentage> | <length>`

**Initial value**: `0`
  - `msHyphens` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | manual | auto`

**Initial value**: `manual`
  - `msImeAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'after'; optional): **Syntax**: `auto | after`

**Initial value**: `auto`
  - `msLineBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | loose | normal | strict | anywhere`

**Initial value**: `auto`
  - `msOrder` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<integer>`

**Initial value**: `0`
  - `msOverflowStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', '-ms-autohiding-scrollbar', 'scrollbar'; optional): **Syntax**: `auto | none | scrollbar | -ms-autohiding-scrollbar`

**Initial value**: `auto`
  - `msOverflowX` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `visible`
  - `msOverflowY` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `visible | hidden | clip | scroll | auto`

**Initial value**: `visible`
  - `msScrollChaining` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'chained'; optional): **Syntax**: `chained | none`

**Initial value**: `chained`
  - `msScrollLimitXMax` (String | Real; optional): **Syntax**: `auto | <length>`

**Initial value**: `auto`
  - `msScrollLimitXMin` (String | Real; optional): **Syntax**: `<length>`

**Initial value**: `0`
  - `msScrollLimitYMax` (String | Real; optional): **Syntax**: `auto | <length>`

**Initial value**: `auto`
  - `msScrollLimitYMin` (String | Real; optional): **Syntax**: `<length>`

**Initial value**: `0`
  - `msScrollRails` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'railed'; optional): **Syntax**: `none | railed`

**Initial value**: `railed`
  - `msScrollSnapPointsX` (optional): **Syntax**: `snapInterval( <length-percentage>, <length-percentage> ) | snapList( <length-percentage># )`

**Initial value**: `snapInterval(0px, 100%)`
  - `msScrollSnapPointsY` (optional): **Syntax**: `snapInterval( <length-percentage>, <length-percentage> ) | snapList( <length-percentage># )`

**Initial value**: `snapInterval(0px, 100%)`
  - `msScrollSnapType` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **Syntax**: `none | proximity | mandatory`

**Initial value**: `none`
  - `msScrollTranslation` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'vertical-to-horizontal'; optional): **Syntax**: `none | vertical-to-horizontal`

**Initial value**: `none`
  - `msScrollbar3dlightColor` (optional): **Syntax**: `<color>`

**Initial value**: depends on user agent
  - `msScrollbarArrowColor` (optional): **Syntax**: `<color>`

**Initial value**: `ButtonText`
  - `msScrollbarBaseColor` (optional): **Syntax**: `<color>`

**Initial value**: depends on user agent
  - `msScrollbarDarkshadowColor` (optional): **Syntax**: `<color>`

**Initial value**: `ThreeDDarkShadow`
  - `msScrollbarFaceColor` (optional): **Syntax**: `<color>`

**Initial value**: `ThreeDFace`
  - `msScrollbarHighlightColor` (optional): **Syntax**: `<color>`

**Initial value**: `ThreeDHighlight`
  - `msScrollbarShadowColor` (optional): **Syntax**: `<color>`

**Initial value**: `ThreeDDarkShadow`
  - `msScrollbarTrackColor` (optional): **Syntax**: `<color>`

**Initial value**: `Scrollbar`
  - `msTextAutospace` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'ideograph-alpha', 'ideograph-numeric', 'ideograph-parenthesis', 'ideograph-space'; optional): **Syntax**: `none | ideograph-alpha | ideograph-numeric | ideograph-parenthesis | ideograph-space`

**Initial value**: `none`
  - `msTextCombineHorizontal` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | all | [ digits <integer>? ]`

**Initial value**: `none`
  - `msTextOverflow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**Initial value**: `clip`
  - `msTouchAction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2019.

**Syntax**: `auto | none | [ [ pan-x | pan-left | pan-right ] || [ pan-y | pan-up | pan-down ] || pinch-zoom ] | manipulation`

**Initial value**: `auto`
  - `msTouchSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'grippers'; optional): **Syntax**: `grippers | none`

**Initial value**: `grippers`
  - `msTransform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <transform-list>`

**Initial value**: `none`
  - `msTransformOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**Initial value**: `50% 50% 0`
  - `msTransitionDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `msTransitionDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `msTransitionProperty` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <single-transition-property>#`

**Initial value**: all
  - `msTransitionTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
  - `msUserSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'text', 'element'; optional): **Syntax**: `none | element | text`

**Initial value**: `text`
  - `msWordBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word', 'auto-phrase', 'break-all', 'keep-all'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `normal | break-all | keep-all | break-word | auto-phrase`

**Initial value**: `normal`
  - `msWrapFlow` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'end', 'start', 'both', 'clear', 'maximum'; optional): **Syntax**: `auto | both | start | end | maximum | clear`

**Initial value**: `auto`
  - `msWrapMargin` (String | Real; optional): **Syntax**: `<length>`

**Initial value**: `0`
  - `msWrapThrough` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'wrap'; optional): **Syntax**: `wrap | none`

**Initial value**: `wrap`
  - `msWritingMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**Initial value**: `horizontal-tb`
  - `WebkitAlignContent` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position>`

**Initial value**: `normal`
  - `WebkitAlignItems` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | stretch | <baseline-position> | [ <overflow-position>? <self-position> ] | anchor-center`

**Initial value**: `normal`
  - `WebkitAlignSelf` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? <self-position> | anchor-center`

**Initial value**: `auto`
  - `WebkitAnimationDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `WebkitAnimationDirection` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-direction>#`

**Initial value**: `normal`
  - `WebkitAnimationDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ auto | <time [0s,∞]> ]#`

**Initial value**: `0s`
  - `WebkitAnimationFillMode` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-fill-mode>#`

**Initial value**: `none`
  - `WebkitAnimationIterationCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-iteration-count>#`

**Initial value**: `1`
  - `WebkitAnimationName` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ none | <keyframes-name> ]#`

**Initial value**: `none`
  - `WebkitAnimationPlayState` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-play-state>#`

**Initial value**: `running`
  - `WebkitAnimationTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
  - `WebkitAppearance` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'meter', 'progress-bar', 'radio', 'searchfield', 'textarea', 'menulist-button', 'textfield', 'button-bevel', 'caret', 'listitem', 'menulist-text', 'menulist-textfield', '-apple-pay-button', 'default-button', 'inner-spin-button', 'media-controls-background', 'media-controls-fullscreen-background', 'media-current-time-display', 'media-enter-fullscreen-button', 'media-exit-fullscreen-button', 'media-fullscreen-button', 'media-mute-button', 'media-overlay-play-button', 'media-play-button', 'media-seek-back-button', 'media-seek-forward-button', 'media-slider', 'media-sliderthumb', 'media-time-remaining-display', 'media-toggle-closed-captions-button', 'media-volume-slider', 'media-volume-slider-container', 'media-volume-sliderthumb', 'progress-bar-value', 'push-button', 'searchfield-cancel-button', 'searchfield-decoration', 'searchfield-results-button', 'searchfield-results-decoration', 'slider-horizontal', 'slider-vertical', 'sliderthumb-horizontal', 'sliderthumb-vertical', 'square-button'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | button | button-bevel | caret | checkbox | default-button | inner-spin-button | listbox | listitem | media-controls-background | media-controls-fullscreen-background | media-current-time-display | media-enter-fullscreen-button | media-exit-fullscreen-button | media-fullscreen-button | media-mute-button | media-overlay-play-button | media-play-button | media-seek-back-button | media-seek-forward-button | media-slider | media-sliderthumb | media-time-remaining-display | media-toggle-closed-captions-button | media-volume-slider | media-volume-slider-container | media-volume-sliderthumb | menulist | menulist-button | menulist-text | menulist-textfield | meter | progress-bar | progress-bar-value | push-button | radio | searchfield | searchfield-cancel-button | searchfield-decoration | searchfield-results-button | searchfield-results-decoration | slider-horizontal | slider-vertical | sliderthumb-horizontal | sliderthumb-vertical | square-button | textarea | textfield | -apple-pay-button`

**Initial value**: `none` (but this value is overridden in the user agent CSS)
  - `WebkitBackdropFilter` (optional): Since September 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | <filter-value-list>`

**Initial value**: `none`
  - `WebkitBackfaceVisibility` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `visible | hidden`

**Initial value**: `visible`
  - `WebkitBackgroundClip` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-clip>#`

**Initial value**: `border-box`
  - `WebkitBackgroundOrigin` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<visual-box>#`

**Initial value**: `padding-box`
  - `WebkitBackgroundSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-size>#`

**Initial value**: `auto auto`
  - `WebkitBorderBeforeColor` (optional): **Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitBorderBeforeStyle` (optional): **Syntax**: `<'border-style'>`

**Initial value**: `none`
  - `WebkitBorderBeforeWidth` (String | Real; optional): **Syntax**: `<'border-width'>`

**Initial value**: `medium`
  - `WebkitBorderBottomLeftRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
  - `WebkitBorderBottomRightRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
  - `WebkitBorderImageSlice` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ <number [0,∞]> | <percentage [0,∞]> ]{1,4}  && fill?`

**Initial value**: `100%`
  - `WebkitBorderTopLeftRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
  - `WebkitBorderTopRightRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
  - `WebkitBoxDecorationBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'clone', 'slice'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `slice | clone`

**Initial value**: `slice`
  - `WebkitBoxReflect` (String | Real; optional): The **`-webkit-box-reflect`** CSS property lets you reflect the content of an element in one specific direction.

**Syntax**: `[ above | below | right | left ]? <length>? <image>?`

**Initial value**: `none`
  - `WebkitBoxShadow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <shadow>#`

**Initial value**: `none`
  - `WebkitBoxSizing` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `content-box | border-box`

**Initial value**: `content-box`
  - `WebkitClipPath` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<clip-source> | [ <basic-shape> || <geometry-box> ] | none`

**Initial value**: `none`
  - `WebkitColumnCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<integer> | auto`

**Initial value**: `auto`
  - `WebkitColumnFill` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `auto | balance`

**Initial value**: `balance`
  - `WebkitColumnRuleColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitColumnRuleStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-style'>`

**Initial value**: `none`
  - `WebkitColumnRuleWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'border-width'>`

**Initial value**: `medium`
  - `WebkitColumnSpan` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `none | all`

**Initial value**: `none`
  - `WebkitColumnWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since November 2016.

**Syntax**: `<length> | auto`

**Initial value**: `auto`
  - `WebkitFilter` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2016.

**Syntax**: `none | <filter-value-list>`

**Initial value**: `none`
  - `WebkitFlexBasis` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `content | <'width'>`

**Initial value**: `auto`
  - `WebkitFlexDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `row | row-reverse | column | column-reverse`

**Initial value**: `row`
  - `WebkitFlexGrow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<number>`

**Initial value**: `0`
  - `WebkitFlexShrink` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<number>`

**Initial value**: `1`
  - `WebkitFlexWrap` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap', 'wrap-reverse'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `nowrap | wrap | wrap-reverse`

**Initial value**: `nowrap`
  - `WebkitFontFeatureSettings` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `normal | <feature-tag-value>#`

**Initial value**: `normal`
  - `WebkitFontKerning` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'none'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `auto | normal | none`

**Initial value**: `auto`
  - `WebkitFontSmoothing` (String | Real; optional): The **`font-smooth`** CSS property controls the application of anti-aliasing when fonts are rendered.

**Syntax**: `auto | never | always | <absolute-size> | <length>`

**Initial value**: `auto`
  - `WebkitFontVariantLigatures` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]`

**Initial value**: `normal`
  - `WebkitHyphenateCharacter` (optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `auto | <string>`

**Initial value**: `auto`
  - `WebkitHyphens` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): Since September 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `none | manual | auto`

**Initial value**: `manual`
  - `WebkitInitialLetter` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `normal | [ <number> <integer>? ]`

**Initial value**: `normal`
  - `WebkitJustifyContent` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ]`

**Initial value**: `normal`
  - `WebkitLineBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | loose | normal | strict | anywhere`

**Initial value**: `auto`
  - `WebkitLineClamp` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <integer>`

**Initial value**: `none`
  - `WebkitLogicalHeight` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'width'>`

**Initial value**: `auto`
  - `WebkitLogicalWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'width'>`

**Initial value**: `auto`
  - `WebkitMarginEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`
  - `WebkitMarginStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'margin-top'>`

**Initial value**: `0`
  - `WebkitMaskAttachment` (optional): **Syntax**: `<attachment>#`

**Initial value**: `scroll`
  - `WebkitMaskBoxImageOutset` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <length> | <number> ]{1,4}`

**Initial value**: `0`
  - `WebkitMaskBoxImageRepeat` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ stretch | repeat | round | space ]{1,2}`

**Initial value**: `stretch`
  - `WebkitMaskBoxImageSlice` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<number-percentage>{1,4} fill?`

**Initial value**: `0`
  - `WebkitMaskBoxImageSource` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <image>`

**Initial value**: `none`
  - `WebkitMaskBoxImageWidth` (String | Real; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `[ <length-percentage> | <number> | auto ]{1,4}`

**Initial value**: `auto`
  - `WebkitMaskClip` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ <coord-box> | no-clip | border | padding | content | text ]#`

**Initial value**: `border`
  - `WebkitMaskComposite` (optional): The **`-webkit-mask-composite`** property specifies the manner in which multiple mask images applied to the same element are composited with one another. Mask images are composited in the opposite order that they are declared with the `-webkit-mask-image` property.

**Syntax**: `<composite-style>#`

**Initial value**: `source-over`
  - `WebkitMaskImage` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<mask-reference>#`

**Initial value**: `none`
  - `WebkitMaskOrigin` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ <coord-box> | border | padding | content ]#`

**Initial value**: `padding`
  - `WebkitMaskPosition` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<position>#`

**Initial value**: `0% 0%`
  - `WebkitMaskPositionX` (String | Real; optional): The `-webkit-mask-position-x` CSS property sets the initial horizontal position of a mask image.

**Syntax**: `[ <length-percentage> | left | center | right ]#`

**Initial value**: `0%`
  - `WebkitMaskPositionY` (String | Real; optional): The `-webkit-mask-position-y` CSS property sets the initial vertical position of a mask image.

**Syntax**: `[ <length-percentage> | top | center | bottom ]#`

**Initial value**: `0%`
  - `WebkitMaskRepeat` (optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<repeat-style>#`

**Initial value**: `repeat`
  - `WebkitMaskRepeatX` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'no-repeat', 'repeat', 'round', 'space'; optional): The `-webkit-mask-repeat-x` property specifies whether and how a mask image is repeated (tiled) horizontally.

**Syntax**: `repeat | no-repeat | space | round`

**Initial value**: `repeat`
  - `WebkitMaskRepeatY` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'no-repeat', 'repeat', 'round', 'space'; optional): The `-webkit-mask-repeat-y` property sets whether and how a mask image is repeated (tiled) vertically.

**Syntax**: `repeat | no-repeat | space | round`

**Initial value**: `repeat`
  - `WebkitMaskSize` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `<bg-size>#`

**Initial value**: `auto auto`
  - `WebkitMaxInlineSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'max-width'>`

**Initial value**: `none`
  - `WebkitOrder` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<integer>`

**Initial value**: `0`
  - `WebkitOverflowScrolling` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'touch'; optional): **Syntax**: `auto | touch`

**Initial value**: `auto`
  - `WebkitPaddingEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`
  - `WebkitPaddingStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<'padding-top'>`

**Initial value**: `0`
  - `WebkitPerspective` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <length>`

**Initial value**: `none`
  - `WebkitPerspectiveOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<position>`

**Initial value**: `50% 50%`
  - `WebkitPrintColorAdjust` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): Since May 2025, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `economy | exact`

**Initial value**: `economy`
  - `WebkitRubyPosition` (optional): Since December 2024, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ alternate || [ over | under ] ] | inter-character`

**Initial value**: `alternate`
  - `WebkitScrollSnapType` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2022.

**Syntax**: `none | [ x | y | block | inline | both ] [ mandatory | proximity ]?`

**Initial value**: `none`
  - `WebkitShapeMargin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<length-percentage>`

**Initial value**: `0`
  - `WebkitTapHighlightColor` (optional): **`-webkit-tap-highlight-color`** is a non-standard CSS property that sets the color of the highlight that appears over a link while it's being tapped. The highlighting indicates to the user that their tap is being successfully recognized, and indicates which element they're tapping on.

**Syntax**: `<color>`

**Initial value**: `black`
  - `WebkitTextCombine` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | all | [ digits <integer>? ]`

**Initial value**: `none`
  - `WebkitTextDecorationColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitTextDecorationLine` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**Initial value**: `none`
  - `WebkitTextDecorationSkip` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | [ objects || [ spaces | [ leading-spaces || trailing-spaces ] ] || edges || box-decoration ]`

**Initial value**: `objects`
  - `WebkitTextDecorationStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `solid | double | dotted | dashed | wavy`

**Initial value**: `solid`
  - `WebkitTextEmphasisColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitTextEmphasisPosition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `auto | [ over | under ] && [ right | left ]?`

**Initial value**: `auto`
  - `WebkitTextEmphasisStyle` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `none | [ [ filled | open ] || [ dot | circle | double-circle | triangle | sesame ] ] | <string>`

**Initial value**: `none`
  - `WebkitTextFillColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2016.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitTextOrientation` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'mixed', 'sideways', 'sideways-right', 'upright'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2020.

**Syntax**: `mixed | upright | sideways`

**Initial value**: `mixed`
  - `WebkitTextSizeAdjust` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | auto | <percentage>`

**Initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).
  - `WebkitTextStrokeColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
  - `WebkitTextStrokeWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<length>`

**Initial value**: `0`
  - `WebkitTextUnderlinePosition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | from-font | [ under || [ left | right ] ]`

**Initial value**: `auto`
  - `WebkitTouchCallout` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'default'; optional): The `-webkit-touch-callout` CSS property controls the display of the default callout shown when you touch and hold a touch target.

**Syntax**: `default | none`

**Initial value**: `default`
  - `WebkitTransform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <transform-list>`

**Initial value**: `none`
  - `WebkitTransformOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**Initial value**: `50% 50% 0`
  - `WebkitTransformStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `flat | preserve-3d`

**Initial value**: `flat`
  - `WebkitTransitionDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `WebkitTransitionDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
  - `WebkitTransitionProperty` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <single-transition-property>#`

**Initial value**: all
  - `WebkitTransitionTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
  - `WebkitUserModify` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'read-only', 'read-write', 'read-write-plaintext-only'; optional): **Syntax**: `read-only | read-write | read-write-plaintext-only`

**Initial value**: `read-only`
  - `WebkitUserSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | text | none | all`

**Initial value**: `auto`
  - `WebkitWritingMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**Initial value**: `horizontal-tb`
  - `MozAnimation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation>#`
  - `MozBorderImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
  - `MozColumnRule` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`
  - `MozColumns` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-width'> || <'column-count'>`
  - `MozOutlineRadius` (String | Real; optional): **Syntax**: `<outline-radius>{1,4} [ / <outline-radius>{1,4} ]?`
  - `MozTransition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-transition>#`
  - `msContentZoomLimit` (optional): **Syntax**: `<'-ms-content-zoom-limit-min'> <'-ms-content-zoom-limit-max'>`
  - `msContentZoomSnap` (optional): **Syntax**: `<'-ms-content-zoom-snap-type'> || <'-ms-content-zoom-snap-points'>`
  - `msFlex` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`
  - `msScrollLimit` (optional): **Syntax**: `<'-ms-scroll-limit-x-min'> <'-ms-scroll-limit-y-min'> <'-ms-scroll-limit-x-max'> <'-ms-scroll-limit-y-max'>`
  - `msScrollSnapX` (optional): **Syntax**: `<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-x'>`
  - `msScrollSnapY` (optional): **Syntax**: `<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-y'>`
  - `msTransition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-transition>#`
  - `WebkitAnimation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation>#`
  - `WebkitBorderBefore` (String | Real; optional): The **`-webkit-border-before`** CSS property is a shorthand property for setting the individual logical block start border property values in a single place in the style sheet.

**Syntax**: `<'border-width'> || <'border-style'> || <color>`
  - `WebkitBorderImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
  - `WebkitBorderRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`
  - `WebkitColumnRule` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`
  - `WebkitColumns` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<'column-width'> || <'column-count'>`
  - `WebkitFlex` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`
  - `WebkitFlexFlow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<'flex-direction'> || <'flex-wrap'>`
  - `WebkitMask` (String | Real; optional): Since December 2023, this feature works across the latest devices and browser versions. This feature might not work in older devices or browsers.

**Syntax**: `[ <mask-reference> || <position> [ / <bg-size> ]? || <repeat-style> || [ <visual-box> | border | padding | content | text ] || [ <visual-box> | border | padding | content ] ]#`
  - `WebkitMaskBoxImage` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `<'mask-border-source'> || <'mask-border-slice'> [ / <'mask-border-width'>? [ / <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>`
  - `WebkitTextEmphasis` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2022.

**Syntax**: `<'text-emphasis-style'> || <'text-emphasis-color'>`
  - `WebkitTextStroke` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2017.

**Syntax**: `<length> || <color>`
  - `WebkitTransition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-transition>#`
  - `boxAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): The **`box-align`** CSS property specifies how an element aligns its contents across its layout in a perpendicular direction. The effect of the property is only visible if there is extra space in the box.

**Syntax**: `start | center | end | baseline | stretch`

**Initial value**: `stretch`
@,deprecated
  - `boxDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): The **`box-direction`** CSS property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**Syntax**: `normal | reverse | inherit`

**Initial value**: `normal`
@,deprecated
  - `boxFlex` (optional): The **`-moz-box-flex`** and **`-webkit-box-flex`** CSS properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**Syntax**: `<number>`

**Initial value**: `0`
@,deprecated
  - `boxFlexGroup` (optional): The **`box-flex-group`** CSS property assigns the flexbox's child elements to a flex group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `boxLines` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): The **`box-lines`** CSS property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**Syntax**: `single | multiple`

**Initial value**: `single`
@,deprecated
  - `boxOrdinalGroup` (optional): The **`box-ordinal-group`** CSS property assigns the flexbox's child elements to an ordinal group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `boxOrient` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): The **`box-orient`** CSS property sets whether an element lays out its contents horizontally or vertically.

**Syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**Initial value**: `inline-axis`
@,deprecated
  - `boxPack` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): The **`-moz-box-pack`** and **`-webkit-box-pack`** CSS properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. The effect of this is only visible if there is extra space in the box.

**Syntax**: `start | center | end | justify`

**Initial value**: `start`
@,deprecated
  - `clip` (optional): The **`clip`** CSS property defines a visible portion of an element. The `clip` property applies only to absolutely positioned elements — that is, elements with `position:absolute` or `position:fixed`.

**Syntax**: `<shape> | auto`

**Initial value**: `auto`
@,deprecated
  - `fontStretch` (optional): The **`font-stretch`** CSS property selects a normal, condensed, or expanded face from a font.

**Syntax**: `<font-stretch-absolute>`

**Initial value**: `normal`
@,deprecated
  - `gridColumnGap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage>`

**Initial value**: `0`
@,deprecated
  - `gridGap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<'grid-row-gap'> <'grid-column-gap'>?`
@,deprecated
  - `gridRowGap` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since October 2017.

**Syntax**: `<length-percentage>`

**Initial value**: `0`
@,deprecated
  - `imeMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'active', 'disabled', 'inactive'; optional): **Syntax**: `auto | normal | active | inactive | disabled`

**Initial value**: `auto`
@,deprecated
  - `insetArea` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | <position-area>`

**Initial value**: `none`
@,deprecated
  - `offsetBlock` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>{1,2}`
@,deprecated
  - `offsetBlockEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`
@,deprecated
  - `offsetBlockStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`
@,deprecated
  - `offsetInline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>{1,2}`
@,deprecated
  - `offsetInlineEnd` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`
@,deprecated
  - `offsetInlineStart` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since April 2021.

**Syntax**: `<'top'>`

**Initial value**: `auto`
@,deprecated
  - `pageBreakAfter` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'always', 'avoid', 'recto', 'verso'; optional): The **`page-break-after`** CSS property adjusts page breaks _after_ the current element.

**Syntax**: `auto | always | avoid | left | right | recto | verso`

**Initial value**: `auto`
@,deprecated
  - `pageBreakBefore` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'always', 'avoid', 'recto', 'verso'; optional): The **`page-break-before`** CSS property adjusts page breaks _before_ the current element.

**Syntax**: `auto | always | avoid | left | right | recto | verso`

**Initial value**: `auto`
@,deprecated
  - `pageBreakInside` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'avoid'; optional): The **`page-break-inside`** CSS property adjusts page breaks _inside_ the current element.

**Syntax**: `auto | avoid`

**Initial value**: `auto`
@,deprecated
  - `positionTryOptions` (optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `none | [ [<dashed-ident> || <try-tactic>] | <'position-area'> ]#`

**Initial value**: `none`
@,deprecated
  - `scrollSnapCoordinate` (String | Real; optional): **Syntax**: `none | <position>#`

**Initial value**: `none`
@,deprecated
  - `scrollSnapDestination` (String | Real; optional): **Syntax**: `<position>`

**Initial value**: `0px 0px`
@,deprecated
  - `scrollSnapPointsX` (optional): **Syntax**: `none | repeat( <length-percentage> )`

**Initial value**: `none`
@,deprecated
  - `scrollSnapPointsY` (optional): **Syntax**: `none | repeat( <length-percentage> )`

**Initial value**: `none`
@,deprecated
  - `scrollSnapTypeX` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **Syntax**: `none | mandatory | proximity`

**Initial value**: `none`
@,deprecated
  - `scrollSnapTypeY` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **Syntax**: `none | mandatory | proximity`

**Initial value**: `none`
@,deprecated
  - `KhtmlBoxAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): The **`box-align`** CSS property specifies how an element aligns its contents across its layout in a perpendicular direction. The effect of the property is only visible if there is extra space in the box.

**Syntax**: `start | center | end | baseline | stretch`

**Initial value**: `stretch`
@,deprecated
  - `KhtmlBoxDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): The **`box-direction`** CSS property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**Syntax**: `normal | reverse | inherit`

**Initial value**: `normal`
@,deprecated
  - `KhtmlBoxFlex` (optional): The **`-moz-box-flex`** and **`-webkit-box-flex`** CSS properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**Syntax**: `<number>`

**Initial value**: `0`
@,deprecated
  - `KhtmlBoxFlexGroup` (optional): The **`box-flex-group`** CSS property assigns the flexbox's child elements to a flex group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `KhtmlBoxLines` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): The **`box-lines`** CSS property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**Syntax**: `single | multiple`

**Initial value**: `single`
@,deprecated
  - `KhtmlBoxOrdinalGroup` (optional): The **`box-ordinal-group`** CSS property assigns the flexbox's child elements to an ordinal group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `KhtmlBoxOrient` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): The **`box-orient`** CSS property sets whether an element lays out its contents horizontally or vertically.

**Syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**Initial value**: `inline-axis`
@,deprecated
  - `KhtmlBoxPack` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): The **`-moz-box-pack`** and **`-webkit-box-pack`** CSS properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. The effect of this is only visible if there is extra space in the box.

**Syntax**: `start | center | end | justify`

**Initial value**: `start`
@,deprecated
  - `KhtmlLineBreak` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2020.

**Syntax**: `auto | loose | normal | strict | anywhere`

**Initial value**: `auto`
@,deprecated
  - `KhtmlOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<opacity-value>`

**Initial value**: `1`
@,deprecated
  - `KhtmlUserSelect` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): This feature is not Baseline because it does not work in some of the most widely-used browsers.

**Syntax**: `auto | text | none | all`

**Initial value**: `auto`
@,deprecated
  - `MozBackgroundClip` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-clip>#`

**Initial value**: `border-box`
@,deprecated
  - `MozBackgroundOrigin` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<visual-box>#`

**Initial value**: `padding-box`
@,deprecated
  - `MozBackgroundSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-size>#`

**Initial value**: `auto auto`
@,deprecated
  - `MozBorderRadius` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`
@,deprecated
  - `MozBorderRadiusBottomleft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
@,deprecated
  - `MozBorderRadiusBottomright` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
@,deprecated
  - `MozBorderRadiusTopleft` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
@,deprecated
  - `MozBorderRadiusTopright` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<length-percentage [0,∞]>{1,2}`

**Initial value**: `0`
@,deprecated
  - `MozBoxAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): The **`box-align`** CSS property specifies how an element aligns its contents across its layout in a perpendicular direction. The effect of the property is only visible if there is extra space in the box.

**Syntax**: `start | center | end | baseline | stretch`

**Initial value**: `stretch`
@,deprecated
  - `MozBoxDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): The **`box-direction`** CSS property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**Syntax**: `normal | reverse | inherit`

**Initial value**: `normal`
@,deprecated
  - `MozBoxFlex` (optional): The **`-moz-box-flex`** and **`-webkit-box-flex`** CSS properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**Syntax**: `<number>`

**Initial value**: `0`
@,deprecated
  - `MozBoxOrdinalGroup` (optional): The **`box-ordinal-group`** CSS property assigns the flexbox's child elements to an ordinal group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `MozBoxOrient` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): The **`box-orient`** CSS property sets whether an element lays out its contents horizontally or vertically.

**Syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**Initial value**: `inline-axis`
@,deprecated
  - `MozBoxPack` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): The **`-moz-box-pack`** and **`-webkit-box-pack`** CSS properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. The effect of this is only visible if there is extra space in the box.

**Syntax**: `start | center | end | justify`

**Initial value**: `start`
@,deprecated
  - `MozBoxShadow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `none | <shadow>#`

**Initial value**: `none`
@,deprecated
  - `MozColumnCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `<integer> | auto`

**Initial value**: `auto`
@,deprecated
  - `MozColumnFill` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2017.

**Syntax**: `auto | balance`

**Initial value**: `balance`
@,deprecated
  - `MozFloatEdge` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box', 'padding-box', 'margin-box'; optional): The non-standard **`-moz-float-edge`** CSS property specifies whether the height and width properties of the element include the margin, border, or padding thickness.

**Syntax**: `border-box | content-box | margin-box | padding-box`

**Initial value**: `content-box`
@,deprecated
  - `MozForceBrokenImageIcon` (optional): The **`-moz-force-broken-image-icon`** extended CSS property can be used to force the broken image icon to be shown even when a broken image has an `alt` attribute.

**Syntax**: `0 | 1`

**Initial value**: `0`
@,deprecated
  - `MozOpacity` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<opacity-value>`

**Initial value**: `1`
@,deprecated
  - `MozOutline` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since March 2023.

**Syntax**: `<'outline-width'> || <'outline-style'> || <'outline-color'>`
@,deprecated
  - `MozOutlineColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <color>`

**Initial value**: `auto`
@,deprecated
  - `MozOutlineStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `auto | <outline-line-style>`

**Initial value**: `none`
@,deprecated
  - `MozOutlineWidth` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<line-width>`

**Initial value**: `medium`
@,deprecated
  - `MozTextAlignLast` (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'center', 'end', 'start', 'justify'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2022.

**Syntax**: `auto | start | end | left | right | center | justify`

**Initial value**: `auto`
@,deprecated
  - `MozTextDecorationColor` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<color>`

**Initial value**: `currentcolor`
@,deprecated
  - `MozTextDecorationLine` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**Initial value**: `none`
@,deprecated
  - `MozTextDecorationStyle` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `solid | double | dotted | dashed | wavy`

**Initial value**: `solid`
@,deprecated
  - `MozTransitionDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
@,deprecated
  - `MozTransitionDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
@,deprecated
  - `MozTransitionProperty` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <single-transition-property>#`

**Initial value**: all
@,deprecated
  - `MozTransitionTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
@,deprecated
  - `MozUserFocus` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'none', 'ignore', 'select-after', 'select-all', 'select-before', 'select-menu', 'select-same'; optional): The **`-moz-user-focus`** CSS property is used to indicate whether an element can have the focus.

**Syntax**: `ignore | normal | select-after | select-before | select-menu | select-same | select-all | none`

**Initial value**: `none`
@,deprecated
  - `MozUserInput` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'disabled', 'enabled'; optional): In Mozilla applications, **`-moz-user-input`** determines if an element will accept user input.

**Syntax**: `auto | none | enabled | disabled`

**Initial value**: `auto`
@,deprecated
  - `msImeMode` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'active', 'disabled', 'inactive'; optional): **Syntax**: `auto | normal | active | inactive | disabled`

**Initial value**: `auto`
@,deprecated
  - `OAnimation` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation>#`
@,deprecated
  - `OAnimationDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
@,deprecated
  - `OAnimationDirection` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-direction>#`

**Initial value**: `normal`
@,deprecated
  - `OAnimationDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ auto | <time [0s,∞]> ]#`

**Initial value**: `0s`
@,deprecated
  - `OAnimationFillMode` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-fill-mode>#`

**Initial value**: `none`
@,deprecated
  - `OAnimationIterationCount` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-iteration-count>#`

**Initial value**: `1`
@,deprecated
  - `OAnimationName` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ none | <keyframes-name> ]#`

**Initial value**: `none`
@,deprecated
  - `OAnimationPlayState` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-animation-play-state>#`

**Initial value**: `running`
@,deprecated
  - `OAnimationTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
@,deprecated
  - `OBackgroundSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<bg-size>#`

**Initial value**: `auto auto`
@,deprecated
  - `OBorderImage` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
@,deprecated
  - `OObjectFit` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'contain', 'cover', 'fill', 'scale-down'; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `fill | contain | cover | none | scale-down`

**Initial value**: `fill`
@,deprecated
  - `OObjectPosition` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since January 2020.

**Syntax**: `<position>`

**Initial value**: `50% 50%`
@,deprecated
  - `OTabSize` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since August 2021.

**Syntax**: `<integer> | <length>`

**Initial value**: `8`
@,deprecated
  - `OTextOverflow` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since July 2015.

**Syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**Initial value**: `clip`
@,deprecated
  - `OTransform` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <transform-list>`

**Initial value**: `none`
@,deprecated
  - `OTransformOrigin` (String | Real; optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**Initial value**: `50% 50% 0`
@,deprecated
  - `OTransition` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<single-transition>#`
@,deprecated
  - `OTransitionDelay` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
@,deprecated
  - `OTransitionDuration` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<time>#`

**Initial value**: `0s`
@,deprecated
  - `OTransitionProperty` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `none | <single-transition-property>#`

**Initial value**: all
@,deprecated
  - `OTransitionTimingFunction` (optional): This feature is well established and works across many devices and browser versions. It’s been available across browsers since September 2015.

**Syntax**: `<easing-function>#`

**Initial value**: `ease`
@,deprecated
  - `WebkitBoxAlign` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): The **`box-align`** CSS property specifies how an element aligns its contents across its layout in a perpendicular direction. The effect of the property is only visible if there is extra space in the box.

**Syntax**: `start | center | end | baseline | stretch`

**Initial value**: `stretch`
@,deprecated
  - `WebkitBoxDirection` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): The **`box-direction`** CSS property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**Syntax**: `normal | reverse | inherit`

**Initial value**: `normal`
@,deprecated
  - `WebkitBoxFlex` (optional): The **`-moz-box-flex`** and **`-webkit-box-flex`** CSS properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**Syntax**: `<number>`

**Initial value**: `0`
@,deprecated
  - `WebkitBoxFlexGroup` (optional): The **`box-flex-group`** CSS property assigns the flexbox's child elements to a flex group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `WebkitBoxLines` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): The **`box-lines`** CSS property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**Syntax**: `single | multiple`

**Initial value**: `single`
@,deprecated
  - `WebkitBoxOrdinalGroup` (optional): The **`box-ordinal-group`** CSS property assigns the flexbox's child elements to an ordinal group.

**Syntax**: `<integer>`

**Initial value**: `1`
@,deprecated
  - `WebkitBoxOrient` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): The **`box-orient`** CSS property sets whether an element lays out its contents horizontally or vertically.

**Syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**Initial value**: `inline-axis`
@,deprecated
  - `WebkitBoxPack` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): The **`-moz-box-pack`** and **`-webkit-box-pack`** CSS properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. The effect of this is only visible if there is extra space in the box.

**Syntax**: `start | center | end | justify`

**Initial value**: `start`
@,deprecated
  - `colorInterpolation` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'linearRGB', 'sRGB'; optional)
  - `colorRendering` (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'optimizeSpeed', 'optimizeQuality'; optional)
  - `glyphOrientationVertical` (optional)
- `supportsPopout` (Bool; optional): If left undefined will do simple check based on userAgent
- `useStateForModel` (Bool; optional): Flag that we should use internal state to manage the layout. If the layout is not being
used by dash anywhere (for example, saving and re-hydrating the layout), it is more efficient
to use the internal state (as this limits the number of round trips between JSON
and the Model object).

WARNING: If you set this, do not expect the dash property `model` to reflect the current
state of the layout!
"""
function dashflexlayout(; kwargs...)
        available_props = Symbol[:children, :id, :colorScheme, :debugMode, :font, :headers, :loading_state, :model, :popoutURL, :realtimeResize, :style, :supportsPopout, :useStateForModel]
        wild_props = Symbol[]
        return Component("dashflexlayout", "DashFlexLayout", "dash_flex_layout", available_props, wild_props; kwargs...)
end

dashflexlayout(children::Any; kwargs...) = dashflexlayout(;kwargs..., children = children)
dashflexlayout(children_maker::Function; kwargs...) = dashflexlayout(children_maker(); kwargs...)

