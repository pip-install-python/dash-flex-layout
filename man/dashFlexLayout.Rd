% Auto-generated: do not edit by hand
\name{dashFlexLayout}

\alias{dashFlexLayout}

\title{DashFlexLayout component}

\description{
DashFlexLayout is a wrapper around FlexLayout-React that provides flexible docking windows for Dash applications. * Features: - Dockable, resizable, and floatable window panels - Drag-and-drop tab management - Seamless Mantine theme integration (light/dark mode) - Dash 2 and Dash 3 compatibility
}

\usage{
dashFlexLayout(children=NULL, id=NULL, colorScheme=NULL, debugMode=NULL,
font=NULL, headers=NULL, loading_state=NULL, model=NULL,
popoutURL=NULL, realtimeResize=NULL, style=NULL,
supportsPopout=NULL, useStateForModel=NULL)
}

\arguments{
\item{children}{A list of or a singular dash component, string or number. List of children to be rendered. Children are allocated to their respective tab
based on the ID of the element.

WARNING: There is no validation done on whether the children here will be rendered in any tab.
If there is no matching tab for a particular ID, that element will be silently ignored in
rendering (although callbacks will still be applied).}

\item{id}{Character. Unique ID to identify this component in Dash callbacks.}

\item{colorScheme}{A value equal to: 'light', 'dark'. Current color scheme, automatically detected from Mantine theme
If not specified, will try to auto-detect from HTML data-mantine-color-scheme}

\item{debugMode}{Logical. Debug mode flag}

\item{font}{Logical | numeric | character | named list | unnamed list. The tab font (overrides value in css).
Example: font={{size:"12px", style:"italic"}}}

\item{headers}{List with named elements and values of type a list of or a singular dash component, string or number. Map of headers to render for each tab. Uses the `onRenderTab` function to override
the default headers, where a custom header mapping is supplied.

Note: where possible, it is likely better to use classes to style the headers, rather than
using this prop.}

\item{loading_state}{Lists containing elements 'is_loading', 'component_name', 'prop_name'.
those elements have the following types:
  - is_loading (logical; required)
  - component_name (character; required)
  - prop_name (character; required). Loading state.}

\item{model}{Lists containing elements 'global', 'borders', 'layout', 'popouts'.
those elements have the following types:
  - global (optional): . global has the following type: lists containing elements 'borderautoselecttabwhenclosed', 'borderautoselecttabwhenopen', 'borderclassname', 'borderenableautohide', 'borderenabledrop', 'borderenabletabscrollbar', 'bordermaxsize', 'borderminsize', 'bordersize', 'enableedgedock', 'enablerotatebordericons', 'rootorientationvertical', 'splitterenablehandle', 'splitterextra', 'splittersize', 'tabborderheight', 'tabborderwidth', 'tabclassname', 'tabclosetype', 'tabcontentclassname', 'tabdragspeed', 'tabenableclose', 'tabenabledrag', 'tabenablepopout', 'tabenablepopouticon', 'tabenablepopoutoverlay', 'tabenablerename', 'tabenablerenderondemand', 'tabicon', 'tabmaxheight', 'tabmaxwidth', 'tabminheight', 'tabminwidth', 'tabsetautoselecttab', 'tabsetclassnametabstrip', 'tabsetenableactiveicon', 'tabsetenableclose', 'tabsetenabledeletewhenempty', 'tabsetenabledivide', 'tabsetenabledrag', 'tabsetenabledrop', 'tabsetenablemaximize', 'tabsetenablesingletabstretch', 'tabsetenabletabscrollbar', 'tabsetenabletabstrip', 'tabsetenabletabwrap', 'tabsetmaxheight', 'tabsetmaxwidth', 'tabsetminheight', 'tabsetminwidth', 'tabsettablocation'.
those elements have the following types:
  - borderautoselecttabwhenclosed (logical; optional): value for bordernode attribute autoselecttabwhenclosed if not overridden

whether to select new/moved tabs in border when the border is currently closed

default: false
  - borderautoselecttabwhenopen (logical; optional): value for bordernode attribute autoselecttabwhenopen if not overridden

whether to select new/moved tabs in border when the border is already open

default: true
  - borderclassname (character; optional): value for bordernode attribute classname if not overridden

class applied to tab button

default: undefined
  - borderenableautohide (logical; optional): value for bordernode attribute enableautohide if not overridden

hide border if it has zero tabs

default: false
  - borderenabledrop (logical; optional): value for bordernode attribute enabledrop if not overridden

whether tabs can be dropped into this border

default: true
  - borderenabletabscrollbar (logical; optional): value for bordernode attribute enabletabscrollbar if not overridden

whether to show a mini scrollbar for the tabs

default: false
  - bordermaxsize (numeric; optional): value for bordernode attribute maxsize if not overridden

the maximum size of the tab area

default: 99999
  - borderminsize (numeric; optional): value for bordernode attribute minsize if not overridden

the minimum size of the tab area

default: 0
  - bordersize (numeric; optional): value for bordernode attribute size if not overridden

size of the tab area when selected

default: 200
  - enableedgedock (logical; optional): enable docking to the edges of the layout, this will show the edge indicators

default: true
  - enablerotatebordericons (logical; optional): boolean indicating if tab icons should rotate with the text in the left and right borders

default: true
  - rootorientationvertical (logical; optional): the top level 'row' will layout horizontally by default, set this option true to make it layout vertically

default: false
  - splitterenablehandle (logical; optional): enable a small centralized handle on all splitters

default: false
  - splitterextra (numeric; optional): additional width in pixels of the splitter hit test area

default: 0
  - splittersize (numeric; optional): width in pixels of all splitters between tabsets/borders

default: 8
  - tabborderheight (numeric; optional): value for tabnode attribute borderheight if not overridden

height when added to border, -1 will use border size

default: -1
  - tabborderwidth (numeric; optional): value for tabnode attribute borderwidth if not overridden

width when added to border, -1 will use border size

default: -1
  - tabclassname (character; optional): value for tabnode attribute classname if not overridden

class applied to tab button

default: undefined
  - tabclosetype (a value equal to: 1, 2, 3; optional): value for tabnode attribute closetype if not overridden

see values in iclosetype

default: 1
  - tabcontentclassname (character; optional): value for tabnode attribute contentclassname if not overridden

class applied to tab content

default: undefined
  - tabdragspeed (numeric; optional): 

default: 0.3
  - tabenableclose (logical; optional): value for tabnode attribute enableclose if not overridden

allow user to close tab via close button

default: true
  - tabenabledrag (logical; optional): value for tabnode attribute enabledrag if not overridden

allow user to drag tab to new location

default: true
  - tabenablepopout (logical; optional): value for tabnode attribute enablepopout if not overridden

enable popout (in popout capable browser)

default: false
  - tabenablepopouticon (logical; optional): value for tabnode attribute enablepopouticon if not overridden

whether to show the popout icon in the tabset header if this tab enables popouts

default: true
  - tabenablepopoutoverlay (logical; optional): value for tabnode attribute enablepopoutoverlay if not overridden

if this tab will not work correctly in a popout window when the main window is backgrounded (inactive)
      then enabling this option will gray out this tab

default: false
  - tabenablerename (logical; optional): value for tabnode attribute enablerename if not overridden

allow user to rename tabs by double clicking

default: true
  - tabenablerenderondemand (logical; optional): value for tabnode attribute enablerenderondemand if not overridden

whether to avoid rendering component until tab is visible

default: true
  - tabicon (character; optional): value for tabnode attribute icon if not overridden

the tab icon

default: undefined
  - tabmaxheight (numeric; optional): value for tabnode attribute maxheight if not overridden

the max height of this tab

default: 99999
  - tabmaxwidth (numeric; optional): value for tabnode attribute maxwidth if not overridden

the max width of this tab

default: 99999
  - tabminheight (numeric; optional): value for tabnode attribute minheight if not overridden

the min height of this tab

default: 0
  - tabminwidth (numeric; optional): value for tabnode attribute minwidth if not overridden

the min width of this tab

default: 0
  - tabsetautoselecttab (logical; optional): value for tabsetnode attribute autoselecttab if not overridden

whether to select new/moved tabs in tabset

default: true
  - tabsetclassnametabstrip (character; optional): value for tabsetnode attribute classnametabstrip if not overridden

a class name to apply to the tab strip

default: undefined
  - tabsetenableactiveicon (logical; optional): value for tabsetnode attribute enableactiveicon if not overridden

whether the active icon (*) should be displayed when the tabset is active

default: false
  - tabsetenableclose (logical; optional): value for tabsetnode attribute enableclose if not overridden

allow user to close tabset via a close button

default: false
  - tabsetenabledeletewhenempty (logical; optional): value for tabsetnode attribute enabledeletewhenempty if not overridden

whether to delete this tabset when is has no tabs

default: true
  - tabsetenabledivide (logical; optional): value for tabsetnode attribute enabledivide if not overridden

allow user to drag tabs to region of this tabset, splitting into new tabset

default: true
  - tabsetenabledrag (logical; optional): value for tabsetnode attribute enabledrag if not overridden

allow user to drag tabs out this tabset

default: true
  - tabsetenabledrop (logical; optional): value for tabsetnode attribute enabledrop if not overridden

allow user to drag tabs into this tabset

default: true
  - tabsetenablemaximize (logical; optional): value for tabsetnode attribute enablemaximize if not overridden

allow user to maximize tabset to fill view via maximize button

default: true
  - tabsetenablesingletabstretch (logical; optional): value for tabsetnode attribute enablesingletabstretch if not overridden

if the tabset has only a single tab then stretch the single tab to fill area and display in a header style

default: false
  - tabsetenabletabscrollbar (logical; optional): value for tabsetnode attribute enabletabscrollbar if not overridden

whether to show a mini scrollbar for the tabs

default: false
  - tabsetenabletabstrip (logical; optional): value for tabsetnode attribute enabletabstrip if not overridden

enable tab strip and allow multiple tabs in this tabset

default: true
  - tabsetenabletabwrap (logical; optional): value for tabsetnode attribute enabletabwrap if not overridden

wrap tabs onto multiple lines

default: false
  - tabsetmaxheight (numeric; optional): value for tabsetnode attribute maxheight if not overridden

maximum height (in px) for this tabset

default: 99999
  - tabsetmaxwidth (numeric; optional): value for tabsetnode attribute maxwidth if not overridden

maximum width (in px) for this tabset

default: 99999
  - tabsetminheight (numeric; optional): value for tabsetnode attribute minheight if not overridden

minimum height (in px) for this tabset

default: 0
  - tabsetminwidth (numeric; optional): value for tabsetnode attribute minwidth if not overridden

minimum width (in px) for this tabset

default: 0
  - tabsettablocation (a value equal to: 'top', 'bottom'; optional): value for tabsetnode attribute tablocation if not overridden

the location of the tabs either top or bottom

default: "top"
  - borders (optional): . borders has the following type: list of lists containing elements 'location', 'children', 'autoselecttabwhenclosed', 'autoselecttabwhenopen', 'classname', 'config', 'enableautohide', 'enabledrop', 'enabletabscrollbar', 'maxsize', 'minsize', 'selected', 'show', 'size', 'type'.
those elements have the following types:
  - location (a value equal to: 'top', 'bottom', 'left', 'right'; required)
  - children (required): . children has the following type: list of lists containing elements 'altname', 'borderheight', 'borderwidth', 'classname', 'closetype', 'component', 'config', 'contentclassname', 'enableclose', 'enabledrag', 'enablepopout', 'enablepopouticon', 'enablepopoutoverlay', 'enablerename', 'enablerenderondemand', 'enablewindowremount', 'helptext', 'icon', 'id', 'maxheight', 'maxwidth', 'minheight', 'minwidth', 'name', 'tabsetclassname', 'type'.
those elements have the following types:
  - altname (character; optional): if there is no name specifed then this value will be used in the overflow menu

default: undefined
  - borderheight (numeric; optional): height when added to border, -1 will use border size

default: inherited from global attribute tabborderheight (default -1)
  - borderwidth (numeric; optional): width when added to border, -1 will use border size

default: inherited from global attribute tabborderwidth (default -1)
  - classname (character; optional): class applied to tab button

default: inherited from global attribute tabclassname (default undefined)
  - closetype (a value equal to: 1, 2, 3; optional): see values in iclosetype

default: inherited from global attribute tabclosetype (default 1)
  - component (character; optional): string identifying which component to run (for factory)

default: undefined
  - config (logical | numeric | character | named list | unnamed list; optional): a place to hold json config for the hosted component

default: undefined
  - contentclassname (character; optional): class applied to tab content

default: inherited from global attribute tabcontentclassname (default undefined)
  - enableclose (logical; optional): allow user to close tab via close button

default: inherited from global attribute tabenableclose (default true)
  - enabledrag (logical; optional): allow user to drag tab to new location

default: inherited from global attribute tabenabledrag (default true)
  - enablepopout (logical; optional): enable popout (in popout capable browser)

default: inherited from global attribute tabenablepopout (default false)
  - enablepopouticon (logical; optional): whether to show the popout icon in the tabset header if this tab enables popouts

default: inherited from global attribute tabenablepopouticon (default true)
  - enablepopoutoverlay (logical; optional): if this tab will not work correctly in a popout window when the main window is backgrounded (inactive)
      then enabling this option will gray out this tab

default: inherited from global attribute tabenablepopoutoverlay (default false)
  - enablerename (logical; optional): allow user to rename tabs by double clicking

default: inherited from global attribute tabenablerename (default true)
  - enablerenderondemand (logical; optional): whether to avoid rendering component until tab is visible

default: inherited from global attribute tabenablerenderondemand (default true)
  - enablewindowremount (logical; optional): if enabled the tab will re-mount when popped out/in

default: false
  - helptext (character; optional): an optional help text for the tab to be displayed upon tab hover.

default: undefined
  - icon (character; optional): the tab icon

default: inherited from global attribute tabicon (default undefined)
  - id (character; optional): the unique id of the tab, if left undefined a uuid will be assigned

default: undefined
  - maxheight (numeric; optional): the max height of this tab

default: inherited from global attribute tabmaxheight (default 99999)
  - maxwidth (numeric; optional): the max width of this tab

default: inherited from global attribute tabmaxwidth (default 99999)
  - minheight (numeric; optional): the min height of this tab

default: inherited from global attribute tabminheight (default 0)
  - minwidth (numeric; optional): the min width of this tab

default: inherited from global attribute tabminwidth (default 0)
  - name (character; optional): name of tab to be displayed in the tab button

default: "[unnamed tab]"
  - tabsetclassname (character; optional): class applied to parent tabset when this is the only tab and it is stretched to fill the tabset

default: undefined
  - type (character; optional): 

fixed value: "tab"s
  - autoselecttabwhenclosed (logical; optional): whether to select new/moved tabs in border when the border is currently closed

default: inherited from global attribute borderautoselecttabwhenclosed (default false)
  - autoselecttabwhenopen (logical; optional): whether to select new/moved tabs in border when the border is already open

default: inherited from global attribute borderautoselecttabwhenopen (default true)
  - classname (character; optional): class applied to tab button

default: inherited from global attribute borderclassname (default undefined)
  - config (logical | numeric | character | named list | unnamed list; optional): a place to hold json config used in your own code

default: undefined
  - enableautohide (logical; optional): hide border if it has zero tabs

default: inherited from global attribute borderenableautohide (default false)
  - enabledrop (logical; optional): whether tabs can be dropped into this border

default: inherited from global attribute borderenabledrop (default true)
  - enabletabscrollbar (logical; optional): whether to show a mini scrollbar for the tabs

default: inherited from global attribute borderenabletabscrollbar (default false)
  - maxsize (numeric; optional): the maximum size of the tab area

default: inherited from global attribute bordermaxsize (default 99999)
  - minsize (numeric; optional): the minimum size of the tab area

default: inherited from global attribute borderminsize (default 0)
  - selected (numeric; optional): index of selected/visible tab in border; -1 means no tab selected

default: -1
  - show (logical; optional): show/hide this border

default: true
  - size (numeric; optional): size of the tab area when selected

default: inherited from global attribute bordersize (default 200)
  - type (character; optional): 

fixed value: "border"s
  - layout (required): . layout has the following type: lists containing elements 'children', 'id', 'type', 'weight'.
those elements have the following types:
  - children (list of logical | numeric | character | named list | unnamed lists; required)
  - id (character; optional): the unique id of the row, if left undefined a uuid will be assigned

default: undefined
  - type (character; optional): 

fixed value: "row"
  - weight (numeric; optional): relative weight for sizing of this row in parent row

default: 100
  - popouts (optional): . popouts has the following type: lists containing elements .
those elements have the following types:
. Model layout.}

\item{popoutURL}{Character. URL of popout window relative to origin, defaults to popout.html}

\item{realtimeResize}{Logical. Boolean value, defaults to false, resize tabs as splitters are dragged.
Warning: this can cause resizing to become choppy when tabs are slow to draw}

\item{style}{Lists containing elements 'accentcolor', 'aligncontent', 'alignitems', 'alignself', 'aligntracks', 'alignmentbaseline', 'anchorname', 'anchorscope', 'animationcomposition', 'animationdelay', 'animationdirection', 'animationduration', 'animationfillmode', 'animationiterationcount', 'animationname', 'animationplaystate', 'animationrangeend', 'animationrangestart', 'animationtimeline', 'animationtimingfunction', 'appearance', 'aspectratio', 'backdropfilter', 'backfacevisibility', 'backgroundattachment', 'backgroundblendmode', 'backgroundclip', 'backgroundcolor', 'backgroundimage', 'backgroundorigin', 'backgroundpositionx', 'backgroundpositiony', 'backgroundrepeat', 'backgroundsize', 'baselineshift', 'blocksize', 'borderblockendcolor', 'borderblockendstyle', 'borderblockendwidth', 'borderblockstartcolor', 'borderblockstartstyle', 'borderblockstartwidth', 'borderbottomcolor', 'borderbottomleftradius', 'borderbottomrightradius', 'borderbottomstyle', 'borderbottomwidth', 'bordercollapse', 'borderendendradius', 'borderendstartradius', 'borderimageoutset', 'borderimagerepeat', 'borderimageslice', 'borderimagesource', 'borderimagewidth', 'borderinlineendcolor', 'borderinlineendstyle', 'borderinlineendwidth', 'borderinlinestartcolor', 'borderinlinestartstyle', 'borderinlinestartwidth', 'borderleftcolor', 'borderleftstyle', 'borderleftwidth', 'borderrightcolor', 'borderrightstyle', 'borderrightwidth', 'borderspacing', 'borderstartendradius', 'borderstartstartradius', 'bordertopcolor', 'bordertopleftradius', 'bordertoprightradius', 'bordertopstyle', 'bordertopwidth', 'bottom', 'boxdecorationbreak', 'boxshadow', 'boxsizing', 'breakafter', 'breakbefore', 'breakinside', 'captionside', 'caretcolor', 'caretshape', 'clear', 'clippath', 'cliprule', 'color', 'coloradjust', 'colorinterpolationfilters', 'colorscheme', 'columncount', 'columnfill', 'columngap', 'columnrulecolor', 'columnrulestyle', 'columnrulewidth', 'columnspan', 'columnwidth', 'contain', 'containintrinsicblocksize', 'containintrinsicheight', 'containintrinsicinlinesize', 'containintrinsicwidth', 'containername', 'containertype', 'content', 'contentvisibility', 'counterincrement', 'counterreset', 'counterset', 'cursor', 'cx', 'cy', 'd', 'direction', 'display', 'dominantbaseline', 'emptycells', 'fieldsizing', 'fill', 'fillopacity', 'fillrule', 'filter', 'flexbasis', 'flexdirection', 'flexgrow', 'flexshrink', 'flexwrap', 'float', 'floodcolor', 'floodopacity', 'fontfamily', 'fontfeaturesettings', 'fontkerning', 'fontlanguageoverride', 'fontopticalsizing', 'fontpalette', 'fontsize', 'fontsizeadjust', 'fontsmooth', 'fontstyle', 'fontsynthesis', 'fontsynthesisposition', 'fontsynthesissmallcaps', 'fontsynthesisstyle', 'fontsynthesisweight', 'fontvariant', 'fontvariantalternates', 'fontvariantcaps', 'fontvarianteastasian', 'fontvariantemoji', 'fontvariantligatures', 'fontvariantnumeric', 'fontvariantposition', 'fontvariationsettings', 'fontweight', 'fontwidth', 'forcedcoloradjust', 'gridautocolumns', 'gridautoflow', 'gridautorows', 'gridcolumnend', 'gridcolumnstart', 'gridrowend', 'gridrowstart', 'gridtemplateareas', 'gridtemplatecolumns', 'gridtemplaterows', 'hangingpunctuation', 'height', 'hyphenatecharacter', 'hyphenatelimitchars', 'hyphens', 'imageorientation', 'imagerendering', 'imageresolution', 'initialletter', 'initialletteralign', 'inlinesize', 'insetblockend', 'insetblockstart', 'insetinlineend', 'insetinlinestart', 'interpolatesize', 'isolation', 'justifycontent', 'justifyitems', 'justifyself', 'justifytracks', 'left', 'letterspacing', 'lightingcolor', 'linebreak', 'lineheight', 'lineheightstep', 'liststyleimage', 'liststyleposition', 'liststyletype', 'marginblockend', 'marginblockstart', 'marginbottom', 'margininlineend', 'margininlinestart', 'marginleft', 'marginright', 'margintop', 'margintrim', 'marker', 'markerend', 'markermid', 'markerstart', 'maskbordermode', 'maskborderoutset', 'maskborderrepeat', 'maskborderslice', 'maskbordersource', 'maskborderwidth', 'maskclip', 'maskcomposite', 'maskimage', 'maskmode', 'maskorigin', 'maskposition', 'maskrepeat', 'masksize', 'masktype', 'masonryautoflow', 'mathdepth', 'mathshift', 'mathstyle', 'maxblocksize', 'maxheight', 'maxinlinesize', 'maxlines', 'maxwidth', 'minblocksize', 'minheight', 'mininlinesize', 'minwidth', 'mixblendmode', 'motiondistance', 'motionpath', 'motionrotation', 'objectfit', 'objectposition', 'objectviewbox', 'offsetanchor', 'offsetdistance', 'offsetpath', 'offsetposition', 'offsetrotate', 'offsetrotation', 'opacity', 'order', 'orphans', 'outlinecolor', 'outlineoffset', 'outlinestyle', 'outlinewidth', 'overflowanchor', 'overflowblock', 'overflowclipbox', 'overflowclipmargin', 'overflowinline', 'overflowwrap', 'overflowx', 'overflowy', 'overlay', 'overscrollbehaviorblock', 'overscrollbehaviorinline', 'overscrollbehaviorx', 'overscrollbehaviory', 'paddingblockend', 'paddingblockstart', 'paddingbottom', 'paddinginlineend', 'paddinginlinestart', 'paddingleft', 'paddingright', 'paddingtop', 'page', 'paintorder', 'perspective', 'perspectiveorigin', 'pointerevents', 'position', 'positionanchor', 'positionarea', 'positiontryfallbacks', 'positiontryorder', 'positionvisibility', 'printcoloradjust', 'quotes', 'r', 'resize', 'right', 'rotate', 'rowgap', 'rubyalign', 'rubymerge', 'rubyoverhang', 'rubyposition', 'rx', 'ry', 'scale', 'scrollbehavior', 'scrollinitialtarget', 'scrollmarginblockend', 'scrollmarginblockstart', 'scrollmarginbottom', 'scrollmargininlineend', 'scrollmargininlinestart', 'scrollmarginleft', 'scrollmarginright', 'scrollmargintop', 'scrollpaddingblockend', 'scrollpaddingblockstart', 'scrollpaddingbottom', 'scrollpaddinginlineend', 'scrollpaddinginlinestart', 'scrollpaddingleft', 'scrollpaddingright', 'scrollpaddingtop', 'scrollsnapalign', 'scrollsnapmarginbottom', 'scrollsnapmarginleft', 'scrollsnapmarginright', 'scrollsnapmargintop', 'scrollsnapstop', 'scrollsnaptype', 'scrolltimelineaxis', 'scrolltimelinename', 'scrollbarcolor', 'scrollbargutter', 'scrollbarwidth', 'shapeimagethreshold', 'shapemargin', 'shapeoutside', 'shaperendering', 'speakas', 'stopcolor', 'stopopacity', 'stroke', 'strokecolor', 'strokedasharray', 'strokedashoffset', 'strokelinecap', 'strokelinejoin', 'strokemiterlimit', 'strokeopacity', 'strokewidth', 'tabsize', 'tablelayout', 'textalign', 'textalignlast', 'textanchor', 'textautospace', 'textbox', 'textboxedge', 'textboxtrim', 'textcombineupright', 'textdecorationcolor', 'textdecorationline', 'textdecorationskip', 'textdecorationskipink', 'textdecorationstyle', 'textdecorationthickness', 'textemphasiscolor', 'textemphasisposition', 'textemphasisstyle', 'textindent', 'textjustify', 'textorientation', 'textoverflow', 'textrendering', 'textshadow', 'textsizeadjust', 'textspacingtrim', 'texttransform', 'textunderlineoffset', 'textunderlineposition', 'textwrapmode', 'textwrapstyle', 'timelinescope', 'top', 'touchaction', 'transform', 'transformbox', 'transformorigin', 'transformstyle', 'transitionbehavior', 'transitiondelay', 'transitionduration', 'transitionproperty', 'transitiontimingfunction', 'translate', 'unicodebidi', 'userselect', 'vectoreffect', 'verticalalign', 'viewtimelineaxis', 'viewtimelineinset', 'viewtimelinename', 'viewtransitionclass', 'viewtransitionname', 'visibility', 'whitespace', 'whitespacecollapse', 'widows', 'width', 'willchange', 'wordbreak', 'wordspacing', 'wordwrap', 'writingmode', 'x', 'y', 'zindex', 'zoom', 'all', 'animation', 'animationrange', 'background', 'backgroundposition', 'border', 'borderblock', 'borderblockcolor', 'borderblockend', 'borderblockstart', 'borderblockstyle', 'borderblockwidth', 'borderbottom', 'bordercolor', 'borderimage', 'borderinline', 'borderinlinecolor', 'borderinlineend', 'borderinlinestart', 'borderinlinestyle', 'borderinlinewidth', 'borderleft', 'borderradius', 'borderright', 'borderstyle', 'bordertop', 'borderwidth', 'caret', 'columnrule', 'columns', 'containintrinsicsize', 'container', 'flex', 'flexflow', 'font', 'gap', 'grid', 'gridarea', 'gridcolumn', 'gridrow', 'gridtemplate', 'inset', 'insetblock', 'insetinline', 'lineclamp', 'liststyle', 'margin', 'marginblock', 'margininline', 'mask', 'maskborder', 'motion', 'offset', 'outline', 'overflow', 'overscrollbehavior', 'padding', 'paddingblock', 'paddinginline', 'placecontent', 'placeitems', 'placeself', 'positiontry', 'scrollmargin', 'scrollmarginblock', 'scrollmargininline', 'scrollpadding', 'scrollpaddingblock', 'scrollpaddinginline', 'scrollsnapmargin', 'scrolltimeline', 'textdecoration', 'textemphasis', 'textwrap', 'transition', 'viewtimeline', 'mozanimationdelay', 'mozanimationdirection', 'mozanimationduration', 'mozanimationfillmode', 'mozanimationiterationcount', 'mozanimationname', 'mozanimationplaystate', 'mozanimationtimingfunction', 'mozappearance', 'mozbackfacevisibility', 'mozbinding', 'mozborderbottomcolors', 'mozborderendcolor', 'mozborderendstyle', 'mozborderendwidth', 'mozborderleftcolors', 'mozborderrightcolors', 'mozborderstartcolor', 'mozborderstartstyle', 'mozbordertopcolors', 'mozboxsizing', 'mozcolumnrulecolor', 'mozcolumnrulestyle', 'mozcolumnrulewidth', 'mozcolumnwidth', 'mozcontextproperties', 'mozfontfeaturesettings', 'mozfontlanguageoverride', 'mozhyphens', 'mozmarginend', 'mozmarginstart', 'mozorient', 'mozosxfontsmoothing', 'mozoutlineradiusbottomleft', 'mozoutlineradiusbottomright', 'mozoutlineradiustopleft', 'mozoutlineradiustopright', 'mozpaddingend', 'mozpaddingstart', 'mozperspective', 'mozperspectiveorigin', 'mozstacksizing', 'moztabsize', 'moztextblink', 'moztextsizeadjust', 'moztransform', 'moztransformorigin', 'moztransformstyle', 'mozusermodify', 'mozuserselect', 'mozwindowdragging', 'mozwindowshadow', 'msaccelerator', 'msblockprogression', 'mscontentzoomchaining', 'mscontentzoomlimitmax', 'mscontentzoomlimitmin', 'mscontentzoomsnappoints', 'mscontentzoomsnaptype', 'mscontentzooming', 'msfilter', 'msflexdirection', 'msflexpositive', 'msflowfrom', 'msflowinto', 'msgridcolumns', 'msgridrows', 'mshighcontrastadjust', 'mshyphenatelimitchars', 'mshyphenatelimitlines', 'mshyphenatelimitzone', 'mshyphens', 'msimealign', 'mslinebreak', 'msorder', 'msoverflowstyle', 'msoverflowx', 'msoverflowy', 'msscrollchaining', 'msscrolllimitxmax', 'msscrolllimitxmin', 'msscrolllimitymax', 'msscrolllimitymin', 'msscrollrails', 'msscrollsnappointsx', 'msscrollsnappointsy', 'msscrollsnaptype', 'msscrolltranslation', 'msscrollbar3dlightcolor', 'msscrollbararrowcolor', 'msscrollbarbasecolor', 'msscrollbardarkshadowcolor', 'msscrollbarfacecolor', 'msscrollbarhighlightcolor', 'msscrollbarshadowcolor', 'msscrollbartrackcolor', 'mstextautospace', 'mstextcombinehorizontal', 'mstextoverflow', 'mstouchaction', 'mstouchselect', 'mstransform', 'mstransformorigin', 'mstransitiondelay', 'mstransitionduration', 'mstransitionproperty', 'mstransitiontimingfunction', 'msuserselect', 'mswordbreak', 'mswrapflow', 'mswrapmargin', 'mswrapthrough', 'mswritingmode', 'webkitaligncontent', 'webkitalignitems', 'webkitalignself', 'webkitanimationdelay', 'webkitanimationdirection', 'webkitanimationduration', 'webkitanimationfillmode', 'webkitanimationiterationcount', 'webkitanimationname', 'webkitanimationplaystate', 'webkitanimationtimingfunction', 'webkitappearance', 'webkitbackdropfilter', 'webkitbackfacevisibility', 'webkitbackgroundclip', 'webkitbackgroundorigin', 'webkitbackgroundsize', 'webkitborderbeforecolor', 'webkitborderbeforestyle', 'webkitborderbeforewidth', 'webkitborderbottomleftradius', 'webkitborderbottomrightradius', 'webkitborderimageslice', 'webkitbordertopleftradius', 'webkitbordertoprightradius', 'webkitboxdecorationbreak', 'webkitboxreflect', 'webkitboxshadow', 'webkitboxsizing', 'webkitclippath', 'webkitcolumncount', 'webkitcolumnfill', 'webkitcolumnrulecolor', 'webkitcolumnrulestyle', 'webkitcolumnrulewidth', 'webkitcolumnspan', 'webkitcolumnwidth', 'webkitfilter', 'webkitflexbasis', 'webkitflexdirection', 'webkitflexgrow', 'webkitflexshrink', 'webkitflexwrap', 'webkitfontfeaturesettings', 'webkitfontkerning', 'webkitfontsmoothing', 'webkitfontvariantligatures', 'webkithyphenatecharacter', 'webkithyphens', 'webkitinitialletter', 'webkitjustifycontent', 'webkitlinebreak', 'webkitlineclamp', 'webkitlogicalheight', 'webkitlogicalwidth', 'webkitmarginend', 'webkitmarginstart', 'webkitmaskattachment', 'webkitmaskboximageoutset', 'webkitmaskboximagerepeat', 'webkitmaskboximageslice', 'webkitmaskboximagesource', 'webkitmaskboximagewidth', 'webkitmaskclip', 'webkitmaskcomposite', 'webkitmaskimage', 'webkitmaskorigin', 'webkitmaskposition', 'webkitmaskpositionx', 'webkitmaskpositiony', 'webkitmaskrepeat', 'webkitmaskrepeatx', 'webkitmaskrepeaty', 'webkitmasksize', 'webkitmaxinlinesize', 'webkitorder', 'webkitoverflowscrolling', 'webkitpaddingend', 'webkitpaddingstart', 'webkitperspective', 'webkitperspectiveorigin', 'webkitprintcoloradjust', 'webkitrubyposition', 'webkitscrollsnaptype', 'webkitshapemargin', 'webkittaphighlightcolor', 'webkittextcombine', 'webkittextdecorationcolor', 'webkittextdecorationline', 'webkittextdecorationskip', 'webkittextdecorationstyle', 'webkittextemphasiscolor', 'webkittextemphasisposition', 'webkittextemphasisstyle', 'webkittextfillcolor', 'webkittextorientation', 'webkittextsizeadjust', 'webkittextstrokecolor', 'webkittextstrokewidth', 'webkittextunderlineposition', 'webkittouchcallout', 'webkittransform', 'webkittransformorigin', 'webkittransformstyle', 'webkittransitiondelay', 'webkittransitionduration', 'webkittransitionproperty', 'webkittransitiontimingfunction', 'webkitusermodify', 'webkituserselect', 'webkitwritingmode', 'mozanimation', 'mozborderimage', 'mozcolumnrule', 'mozcolumns', 'mozoutlineradius', 'moztransition', 'mscontentzoomlimit', 'mscontentzoomsnap', 'msflex', 'msscrolllimit', 'msscrollsnapx', 'msscrollsnapy', 'mstransition', 'webkitanimation', 'webkitborderbefore', 'webkitborderimage', 'webkitborderradius', 'webkitcolumnrule', 'webkitcolumns', 'webkitflex', 'webkitflexflow', 'webkitmask', 'webkitmaskboximage', 'webkittextemphasis', 'webkittextstroke', 'webkittransition', 'boxalign', 'boxdirection', 'boxflex', 'boxflexgroup', 'boxlines', 'boxordinalgroup', 'boxorient', 'boxpack', 'clip', 'fontstretch', 'gridcolumngap', 'gridgap', 'gridrowgap', 'imemode', 'insetarea', 'offsetblock', 'offsetblockend', 'offsetblockstart', 'offsetinline', 'offsetinlineend', 'offsetinlinestart', 'pagebreakafter', 'pagebreakbefore', 'pagebreakinside', 'positiontryoptions', 'scrollsnapcoordinate', 'scrollsnapdestination', 'scrollsnappointsx', 'scrollsnappointsy', 'scrollsnaptypex', 'scrollsnaptypey', 'khtmlboxalign', 'khtmlboxdirection', 'khtmlboxflex', 'khtmlboxflexgroup', 'khtmlboxlines', 'khtmlboxordinalgroup', 'khtmlboxorient', 'khtmlboxpack', 'khtmllinebreak', 'khtmlopacity', 'khtmluserselect', 'mozbackgroundclip', 'mozbackgroundorigin', 'mozbackgroundsize', 'mozborderradius', 'mozborderradiusbottomleft', 'mozborderradiusbottomright', 'mozborderradiustopleft', 'mozborderradiustopright', 'mozboxalign', 'mozboxdirection', 'mozboxflex', 'mozboxordinalgroup', 'mozboxorient', 'mozboxpack', 'mozboxshadow', 'mozcolumncount', 'mozcolumnfill', 'mozfloatedge', 'mozforcebrokenimageicon', 'mozopacity', 'mozoutline', 'mozoutlinecolor', 'mozoutlinestyle', 'mozoutlinewidth', 'moztextalignlast', 'moztextdecorationcolor', 'moztextdecorationline', 'moztextdecorationstyle', 'moztransitiondelay', 'moztransitionduration', 'moztransitionproperty', 'moztransitiontimingfunction', 'mozuserfocus', 'mozuserinput', 'msimemode', 'oanimation', 'oanimationdelay', 'oanimationdirection', 'oanimationduration', 'oanimationfillmode', 'oanimationiterationcount', 'oanimationname', 'oanimationplaystate', 'oanimationtimingfunction', 'obackgroundsize', 'oborderimage', 'oobjectfit', 'oobjectposition', 'otabsize', 'otextoverflow', 'otransform', 'otransformorigin', 'otransition', 'otransitiondelay', 'otransitionduration', 'otransitionproperty', 'otransitiontimingfunction', 'webkitboxalign', 'webkitboxdirection', 'webkitboxflex', 'webkitboxflexgroup', 'webkitboxlines', 'webkitboxordinalgroup', 'webkitboxorient', 'webkitboxpack', 'colorinterpolation', 'colorrendering', 'glyphorientationvertical'.
those elements have the following types:
  - accentcolor (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | <color>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **93** | **92**  | **15.4** | **93** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/accent-color
  - aligncontent (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position>`

**initial value**: `normal`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/align-content
  - alignitems (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | stretch | <baseline-position> | [ <overflow-position>? <self-position> ] | anchor-center`

**initial value**: `normal`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/align-items
  - alignself (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? <self-position> | anchor-center`

**initial value**: `auto`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **10** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/align-self
  - aligntracks (optional): **syntax**: `[ normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position> ]#`

**initial value**: `normal`
  - alignmentbaseline (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'baseline', 'alphabetic', 'central', 'ideographic', 'mathematical', 'middle', 'text-after-edge', 'text-before-edge'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `baseline | alphabetic | ideographic | middle | central | mathematical | text-before-edge | text-after-edge`

**initial value**: `baseline`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **1**  |   no    | **5.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/alignment-baseline
  - anchorname (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <dashed-ident>#`

**initial value**: `none`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/anchor-name
  - anchorscope (optional): **syntax**: `none | all | <dashed-ident>#`

**initial value**: `none`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **131** | **preview** | **26** | **131** | no  |
  - animationcomposition (optional): since july 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<single-animation-composition>#`

**initial value**: `replace`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **112** | **115** | **16** | **112** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-composition
  - animationdelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-delay
  - animationdirection (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-direction>#`

**initial value**: `normal`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-direction
  - animationduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ auto | <time [0s,∞]> ]#`

**initial value**: `0s`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-duration
  - animationfillmode (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-fill-mode>#`

**initial value**: `none`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 5 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-fill-mode
  - animationiterationcount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-iteration-count>#`

**initial value**: `1`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-iteration-count
  - animationname (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ none | <keyframes-name> ]#`

**initial value**: `none`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-name
  - animationplaystate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-play-state>#`

**initial value**: `running`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-play-state
  - animationrangeend (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ normal | <length-percentage> | <timeline-range-name> <length-percentage>? ]#`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-range-end
  - animationrangestart (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ normal | <length-percentage> | <timeline-range-name> <length-percentage>? ]#`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-range-start
  - animationtimeline (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<single-animation-timeline>#`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-timeline
  - animationtimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-timing-function
  - appearance (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'meter', 'progress-bar', 'radio', 'searchfield', 'textarea', 'menulist-button', 'textfield'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | auto | <compat-auto> | <compat-special>`

**initial value**: `none`

| chrome  | firefox |  safari  |   edge   | ie  |
| :-----: | :-----: | :------: | :------: | :-: |
| **84**  | **80**  | **15.4** |  **84**  | no  |
| 1 _-x-_ | 1 _-x-_ | 3 _-x-_  | 12 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/appearance
  - aspectratio (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `auto || <ratio>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **88** | **89**  | **15** | **88** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/aspect-ratio
  - backdropfilter (optional): since september 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | <filter-value-list>`

**initial value**: `none`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **76** | **103** | **18**  | **79** | no  |
|        |         | 9 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/backdrop-filter
  - backfacevisibility (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `visible | hidden`

**initial value**: `visible`

|  chrome  | firefox  |  safari   |  edge  |   ie   |
| :------: | :------: | :-------: | :----: | :----: |
|  **36**  |  **16**  | **15.4**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 5.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/backface-visibility
  - backgroundattachment (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<attachment>#`

**initial value**: `scroll`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-attachment
  - backgroundblendmode (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<blend-mode>#`

**initial value**: `normal`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **35** | **30**  | **8**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-blend-mode
  - backgroundclip (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-clip>#`

**initial value**: `border-box`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **4**  |  **5**  | **12** | **9** |
|        |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-clip
  - backgroundcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `transparent`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-color
  - backgroundimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-image>#`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-image
  - backgroundorigin (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<visual-box>#`

**initial value**: `padding-box`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **4**  | **3**  | **12** | **9** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-origin
  - backgroundpositionx (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2016.

**syntax**: `[ center | [ [ left | right | x-start | x-end ]? <length-percentage>? ]! ]#`

**initial value**: `0\%`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **49**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-position-x
  - backgroundpositiony (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2016.

**syntax**: `[ center | [ [ top | bottom | y-start | y-end ]? <length-percentage>? ]! ]#`

**initial value**: `0\%`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **49**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-position-y
  - backgroundrepeat (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<repeat-style>#`

**initial value**: `repeat`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-repeat
  - backgroundsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-size>#`

**initial value**: `auto auto`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **3**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-size
  - baselineshift (character | numeric; optional): **syntax**: `<length-percentage> | sub | super | baseline`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |   no    | **4**  | **79** | no  |
  - blocksize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'width'>`

**initial value**: `auto`

|            chrome            | firefox |             safari             |  edge  | ie  |
| :--------------------------: | :-----: | :----------------------------: | :----: | :-: |
|            **57**            | **41**  |            **12.1**            | **79** | no  |
| 8 _(-webkit-logical-height)_ |         | 5.1 _(-webkit-logical-height)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/block-size
  - borderblockendcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-end-color
  - borderblockendstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-end-style
  - borderblockendwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'>`

**initial value**: `medium`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-end-width
  - borderblockstartcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-start-color
  - borderblockstartstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-start-style
  - borderblockstartwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'>`

**initial value**: `medium`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-start-width
  - borderbottomcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom-color
  - borderbottomleftradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom-left-radius
  - borderbottomrightradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom-right-radius
  - borderbottomstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-style>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom-style
  - borderbottomwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom-width
  - bordercollapse (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'collapse', 'separate'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `separate | collapse`

**initial value**: `separate`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.1** | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-collapse
  - borderendendradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<'border-top-left-radius'>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-end-end-radius
  - borderendstartradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<'border-top-left-radius'>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-end-start-radius
  - borderimageoutset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <length [0,∞]> | <number [0,∞]> ]{1,4}  `

**initial value**: `0`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image-outset
  - borderimagerepeat (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2016.

**syntax**: `[ stretch | repeat | round | space ]{1,2}`

**initial value**: `stretch`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image-repeat
  - borderimageslice (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <number [0,∞]> | <percentage [0,∞]> ]{1,4}  && fill?`

**initial value**: `100\%`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image-slice
  - borderimagesource (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <image>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **15** | **15**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image-source
  - borderimagewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <length-percentage [0,∞]> | <number [0,∞]> | auto ]{1,4}`

**initial value**: `1`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **16** | **13**  | **6**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image-width
  - borderinlineendcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`

| chrome |           firefox           |  safari  |  edge  | ie  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | no  |
|        | 3 _(-moz-border-end-color)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-end-color
  - borderinlineendstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`

| chrome |           firefox           |  safari  |  edge  | ie  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | no  |
|        | 3 _(-moz-border-end-style)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-end-style
  - borderinlineendwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'>`

**initial value**: `medium`

| chrome |           firefox           |  safari  |  edge  | ie  |
| :----: | :-------------------------: | :------: | :----: | :-: |
| **69** |           **41**            | **12.1** | **79** | no  |
|        | 3 _(-moz-border-end-width)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-end-width
  - borderinlinestartcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`

| chrome |            firefox            |  safari  |  edge  | ie  |
| :----: | :---------------------------: | :------: | :----: | :-: |
| **69** |            **41**             | **12.1** | **79** | no  |
|        | 3 _(-moz-border-start-color)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-start-color
  - borderinlinestartstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`

| chrome |            firefox            |  safari  |  edge  | ie  |
| :----: | :---------------------------: | :------: | :----: | :-: |
| **69** |            **41**             | **12.1** | **79** | no  |
|        | 3 _(-moz-border-start-style)_ |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-start-style
  - borderinlinestartwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'>`

**initial value**: `medium`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-start-width
  - borderleftcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `currentcolor`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-left-color
  - borderleftstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-style>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-left-style
  - borderleftwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-left-width
  - borderrightcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `currentcolor`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-right-color
  - borderrightstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-style>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-right-style
  - borderrightwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-right-width
  - borderspacing (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length>{1,2}`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-spacing
  - borderstartendradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<'border-top-left-radius'>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-start-end-radius
  - borderstartstartradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<'border-top-left-radius'>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **89** | **66**  | **15** | **89** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-start-start-radius
  - bordertopcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `currentcolor`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top-color
  - bordertopleftradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top-left-radius
  - bordertoprightradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top-right-radius
  - bordertopstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-style>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top-style
  - bordertopwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top-width
  - bottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/bottom
  - boxdecorationbreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'clone', 'slice'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `slice | clone`

**initial value**: `slice`

|  chrome  | firefox |   safari    |   edge   | ie  |
| :------: | :-----: | :---------: | :------: | :-: |
| **130**  | **32**  | **7** _-x-_ | **130**  | no  |
| 22 _-x-_ |         |             | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/box-decoration-break
  - boxshadow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <shadow>#`

**initial value**: `none`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
| **10**  |  **4**  | **5.1** | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/box-shadow
  - boxsizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `content-box | border-box`

**initial value**: `content-box`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
| **10**  | **29**  | **5.1** | **12** | **8** |
| 1 _-x-_ | 1 _-x-_ | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/box-sizing
  - breakafter (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'all', 'always', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region', 'column', 'page', 'recto', 'region', 'verso'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2019.

**syntax**: `auto | avoid | always | all | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/break-after
  - breakbefore (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'all', 'always', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region', 'column', 'page', 'recto', 'region', 'verso'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2019.

**syntax**: `auto | avoid | always | all | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/break-before
  - breakinside (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'avoid', 'avoid-column', 'avoid-page', 'avoid-region'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2019.

**syntax**: `auto | avoid | avoid-page | avoid-column | avoid-region`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **50** | **65**  | **10** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/break-inside
  - captionside (a value equal to: 'top', 'bottom', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `top | bottom`

**initial value**: `top`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/caption-side
  - caretcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | <color>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **53**  | **11.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/caret-color
  - caretshape (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'bar', 'block', 'underscore'; optional): **syntax**: `auto | bar | block | underscore`

**initial value**: `auto`

| chrome | firefox | safari | edge | ie  |
| :----: | :-----: | :----: | :--: | :-: |
|   no   |   no    |   no   |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/caret-shape
  - clear (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'both', 'inline-end', 'inline-start'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | left | right | both | inline-start | inline-end`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/clear
  - clippath (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<clip-source> | [ <basic-shape> || <geometry-box> ] | none`

**initial value**: `none`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **55**  | **3.5** | **9.1** | **79** | **10** |
| 23 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/clip-path
  - cliprule (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'evenodd', 'nonzero'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `nonzero | evenodd`

**initial value**: `nonzero`

| chrome  | firefox | safari |  edge  | ie  |
| :-----: | :-----: | :----: | :----: | :-: |
| **≤15** | **3.5** | **≤5** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/clip-rule
  - color (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `canvastext`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/color
  - coloradjust (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): since may 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `economy | exact`

**initial value**: `economy`

|  chrome  |       firefox       |  safari  |   edge   | ie  |
| :------: | :-----------------: | :------: | :------: | :-: |
| **136**  |       **97**        | **15.4** | **136**  | no  |
| 17 _-x-_ | 48 _(color-adjust)_ | 6 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/print-color-adjust
  - colorinterpolationfilters (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'linearrgb', 'srgb'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | srgb | linearrgb`

**initial value**: `linearrgb`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **3**  | **3**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/color-interpolation-filters
  - colorscheme (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2022.

**syntax**: `normal | [ light | dark | <custom-ident> ]+ && only?`

**initial value**: `normal`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **81** | **96**  | **13** | **81** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/color-scheme
  - columncount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<integer> | auto`

**initial value**: `auto`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-count
  - columnfill (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `auto | balance`

**initial value**: `balance`

| chrome | firefox | safari  |  edge  |   ie   |
| :----: | :-----: | :-----: | :----: | :----: |
| **50** | **52**  |  **9**  | **12** | **10** |
|        |         | 8 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-fill
  - columngap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | <length-percentage>`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **1**  | **1.5** | **3**  | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-gap
  - columnrulecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<color>`

**initial value**: `currentcolor`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-rule-color
  - columnrulestyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-style'>`

**initial value**: `none`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-rule-style
  - columnrulewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-width'>`

**initial value**: `medium`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-rule-width
  - columnspan (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `none | all`

**initial value**: `none`

| chrome  | firefox |  safari   |  edge  |   ie   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **50**  | **71**  |   **9**   | **12** | **10** |
| 6 _-x-_ |         | 5.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-span
  - columnwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since november 2016.

**syntax**: `<length> | auto`

**initial value**: `auto`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **50**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-width
  - contain (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | strict | content | [ [ size || inline-size ] || layout || style || paint ]`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **52** | **69**  | **15.4** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain
  - containintrinsicblocksize (character | numeric; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto? [ none | <length> ]`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain-intrinsic-block-size
  - containintrinsicheight (character | numeric; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto? [ none | <length> ]`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain-intrinsic-height
  - containintrinsicinlinesize (character | numeric; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto? [ none | <length> ]`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain-intrinsic-inline-size
  - containintrinsicwidth (character | numeric; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto? [ none | <length> ]`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **95** | **107** | **17** | **95** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain-intrinsic-width
  - containername (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since february 2023.

**syntax**: `none | <custom-ident>+`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/container-name
  - containertype (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since february 2023.

**syntax**: `normal | [ [ size | inline-size ] || scroll-state ]`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/container-type
  - content (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | none | [ <content-replacement> | <content-list> ] [ / [ <string> | <counter> | <attr()> ]+ ]?`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/content
  - contentvisibility (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible'; optional): since september 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `visible | auto | hidden`

**initial value**: `visible`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **85** | **125** | **18** | **85** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/content-visibility
  - counterincrement (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <counter-name> <integer>? ]+ | none`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **3**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/counter-increment
  - counterreset (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <counter-name> <integer>? | <reversed-counter-name> <integer>? ]+ | none`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **3**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/counter-reset
  - counterset (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ <counter-name> <integer>? ]+ | none`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **85** | **68**  | **17.2** | **85** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/counter-set
  - cursor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since december 2021.

**syntax**: `[ [ <url> [ <x> <y> ]? , ]* <cursor-predefined> ]`

**initial value**: `auto`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.2** | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/cursor
  - cx (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/cx
  - cy (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/cy
  - d (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | path(<string>)`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **52** | **97**  |   no   | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/d
  - direction (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'ltr', 'rtl'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `ltr | rtl`

**initial value**: `ltr`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **2**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/direction
  - display (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <display-outside> || <display-inside> ] | <display-listitem> | <display-internal> | <display-box> | <display-legacy>`

**initial value**: `inline`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/display
  - dominantbaseline (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'alphabetic', 'central', 'ideographic', 'mathematical', 'middle', 'hanging', 'text-bottom', 'text-top'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | text-bottom | alphabetic | ideographic | middle | central | mathematical | hanging | text-top`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **1**  | **4**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/dominant-baseline
  - emptycells (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hide', 'show'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `show | hide`

**initial value**: `show`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/empty-cells
  - fieldsizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'fixed', 'content'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `content | fixed`

**initial value**: `fixed`

| chrome  | firefox |   safari    |  edge   | ie  |
| :-----: | :-----: | :---------: | :-----: | :-: |
| **123** |   no    | **preview** | **123** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/field-sizing
  - fill (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<paint>`

**initial value**: `black`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/fill
  - fillopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<'opacity'>`

**initial value**: `1`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **1**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/fill-opacity
  - fillrule (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'evenodd', 'nonzero'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `nonzero | evenodd`

**initial value**: `nonzero`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/fill-rule
  - filter (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2016.

**syntax**: `none | <filter-value-list>`

**initial value**: `none`

|  chrome  | firefox | safari  |  edge  | ie  |
| :------: | :-----: | :-----: | :----: | :-: |
|  **53**  | **35**  | **9.1** | **12** | no  |
| 18 _-x-_ |         | 6 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/filter
  - flexbasis (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `content | <'width'>`

**initial value**: `auto`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **22**  |  **9**  | **12** | **11** |
| 22 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-basis
  - flexdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `row | row-reverse | column | column-reverse`

**initial value**: `row`

|  chrome  | firefox | safari  |  edge  |    ie    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **22**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-direction
  - flexgrow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<number>`

**initial value**: `0`

|  chrome  | firefox | safari  |  edge  |            ie            |
| :------: | :-----: | :-----: | :----: | :----------------------: |
|  **29**  | **20**  |  **9**  | **12** |          **11**          |
| 22 _-x-_ |         | 7 _-x-_ |        | 10 _(-ms-flex-positive)_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-grow
  - flexshrink (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<number>`

**initial value**: `1`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **10** |
| 22 _-x-_ |         | 8 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-shrink
  - flexwrap (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap', 'wrap-reverse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `nowrap | wrap | wrap-reverse`

**initial value**: `nowrap`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-wrap
  - float (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'inline-end', 'inline-start'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `left | right | none | inline-start | inline-end`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/float
  - floodcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `black`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flood-color
  - floodopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'opacity'>`

**initial value**: `black`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flood-opacity
  - fontfamily (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <family-name> | <generic-family> ]#`

**initial value**: depends on user agent

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-family
  - fontfeaturesettings (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `normal | <feature-tag-value>#`

**initial value**: `normal`

|  chrome  | firefox  | safari  |  edge  |   ie   |
| :------: | :------: | :-----: | :----: | :----: |
|  **48**  |  **34**  | **9.1** | **15** | **10** |
| 16 _-x-_ | 15 _-x-_ |         |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-feature-settings
  - fontkerning (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | normal | none`

**initial value**: `auto`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **33** | **32**  |  **9**  | **79** | no  |
|        |         | 6 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-kerning
  - fontlanguageoverride (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | <string>`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **143** | **34**  |   no   | **143** | no  |
|         | 4 _-x-_ |        |         |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-language-override
  - fontopticalsizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2020.

**syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **79** | **62**  | **13.1** | **17** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-optical-sizing
  - fontpalette (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since november 2022.

**syntax**: `normal | light | dark | <palette-identifier> | <palette-mix()>`

**initial value**: `normal`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **101** | **107** | **15.4** | **101** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-palette
  - fontsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<absolute-size> | <relative-size> | <length-percentage [0,∞]> | math`

**initial value**: `medium`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-size
  - fontsizeadjust (optional): since july 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | [ ex-height | cap-height | ch-width | ic-width | ic-height ]? [ from-font | <number> ]`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **127** |  **3**  | **16.4** | **127** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-size-adjust
  - fontsmooth (character | numeric; optional): the **`font-smooth`** css property controls the application of anti-aliasing when fonts are rendered.

**syntax**: `auto | never | always | <absolute-size> | <length>`

**initial value**: `auto`

|              chrome              |              firefox               |              safari              |               edge                | ie  |
| :------------------------------: | :--------------------------------: | :------------------------------: | :-------------------------------: | :-: |
| **5** _(-webkit-font-smoothing)_ | **25** _(-moz-osx-font-smoothing)_ | **4** _(-webkit-font-smoothing)_ | **79** _(-webkit-font-smoothing)_ | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-smooth
  - fontstyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | italic | oblique <angle>?`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-style
  - fontsynthesis (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2022.

**syntax**: `none | [ weight || style || small-caps || position]`

**initial value**: `weight style small-caps position `

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **97** | **34**  | **9**  | **97** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-synthesis
  - fontsynthesisposition (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | none`

**initial value**: `none`

| chrome | firefox | safari | edge | ie  |
| :----: | :-----: | :----: | :--: | :-: |
|   no   | **118** |   no   |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-synthesis-position
  - fontsynthesissmallcaps (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-synthesis-small-caps
  - fontsynthesisstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-synthesis-style
  - fontsynthesisweight (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **97** | **111** | **16.4** | **97** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-synthesis-weight
  - fontvariant (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant
  - fontvariantalternates (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `normal | [ stylistic( <feature-value-name> ) || historical-forms || styleset( <feature-value-name># ) || character-variant( <feature-value-name># ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) ]`

**initial value**: `normal`

| chrome  | firefox | safari  |  edge   | ie  |
| :-----: | :-----: | :-----: | :-----: | :-: |
| **111** | **34**  | **9.1** | **111** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-alternates
  - fontvariantcaps (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'small-caps', 'all-petite-caps', 'all-small-caps', 'petite-caps', 'titling-caps', 'unicase'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps`

**initial value**: `normal`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **52** | **34**  | **9.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-caps
  - fontvarianteastasian (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]`

**initial value**: `normal`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **63** | **34**  | **9.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-east-asian
  - fontvariantemoji (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'text', 'emoji', 'unicode'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | text | emoji | unicode`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **131** | **141** |   no   | **131** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-emoji
  - fontvariantligatures (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]`

**initial value**: `normal`

|  chrome  | firefox | safari  |  edge  | ie  |
| :------: | :-----: | :-----: | :----: | :-: |
|  **34**  | **34**  | **9.1** | **79** | no  |
| 31 _-x-_ |         | 7 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-ligatures
  - fontvariantnumeric (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]`

**initial value**: `normal`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **52** | **34**  | **9.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-numeric
  - fontvariantposition (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'sub', 'super'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | sub | super`

**initial value**: `normal`

| chrome | firefox | safari  | edge | ie  |
| :----: | :-----: | :-----: | :--: | :-: |
|   no   | **34**  | **9.1** |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variant-position
  - fontvariationsettings (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2018.

**syntax**: `normal | [ <string> <number> ]#`

**initial value**: `normal`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **62** | **62**  | **11** | **17** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-variation-settings
  - fontweight (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<font-weight-absolute> | bolder | lighter`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **2**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font-weight
  - fontwidth (optional): **syntax**: `normal | <percentage [0,∞]> | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded`

**initial value**: `normal`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
|   no   |   no    | **18.4** |  no  | no  |
  - forcedcoloradjust (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'preserve-parent-color'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | none | preserve-parent-color`

**initial value**: `auto`

| chrome | firefox | safari |              edge               |                 ie                  |
| :----: | :-----: | :----: | :-----------------------------: | :---------------------------------: |
| **89** | **113** |   no   |             **79**              | **10** _(-ms-high-contrast-adjust)_ |
|        |         |        | 12 _(-ms-high-contrast-adjust)_ |                                     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/forced-color-adjust
  - gridautocolumns (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<track-size>+`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  |             ie              |
| :----: | :-----: | :------: | :----: | :-------------------------: |
| **57** | **70**  | **10.1** | **16** | **10** _(-ms-grid-columns)_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-auto-columns
  - gridautoflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `[ row | column ] || dense`

**initial value**: `row`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-auto-flow
  - gridautorows (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<track-size>+`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  |            ie            |
| :----: | :-----: | :------: | :----: | :----------------------: |
| **57** | **70**  | **10.1** | **16** | **10** _(-ms-grid-rows)_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-auto-rows
  - gridcolumnend (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-column-end
  - gridcolumnstart (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-column-start
  - gridrowend (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-row-end
  - gridrowstart (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-row-start
  - gridtemplateareas (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `none | <string>+`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-template-areas
  - gridtemplatecolumns (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `none | <track-list> | <auto-track-list> | subgrid <line-name-list>?`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  |             ie              |
| :----: | :-----: | :------: | :----: | :-------------------------: |
| **57** | **52**  | **10.1** | **16** | **10** _(-ms-grid-columns)_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-template-columns
  - gridtemplaterows (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `none | <track-list> | <auto-track-list> | subgrid <line-name-list>?`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  |            ie            |
| :----: | :-----: | :------: | :----: | :----------------------: |
| **57** | **52**  | **10.1** | **16** | **10** _(-ms-grid-rows)_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-template-rows
  - hangingpunctuation (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | [ first || [ force-end | allow-end ] || last ]`

**initial value**: `none`

| chrome | firefox | safari | edge | ie  |
| :----: | :-----: | :----: | :--: | :-: |
|   no   |   no    | **10** |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/hanging-punctuation
  - height (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/height
  - hyphenatecharacter (optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | <string>`

**initial value**: `auto`

| chrome  | firefox |  safari   |   edge   | ie  |
| :-----: | :-----: | :-------: | :------: | :-: |
| **106** | **98**  |  **17**   | **106**  | no  |
| 6 _-x-_ |         | 5.1 _-x-_ | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/hyphenate-character
  - hyphenatelimitchars (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ auto | <integer> ]{1,3}`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** | **137** |   no   | **109** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/hyphenate-limit-chars
  - hyphens (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | manual | auto`

**initial value**: `manual`

|  chrome  | firefox |  safari   |  edge  |      ie      |
| :------: | :-----: | :-------: | :----: | :----------: |
|  **55**  | **43**  |  **17**   | **79** | **10** _-x-_ |
| 13 _-x-_ | 6 _-x-_ | 5.1 _-x-_ |        |              |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/hyphens
  - imageorientation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2020.

**syntax**: `from-image | <angle> | [ <angle>? flip ]`

**initial value**: `from-image`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **81** | **26**  | **13.1** | **81** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/image-orientation
  - imagerendering (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', '-moz-crisp-edges', '-webkit-optimize-contrast', 'crisp-edges', 'pixelated', 'smooth'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | crisp-edges | pixelated | smooth`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **13** | **3.6** | **6**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/image-rendering
  - imageresolution (optional): the **`image-resolution`** css property specifies the intrinsic resolution of all raster images used in or on the element. it affects content images such as replaced elements and generated content, and decorative images such as `background-image` images.

**syntax**: `[ from-image || <resolution> ] && snap?`

**initial value**: `1dppx`
  - initialletter (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | [ <number> <integer>? ]`

**initial value**: `normal`

| chrome  | firefox |   safari    |  edge   | ie  |
| :-----: | :-----: | :---------: | :-----: | :-: |
| **110** |   no    | **9** _-x-_ | **110** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/initial-letter
  - initialletteralign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'alphabetic', 'ideographic', 'hanging'; optional): **syntax**: `[ auto | alphabetic | hanging | ideographic ]`

**initial value**: `auto`
  - inlinesize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'width'>`

**initial value**: `auto`

|           chrome            | firefox |            safari             |  edge  | ie  |
| :-------------------------: | :-----: | :---------------------------: | :----: | :-: |
|           **57**            | **41**  |           **12.1**            | **79** | no  |
| 8 _(-webkit-logical-width)_ |         | 5.1 _(-webkit-logical-width)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inline-size
  - insetblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-block-end
  - insetblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-block-start
  - insetinlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-inline-end
  - insetinlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-inline-start
  - interpolatesize (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'allow-keywords', 'numeric-only'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `numeric-only | allow-keywords`

**initial value**: `numeric-only`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **129** |   no    |   no   | **129** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/interpolate-size
  - isolation (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'isolate'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | isolate`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **41** | **36**  | **8**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/isolation
  - justifycontent (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ]`

**initial value**: `normal`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **20**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/justify-content
  - justifyitems (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2016.

**syntax**: `normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | legacy | legacy && [ left | right | center ] | anchor-center`

**initial value**: `legacy`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **52** | **20**  | **9**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/justify-items
  - justifyself (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | anchor-center`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  |   ie   |
| :----: | :-----: | :------: | :----: | :----: |
| **57** | **45**  | **10.1** | **16** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/justify-self
  - justifytracks (optional): **syntax**: `[ normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ] ]#`

**initial value**: `normal`
  - left (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/left
  - letterspacing (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | <length>`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/letter-spacing
  - lightingcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>`

**initial value**: `white`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **5**  |  **3**  | **6**  | **12** | **≤11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/lighting-color
  - linebreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | loose | normal | strict | anywhere`

**initial value**: `auto`

| chrome  | firefox | safari  |  edge  |   ie    |
| :-----: | :-----: | :-----: | :----: | :-----: |
| **58**  | **69**  | **11**  | **14** | **5.5** |
| 1 _-x-_ |         | 3 _-x-_ |        |         |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/line-break
  - lineheight (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | <number> | <length> | <percentage>`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/line-height
  - lineheightstep (character | numeric; optional): the **`line-height-step`** css property sets the step unit for line box heights. when the property is set, line box heights are rounded up to the closest multiple of the unit.

**syntax**: `<length>`

**initial value**: `0`
  - liststyleimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<image> | none`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/list-style-image
  - liststyleposition (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'inside', 'outside'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `inside | outside`

**initial value**: `outside`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/list-style-position
  - liststyletype (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<counter-style> | <string> | none`

**initial value**: `disc`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/list-style-type
  - marginblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-block-end
  - marginblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-block-start
  - marginbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage> | auto | <anchor-size()>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-bottom
  - margininlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`

|          chrome          |        firefox        |          safari          |  edge  | ie  |
| :----------------------: | :-------------------: | :----------------------: | :----: | :-: |
|          **69**          |        **41**         |         **12.1**         | **79** | no  |
| 2 _(-webkit-margin-end)_ | 3 _(-moz-margin-end)_ | 3 _(-webkit-margin-end)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-inline-end
  - margininlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`

|           chrome           |         firefox         |           safari           |  edge  | ie  |
| :------------------------: | :---------------------: | :------------------------: | :----: | :-: |
|           **69**           |         **41**          |          **12.1**          | **79** | no  |
| 2 _(-webkit-margin-start)_ | 3 _(-moz-margin-start)_ | 3 _(-webkit-margin-start)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-inline-start
  - marginleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage> | auto | <anchor-size()>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-left
  - marginright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage> | auto | <anchor-size()>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-right
  - margintop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage> | auto | <anchor-size()>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-top
  - margintrim (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all', 'in-flow'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | in-flow | all`

**initial value**: `none`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
|   no   |   no    | **16.4** |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-trim
  - marker (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `none | <url>`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/marker
  - markerend (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `none | <url>`

**initial value**: `none`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/marker-end
  - markermid (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `none | <url>`

**initial value**: `none`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/marker-mid
  - markerstart (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `none | <url>`

**initial value**: `none`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/marker-start
  - maskbordermode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'alpha', 'luminance'; optional): the **`mask-border-mode`** css property specifies the blending mode used in a mask border.

**syntax**: `luminance | alpha`

**initial value**: `alpha`
  - maskborderoutset (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <length> | <number> ]{1,4}`

**initial value**: `0`

|                 chrome                  | firefox |                safari                 |                   edge                   | ie  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-outset)_ |   no    |               **17.2**                | **79** _(-webkit-mask-box-image-outset)_ | no  |
|                                         |         | 3.1 _(-webkit-mask-box-image-outset)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border-outset
  - maskborderrepeat (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ stretch | repeat | round | space ]{1,2}`

**initial value**: `stretch`

|                 chrome                  | firefox |                safari                 |                   edge                   | ie  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-repeat)_ |   no    |               **17.2**                | **79** _(-webkit-mask-box-image-repeat)_ | no  |
|                                         |         | 3.1 _(-webkit-mask-box-image-repeat)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border-repeat
  - maskborderslice (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<number-percentage>{1,4} fill?`

**initial value**: `0`

|                 chrome                 | firefox |                safari                |                  edge                   | ie  |
| :------------------------------------: | :-----: | :----------------------------------: | :-------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-slice)_ |   no    |               **17.2**               | **79** _(-webkit-mask-box-image-slice)_ | no  |
|                                        |         | 3.1 _(-webkit-mask-box-image-slice)_ |                                         |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border-slice
  - maskbordersource (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <image>`

**initial value**: `none`

|                 chrome                  | firefox |                safari                 |                   edge                   | ie  |
| :-------------------------------------: | :-----: | :-----------------------------------: | :--------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-source)_ |   no    |               **17.2**                | **79** _(-webkit-mask-box-image-source)_ | no  |
|                                         |         | 3.1 _(-webkit-mask-box-image-source)_ |                                          |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border-source
  - maskborderwidth (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <length-percentage> | <number> | auto ]{1,4}`

**initial value**: `auto`

|                 chrome                 | firefox |                safari                |                  edge                   | ie  |
| :------------------------------------: | :-----: | :----------------------------------: | :-------------------------------------: | :-: |
| **1** _(-webkit-mask-box-image-width)_ |   no    |               **17.2**               | **79** _(-webkit-mask-box-image-width)_ | no  |
|                                        |         | 3.1 _(-webkit-mask-box-image-width)_ |                                         |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border-width
  - maskclip (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ <coord-box> | no-clip ]#`

**initial value**: `border-box`

| chrome  | firefox |  safari  |   edge   | ie  |
| :-----: | :-----: | :------: | :------: | :-: |
| **120** | **53**  | **15.4** | **120**  | no  |
| 1 _-x-_ |         | 4 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-clip
  - maskcomposite (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<compositing-operator>#`

**initial value**: `add`

| chrome  | firefox |  safari  | edge  | ie  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 18-79 | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-composite
  - maskimage (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<mask-reference>#`

**initial value**: `none`

| chrome  | firefox |  safari  | edge  | ie  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 16-79 | no  |
| 1 _-x-_ |         | 4 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-image
  - maskmode (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<masking-mode>#`

**initial value**: `match-source`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **120** | **53**  | **15.4** | **120** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-mode
  - maskorigin (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<coord-box>#`

**initial value**: `border-box`

| chrome  | firefox |  safari  |   edge   | ie  |
| :-----: | :-----: | :------: | :------: | :-: |
| **120** | **53**  | **15.4** | **120**  | no  |
| 1 _-x-_ |         | 4 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-origin
  - maskposition (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<position>#`

**initial value**: `0\% 0\%`

| chrome  | firefox |  safari   | edge  | ie  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 18-79 | no  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-position
  - maskrepeat (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<repeat-style>#`

**initial value**: `repeat`

| chrome  | firefox |  safari   | edge  | ie  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 18-79 | no  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-repeat
  - masksize (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<bg-size>#`

**initial value**: `auto`

| chrome  | firefox |  safari  | edge  | ie  |
| :-----: | :-----: | :------: | :---: | :-: |
| **120** | **53**  | **15.4** | 18-79 | no  |
| 4 _-x-_ |         | 4 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-size
  - masktype (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'alpha', 'luminance'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `luminance | alpha`

**initial value**: `luminance`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **24** | **35**  | **7**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-type
  - masonryautoflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `[ pack | next ] || [ definite-first | ordered ]`

**initial value**: `pack`
  - mathdepth (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto-add | add(<integer>) | <integer>`

**initial value**: `0`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** | **117** |   no   | **109** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/math-depth
  - mathshift (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'compact'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | compact`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **109** |   no    |   no   | **109** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/math-shift
  - mathstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'compact'; optional): since august 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `normal | compact`

**initial value**: `normal`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **109** | **117** | **14.1** | **109** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/math-style
  - maxblocksize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'max-width'>`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/max-block-size
  - maxheight (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `none`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **1**  | **1.3** | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/max-height
  - maxinlinesize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'max-width'>`

**initial value**: `none`

| chrome | firefox |   safari   |  edge  | ie  |
| :----: | :-----: | :--------: | :----: | :-: |
| **57** | **41**  |  **12.1**  | **79** | no  |
|        |         | 10.1 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/max-inline-size
  - maxlines (optional): **syntax**: `none | <integer>`

**initial value**: `none`
  - maxwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/max-width
  - minblocksize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'min-width'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/min-block-size
  - minheight (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **3**  | **1.3** | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/min-height
  - mininlinesize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'min-width'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/min-inline-size
  - minwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **7** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/min-width
  - mixblendmode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'color', 'color-burn', 'color-dodge', 'darken', 'difference', 'exclusion', 'hard-light', 'hue', 'lighten', 'luminosity', 'multiply', 'overlay', 'saturation', 'screen', 'soft-light', 'plus-darker', 'plus-lighter'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<blend-mode> | plus-darker | plus-lighter`

**initial value**: `normal`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **41** | **32**  | **8**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mix-blend-mode
  - motiondistance (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `<length-percentage>`

**initial value**: `0`

|         chrome         | firefox | safari |  edge  | ie  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **55**         | **72**  | **16** | **79** | no  |
| 46 _(motion-distance)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-distance
  - motionpath (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | <offset-path> || <coord-box>`

**initial value**: `none`

|       chrome       | firefox |  safari  |  edge  | ie  |
| :----------------: | :-----: | :------: | :----: | :-: |
|       **55**       | **72**  | **15.4** | **79** | no  |
| 46 _(motion-path)_ |         |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-path
  - motionrotation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ auto | reverse ] || <angle>`

**initial value**: `auto`

|         chrome         | firefox | safari |  edge  | ie  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | no  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-rotate
  - objectfit (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'contain', 'cover', 'fill', 'scale-down'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `fill | contain | cover | none | scale-down`

**initial value**: `fill`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **32** | **36**  | **10** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/object-fit
  - objectposition (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<position>`

**initial value**: `50\% 50\%`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **32** | **36**  | **10** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/object-position
  - objectviewbox (optional): **syntax**: `none | <basic-shape-rect>`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **104** |   no    |   no   | **104** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/object-view-box
  - offsetanchor (character | numeric; optional): since august 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | <position>`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** | **72**  | **16** | **116** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-anchor
  - offsetdistance (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `<length-percentage>`

**initial value**: `0`

|         chrome         | firefox | safari |  edge  | ie  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **55**         | **72**  | **16** | **79** | no  |
| 46 _(motion-distance)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-distance
  - offsetpath (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | <offset-path> || <coord-box>`

**initial value**: `none`

|       chrome       | firefox |  safari  |  edge  | ie  |
| :----------------: | :-----: | :------: | :----: | :-: |
|       **55**       | **72**  | **15.4** | **79** | no  |
| 46 _(motion-path)_ |         |          |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-path
  - offsetposition (character | numeric; optional): since january 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `normal | auto | <position>`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** | **122** | **16** | **116** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-position
  - offsetrotate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ auto | reverse ] || <angle>`

**initial value**: `auto`

|         chrome         | firefox | safari |  edge  | ie  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | no  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-rotate
  - offsetrotation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ auto | reverse ] || <angle>`

**initial value**: `auto`

|         chrome         | firefox | safari |  edge  | ie  |
| :--------------------: | :-----: | :----: | :----: | :-: |
|         **56**         | **72**  | **16** | **79** | no  |
| 46 _(motion-rotation)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset-rotate
  - opacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<opacity-value>`

**initial value**: `1`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **2**  | **12** | **9** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/opacity
  - order (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<integer>`

**initial value**: `0`

|  chrome  | firefox | safari  |  edge  |    ie    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **20**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/order
  - orphans (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<integer>`

**initial value**: `2`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **25** |   no    | **1.3** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/orphans
  - outlinecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <color>`

**initial value**: `auto`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/outline-color
  - outlineoffset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **1**  | **1.5** | **1.2** | **15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/outline-offset
  - outlinestyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <outline-line-style>`

**initial value**: `none`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/outline-style
  - outlinewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  | **1.5** | **1.2** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/outline-width
  - overflowanchor (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |   safari    |  edge  | ie  |
| :----: | :-----: | :---------: | :----: | :-: |
| **56** | **66**  | **preview** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-anchor
  - overflowblock (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'clip'; optional): since september 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **135** | **69**  | **26** | **135** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-block
  - overflowclipbox (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'content-box', 'padding-box'; optional): **syntax**: `padding-box | content-box`

**initial value**: `padding-box`
  - overflowclipmargin (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<visual-box> || <length [0,∞]>`

**initial value**: `0px`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **90** | **102** |   no   | **90** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-clip-margin
  - overflowinline (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'clip'; optional): since september 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **135** | **69**  | **26** | **135** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-inline
  - overflowwrap (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'anywhere', 'break-word'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2018.

**syntax**: `normal | break-word | anywhere`

**initial value**: `normal`

|     chrome      |      firefox      |     safari      |       edge       |          ie           |
| :-------------: | :---------------: | :-------------: | :--------------: | :-------------------: |
|     **23**      |      **49**       |      **7**      |      **18**      | **5.5** _(word-wrap)_ |
| 1 _(word-wrap)_ | 3.5 _(word-wrap)_ | 1 _(word-wrap)_ | 12 _(word-wrap)_ |                       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-wrap
  - overflowx (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `visible`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **3.5** | **3**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-x
  - overflowy (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `visible`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  | **3.5** | **3**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow-y
  - overlay (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | auto`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **117** |   no    |   no   | **117** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overlay
  - overscrollbehaviorblock (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `contain | none | auto`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **77** | **73**  | **16** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overscroll-behavior-block
  - overscrollbehaviorinline (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `contain | none | auto`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **77** | **73**  | **16** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overscroll-behavior-inline
  - overscrollbehaviorx (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `contain | none | auto`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overscroll-behavior-x
  - overscrollbehaviory (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'contain'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `contain | none | auto`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overscroll-behavior-y
  - paddingblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-block-end
  - paddingblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-block-start
  - paddingbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-bottom
  - paddinginlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`

|          chrome           |        firefox         |          safari           |  edge  | ie  |
| :-----------------------: | :--------------------: | :-----------------------: | :----: | :-: |
|          **69**           |         **41**         |         **12.1**          | **79** | no  |
| 2 _(-webkit-padding-end)_ | 3 _(-moz-padding-end)_ | 3 _(-webkit-padding-end)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-inline-end
  - paddinginlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`

|           chrome            |         firefox          |           safari            |  edge  | ie  |
| :-------------------------: | :----------------------: | :-------------------------: | :----: | :-: |
|           **69**            |          **41**          |          **12.1**           | **79** | no  |
| 2 _(-webkit-padding-start)_ | 3 _(-moz-padding-start)_ | 3 _(-webkit-padding-start)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-inline-start
  - paddingleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-left
  - paddingright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-right
  - paddingtop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-top
  - page (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since february 2023.

**syntax**: `auto | <custom-ident>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **85** | **110** | **1**  | **85** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/page
  - paintorder (optional): since march 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `normal | [ fill || stroke || markers ]`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **123** | **60**  | **11** | **123** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/paint-order
  - perspective (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <length>`

**initial value**: `none`

|  chrome  | firefox  | safari  |  edge  |   ie   |
| :------: | :------: | :-----: | :----: | :----: |
|  **36**  |  **16**  |  **9**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/perspective
  - perspectiveorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<position>`

**initial value**: `50\% 50\%`

|  chrome  | firefox  | safari  |  edge  |   ie   |
| :------: | :------: | :-----: | :----: | :----: |
|  **36**  |  **16**  |  **9**  | **12** | **10** |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/perspective-origin
  - pointerevents (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'visible', 'fill', 'stroke', 'painted', 'visiblefill', 'visiblepainted', 'visiblestroke'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | none | visiblepainted | visiblefill | visiblestroke | visible | painted | fill | stroke | all | inherit`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie   |
| :----: | :-----: | :----: | :----: | :----: |
| **1**  | **1.5** | **4**  | **12** | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/pointer-events
  - position (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'fixed', '-webkit-sticky', 'absolute', 'relative', 'static', 'sticky'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `static | relative | absolute | sticky | fixed`

**initial value**: `static`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position
  - positionanchor (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | <anchor-name>`

**initial value**: `auto`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-anchor
  - positionarea (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <position-area>`

**initial value**: `none`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **129** | **preview** | **26** | **129** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-area
  - positiontryfallbacks (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | [ [<dashed-ident> || <try-tactic>] | <'position-area'> ]#`

**initial value**: `none`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **128** | **preview** | **26** | **128** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-try-fallbacks
  - positiontryorder (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'most-block-size', 'most-height', 'most-inline-size', 'most-width'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | <try-size>`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **125** |   no    | **26** | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-try-order
  - positionvisibility (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `always | [ anchors-valid || anchors-visible || no-overflow ]`

**initial value**: `anchors-visible`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** |   no   | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-visibility
  - printcoloradjust (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): since may 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `economy | exact`

**initial value**: `economy`

|  chrome  |       firefox       |  safari  |   edge   | ie  |
| :------: | :-----------------: | :------: | :------: | :-: |
| **136**  |       **97**        | **15.4** | **136**  | no  |
| 17 _-x-_ | 48 _(color-adjust)_ | 6 _-x-_  | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/print-color-adjust
  - quotes (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | auto | [ <string> <string> ]+`

**initial value**: depends on user agent

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **11** | **1.5** | **9**  | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/quotes
  - r (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **43** | **69**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/r
  - resize (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'both', 'block', 'inline', 'horizontal', 'vertical'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | both | horizontal | vertical | block | inline`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **4**  | **3**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/resize
  - right (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/right
  - rotate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2022.

**syntax**: `none | <angle> | [ x | y | z | <number>{3} ] && <angle>`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/rotate
  - rowgap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `normal | <length-percentage>`

**initial value**: `normal`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **47** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/row-gap
  - rubyalign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'space-around', 'space-between', 'center', 'start'; optional): since december 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `start | center | space-between | space-around`

**initial value**: `space-around`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **128** | **38**  | **18.2** | **128** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/ruby-align
  - rubymerge (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'collapse', 'separate'; optional): **syntax**: `separate | collapse | auto`

**initial value**: `separate`
  - rubyoverhang (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): **syntax**: `auto | none`

**initial value**: `auto`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
|   no   |   no    | **18.2** |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/ruby-overhang
  - rubyposition (optional): since december 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ alternate || [ over | under ] ] | inter-character`

**initial value**: `alternate`

| chrome  | firefox |  safari  | edge  | ie  |
| :-----: | :-----: | :------: | :---: | :-: |
| **84**  | **38**  | **18.2** | 12-79 | no  |
| 1 _-x-_ |         | 7 _-x-_  |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/ruby-position
  - rx (character | numeric; optional): since march 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **43** | **69**  | **17.4** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/rx
  - ry (character | numeric; optional): since march 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **43** | **69**  | **17.4** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/ry
  - scale (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2022.

**syntax**: `none | [ <number> | <percentage> ]{1,3}`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scale
  - scrollbehavior (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'smooth'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `auto | smooth`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **61** | **36**  | **15.4** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-behavior
  - scrollinitialtarget (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'nearest'; optional): **syntax**: `none | nearest`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **133** |   no    |   no   | **133** | no  |
  - scrollmarginblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-block-end
  - scrollmarginblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-block-start
  - scrollmarginbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |              safari              |  edge  | ie  |
| :----: | :-----: | :------------------------------: | :----: | :-: |
| **69** | **68**  |             **14.1**             | **79** | no  |
|        |         | 11 _(scroll-snap-margin-bottom)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-bottom
  - scrollmargininlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-inline-end
  - scrollmargininlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-inline-start
  - scrollmarginleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |             safari             |  edge  | ie  |
| :----: | :-----: | :----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**            | **79** | no  |
|        |         | 11 _(scroll-snap-margin-left)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-left
  - scrollmarginright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |             safari              |  edge  | ie  |
| :----: | :-----: | :-----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**             | **79** | no  |
|        |         | 11 _(scroll-snap-margin-right)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-right
  - scrollmargintop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |            safari             |  edge  | ie  |
| :----: | :-----: | :---------------------------: | :----: | :-: |
| **69** | **68**  |           **14.1**            | **79** | no  |
|        |         | 11 _(scroll-snap-margin-top)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-top
  - scrollpaddingblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-block-end
  - scrollpaddingblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-block-start
  - scrollpaddingbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-bottom
  - scrollpaddinginlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-inline-end
  - scrollpaddinginlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-inline-start
  - scrollpaddingleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-left
  - scrollpaddingright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-right
  - scrollpaddingtop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `auto | <length-percentage>`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-top
  - scrollsnapalign (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `[ none | start | end | center ]{1,2}`

**initial value**: `none`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **11** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-snap-align
  - scrollsnapmarginbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |              safari              |  edge  | ie  |
| :----: | :-----: | :------------------------------: | :----: | :-: |
| **69** | **68**  |             **14.1**             | **79** | no  |
|        |         | 11 _(scroll-snap-margin-bottom)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-bottom
  - scrollsnapmarginleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |             safari             |  edge  | ie  |
| :----: | :-----: | :----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**            | **79** | no  |
|        |         | 11 _(scroll-snap-margin-left)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-left
  - scrollsnapmarginright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |             safari              |  edge  | ie  |
| :----: | :-----: | :-----------------------------: | :----: | :-: |
| **69** | **68**  |            **14.1**             | **79** | no  |
|        |         | 11 _(scroll-snap-margin-right)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-right
  - scrollsnapmargintop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<length>`

**initial value**: `0`

| chrome | firefox |            safari             |  edge  | ie  |
| :----: | :-----: | :---------------------------: | :----: | :-: |
| **69** | **68**  |           **14.1**            | **79** | no  |
|        |         | 11 _(scroll-snap-margin-top)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-top
  - scrollsnapstop (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'always'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2022.

**syntax**: `normal | always`

**initial value**: `normal`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **75** | **103** | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-snap-stop
  - scrollsnaptype (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2022.

**syntax**: `none | [ x | y | block | inline | both ] [ mandatory | proximity ]?`

**initial value**: `none`

| chrome | firefox | safari  |  edge  |      ie      |
| :----: | :-----: | :-----: | :----: | :----------: |
| **69** |  39-68  | **11**  | **79** | **10** _-x-_ |
|        |         | 9 _-x-_ |        |              |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-snap-type
  - scrolltimelineaxis (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ block | inline | x | y ]#`

**initial value**: `block`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-timeline-axis
  - scrolltimelinename (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ none | <dashed-ident> ]#`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-timeline-name
  - scrollbarcolor (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | <color>{2}`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **121** | **64**  |   no   | **121** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scrollbar-color
  - scrollbargutter (optional): since december 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | stable && both-edges?`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **94** | **97**  | **18.2** | **94** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scrollbar-gutter
  - scrollbarwidth (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'thin'; optional): since december 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | thin | none`

**initial value**: `auto`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **121** | **64**  | **18.2** | **121** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scrollbar-width
  - shapeimagethreshold (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<opacity-value>`

**initial value**: `0.0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/shape-image-threshold
  - shapemargin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<length-percentage>`

**initial value**: `0`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/shape-margin
  - shapeoutside (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `none | [ <shape-box> || <basic-shape> ] | <image>`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **37** | **62**  | **10.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/shape-outside
  - shaperendering (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'crispedges', 'geometricprecision', 'optimizespeed'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | optimizespeed | crispedges | geometricprecision`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **1**  |  **3**  | **4**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/shape-rendering
  - speakas (optional): **syntax**: `normal | spell-out || digits || [ literal-punctuation | no-punctuation ]`

**initial value**: `auto`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
|   no   |   no    | **11.1** |  no  | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/speak-as
  - stopcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<'color'>`

**initial value**: `black`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stop-color
  - stopopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<'opacity'>`

**initial value**: `black`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stop-opacity
  - stroke (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<paint>`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke
  - strokecolor (optional): **syntax**: `<color>`

**initial value**: `transparent`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
|   no   |   no    | **11.1** |  no  | no  |
  - strokedasharray (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `none | <dasharray>`

**initial value**: `none`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-dasharray
  - strokedashoffset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<length-percentage> | <number>`

**initial value**: `0`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-dashoffset
  - strokelinecap (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'round', 'butt', 'square'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `butt | round | square`

**initial value**: `butt`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-linecap
  - strokelinejoin (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'round', 'arcs', 'bevel', 'miter', 'miter-clip'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `miter | miter-clip | round | bevel | arcs`

**initial value**: `miter`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-linejoin
  - strokemiterlimit (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<number>`

**initial value**: `4`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-miterlimit
  - strokeopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<'opacity'>`

**initial value**: `1`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-opacity
  - strokewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<length-percentage> | <number>`

**initial value**: `1px`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  | **1.5** | **4**  | **≤15** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/stroke-width
  - tabsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2021.

**syntax**: `<integer> | <length>`

**initial value**: `8`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **21** | **91**  | **7**  | **79** | no  |
|        | 4 _-x-_ |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/tab-size
  - tablelayout (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'fixed'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | fixed`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **14** |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/table-layout
  - textalign (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', '-khtml-center', '-khtml-left', '-khtml-right', '-moz-center', '-moz-left', '-moz-right', '-webkit-center', '-webkit-left', '-webkit-match-parent', '-webkit-right', 'justify', 'match-parent'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `start | end | left | right | center | justify | match-parent`

**initial value**: `start`, or a nameless value that acts as `left` if _direction_ is `ltr`, `right` if _direction_ is `rtl` if `start` is not supported by the browser.

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-align
  - textalignlast (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'center', 'end', 'start', 'justify'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `auto | start | end | left | right | center | justify`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **47** | **49**  | **16** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-align-last
  - textanchor (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'end', 'start', 'middle'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2016.

**syntax**: `start | middle | end`

**initial value**: `start`

| chrome | firefox | safari |  edge   | ie  |
| :----: | :-----: | :----: | :-----: | :-: |
| **1**  |  **3**  | **4**  | **≤14** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-anchor
  - textautospace (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | <autospace> | auto`

**initial value**: `normal`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **140** | **145** | **18.4** | **140** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-autospace
  - textbox (optional): **syntax**: `normal | <'text-box-trim'> || <'text-box-edge'>`

**initial value**: `normal`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   no    | **18.2** | **133** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-box
  - textboxedge (optional): **syntax**: `auto | <text-edge>`

**initial value**: `auto`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   no    | **18.2** | **133** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-box-edge
  - textboxtrim (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'trim-both', 'trim-end', 'trim-start'; optional): **syntax**: `none | trim-start | trim-end | trim-both`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **133** |   no    | **18.2** | **133** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-box-trim
  - textcombineupright (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | all | [ digits <integer>? ]`

**initial value**: `none`

|           chrome           | firefox |            safari            |  edge  |                   ie                   |
| :------------------------: | :-----: | :--------------------------: | :----: | :------------------------------------: |
|           **48**           | **48**  |           **15.4**           | **79** | **11** _(-ms-text-combine-horizontal)_ |
| 9 _(-webkit-text-combine)_ |         | 5.1 _(-webkit-text-combine)_ |        |                                        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-combine-upright
  - textdecorationcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<color>`

**initial value**: `currentcolor`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | no  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-color
  - textdecorationline (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | no  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-line
  - textdecorationskip (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | [ objects || [ spaces | [ leading-spaces || trailing-spaces ] ] || edges || box-decoration ]`

**initial value**: `objects`

| chrome | firefox |  safari  | edge | ie  |
| :----: | :-----: | :------: | :--: | :-: |
| 57-64  |   no    | **12.1** |  no  | no  |
|        |         | 7 _-x-_  |      |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-skip
  - textdecorationskipink (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `auto | all | none`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **64** | **70**  | **15.4** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-skip-ink
  - textdecorationstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `solid | double | dotted | dashed | wavy`

**initial value**: `solid`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **36**  | **12.1** | **79** | no  |
|        |         | 8 _-x-_  |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-style
  - textdecorationthickness (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2021.

**syntax**: `auto | from-font | <length> | <percentage> `

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **89** | **70**  | **12.1** | **89** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration-thickness
  - textemphasiscolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `<color>`

**initial value**: `currentcolor`

|  chrome  | firefox | safari |   edge   | ie  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | no  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-emphasis-color
  - textemphasisposition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `auto | [ over | under ] && [ right | left ]?`

**initial value**: `auto`

|  chrome  | firefox | safari |   edge   | ie  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | no  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-emphasis-position
  - textemphasisstyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | [ [ filled | open ] || [ dot | circle | double-circle | triangle | sesame ] ] | <string>`

**initial value**: `none`

|  chrome  | firefox | safari |   edge   | ie  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | no  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-emphasis-style
  - textindent (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage> && hanging? && each-line?`

**initial value**: `0`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-indent
  - textjustify (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'inter-character', 'distribute', 'inter-word'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | inter-character | inter-word | none`

**initial value**: `auto`

| chrome | firefox | safari | edge  |   ie   |
| :----: | :-----: | :----: | :---: | :----: |
|   no   | **55**  |   no   | 12-79 | **11** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-justify
  - textorientation (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'mixed', 'sideways', 'sideways-right', 'upright'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2020.

**syntax**: `mixed | upright | sideways`

**initial value**: `mixed`

|  chrome  | firefox |  safari   |  edge  | ie  |
| :------: | :-----: | :-------: | :----: | :-: |
|  **48**  | **41**  |  **14**   | **79** | no  |
| 12 _-x-_ |         | 5.1 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-orientation
  - textoverflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**initial value**: `clip`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **1**  |  **7**  | **1.3** | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-overflow
  - textrendering (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'geometricprecision', 'optimizespeed', 'optimizelegibility'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | optimizespeed | optimizelegibility | geometricprecision`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **4**  |  **1**  | **5**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-rendering
  - textshadow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <shadow-t>#`

**initial value**: `none`

| chrome | firefox | safari  |  edge  |   ie   |
| :----: | :-----: | :-----: | :----: | :----: |
| **2**  | **3.5** | **1.1** | **12** | **10** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-shadow
  - textsizeadjust (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | auto | <percentage>`

**initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **54** |   no    |   no   | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-size-adjust
  - textspacingtrim (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'trim-start', 'space-all', 'space-first'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `space-all | normal | space-first | trim-start`

**initial value**: `normal`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **123** |   no    |   no   | **123** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-spacing-trim
  - texttransform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | [ capitalize | uppercase | lowercase ] || full-width || full-size-kana | math-auto`

**initial value**: `none`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-transform
  - textunderlineoffset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since november 2020.

**syntax**: `auto | <length> | <percentage> `

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **70**  | **12.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-underline-offset
  - textunderlineposition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | from-font | [ under || [ left | right ] ]`

**initial value**: `auto`

| chrome | firefox |  safari  |  edge  |  ie   |
| :----: | :-----: | :------: | :----: | :---: |
| **33** | **74**  | **12.1** | **12** | **6** |
|        |         | 9 _-x-_  |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-underline-position
  - textwrapmode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap'; optional): since october 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `wrap | nowrap`

**initial value**: `wrap`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **130** | **124** | **17.4** | **130** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-wrap-mode
  - textwrapstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance', 'stable', 'pretty'; optional): since october 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | balance | stable | pretty`

**initial value**: `auto`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **130** | **124** | **17.5** | **130** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-wrap-style
  - timelinescope (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <dashed-ident>#`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **116** |   no    | **26** | **116** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/timeline-scope
  - top (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage> | <anchor()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/top
  - touchaction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2019.

**syntax**: `auto | none | [ [ pan-x | pan-left | pan-right ] || [ pan-y | pan-up | pan-down ] || pinch-zoom ] | manipulation`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |    ie    |
| :----: | :-----: | :----: | :----: | :------: |
| **36** | **52**  | **13** | **12** |  **11**  |
|        |         |        |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/touch-action
  - transform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <transform-list>`

**initial value**: `none`

| chrome  |  firefox  |  safari   |  edge  |   ie    |
| :-----: | :-------: | :-------: | :----: | :-----: |
| **36**  |  **16**   |   **9**   | **12** | **10**  |
| 1 _-x-_ | 3.5 _-x-_ | 3.1 _-x-_ |        | 9 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transform
  - transformbox (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box', 'fill-box', 'stroke-box', 'view-box'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `content-box | border-box | fill-box | stroke-box | view-box`

**initial value**: `view-box`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **64** | **55**  | **11** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transform-box
  - transformorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**initial value**: `50\% 50\% 0`

| chrome  |  firefox  | safari  |  edge  |   ie    |
| :-----: | :-------: | :-----: | :----: | :-----: |
| **36**  |  **16**   |  **9**  | **12** | **10**  |
| 1 _-x-_ | 3.5 _-x-_ | 2 _-x-_ |        | 9 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transform-origin
  - transformstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `flat | preserve-3d`

**initial value**: `flat`

|  chrome  | firefox  | safari  |  edge  | ie  |
| :------: | :------: | :-----: | :----: | :-: |
|  **36**  |  **16**  |  **9**  | **12** | no  |
| 12 _-x-_ | 10 _-x-_ | 4 _-x-_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transform-style
  - transitionbehavior (optional): since august 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<transition-behavior-value>#`

**initial value**: `normal`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **117** | **129** | **17.4** | **117** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition-behavior
  - transitiondelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **26**  | **16**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition-delay
  - transitionduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`

| chrome  | firefox |  safari   |  edge  |   ie   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition-duration
  - transitionproperty (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <single-transition-property>#`

**initial value**: all

| chrome  | firefox |  safari   |  edge  |   ie   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition-property
  - transitiontimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`

| chrome  | firefox |  safari   |  edge  |   ie   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition-timing-function
  - translate (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2022.

**syntax**: `none | <length-percentage> [ <length-percentage> <length>? ]?`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **104** | **72**  | **14.1** | **104** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/translate
  - unicodebidi (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'isolate', '-moz-isolate', '-moz-isolate-override', '-moz-plaintext', '-webkit-isolate', '-webkit-isolate-override', '-webkit-plaintext', 'bidi-override', 'embed', 'isolate-override', 'plaintext'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | embed | isolate | bidi-override | isolate-override | plaintext`

**initial value**: `normal`

| chrome | firefox | safari  |  edge  |   ie    |
| :----: | :-----: | :-----: | :----: | :-----: |
| **2**  |  **1**  | **1.3** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/unicode-bidi
  - userselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | text | none | all`

**initial value**: `auto`

| chrome  | firefox |   safari    |   edge   |      ie      |
| :-----: | :-----: | :---------: | :------: | :----------: |
| **54**  | **69**  | **3** _-x-_ |  **79**  | **10** _-x-_ |
| 1 _-x-_ | 1 _-x-_ |             | 12 _-x-_ |              |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/user-select
  - vectoreffect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'fixed-position', 'non-rotation', 'non-scaling-size', 'non-scaling-stroke'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `none | non-scaling-stroke | non-scaling-size | non-rotation | fixed-position`

**initial value**: `none`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **6**  | **15**  | **5.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/vector-effect
  - verticalalign (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `baseline | sub | super | text-top | text-bottom | middle | top | bottom | <percentage> | <length>`

**initial value**: `baseline`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/vertical-align
  - viewtimelineaxis (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ block | inline | x | y ]#`

**initial value**: `block`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-timeline-axis
  - viewtimelineinset (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ [ auto | <length-percentage> ]{1,2} ]#`

**initial value**: `auto`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-timeline-inset
  - viewtimelinename (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ none | <dashed-ident> ]#`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-timeline-name
  - viewtransitionclass (optional): **syntax**: `none | <custom-ident>+`

**initial value**: `none`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **125** | **144** | **18.2** | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-transition-class
  - viewtransitionname (optional): since october 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | <custom-ident> | match-element`

**initial value**: `none`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **111** | **144** | **18** | **111** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-transition-name
  - visibility (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible', 'collapse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `visible | hidden | collapse`

**initial value**: `visible`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/visibility
  - whitespace (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | pre | pre-wrap | pre-line | <'white-space-collapse'> || <'text-wrap-mode'>`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/white-space
  - whitespacecollapse (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'collapse', 'break-spaces', 'preserve', 'preserve-breaks', 'preserve-spaces'; optional): since march 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `collapse | preserve | preserve-breaks | preserve-spaces | break-spaces`

**initial value**: `collapse`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **114** | **124** | **17.4** | **114** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/white-space-collapse
  - widows (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<integer>`

**initial value**: `2`

| chrome | firefox | safari  |  edge  |  ie   |
| :----: | :-----: | :-----: | :----: | :---: |
| **25** |   no    | **1.3** | **12** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/widows
  - width (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <length-percentage [0,∞]> | min-content | max-content | fit-content | fit-content(<length-percentage [0,∞]>) | <calc-size()> | <anchor-size()>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/width
  - willchange (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | <animateable-feature>#`

**initial value**: `auto`

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **36** | **36**  | **9.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/will-change
  - wordbreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word', 'auto-phrase', 'break-all', 'keep-all'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | break-all | keep-all | break-word | auto-phrase`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  | **15**  | **3**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/word-break
  - wordspacing (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | <length>`

**initial value**: `normal`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **6** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/word-spacing
  - wordwrap (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2018.

**syntax**: `normal | break-word`

**initial value**: `normal`
  - writingmode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**initial value**: `horizontal-tb`

| chrome  | firefox |  safari   |  edge  |  ie   |
| :-----: | :-----: | :-------: | :----: | :---: |
| **48**  | **41**  | **10.1**  | **12** | **9** |
| 8 _-x-_ |         | 5.1 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/writing-mode
  - x (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **42** | **69**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/x
  - y (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `<length> | <percentage>`

**initial value**: `0`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **42** | **69**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/y
  - zindex (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <integer>`

**initial value**: `auto`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/z-index
  - zoom (optional): since may 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `normal | reset | <number [0,∞]> || <percentage [0,∞]>`

**initial value**: `1`

| chrome | firefox | safari  |  edge  |   ie    |
| :----: | :-----: | :-----: | :----: | :-----: |
| **1**  | **126** | **3.1** | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/zoom
  - all (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `initial | inherit | unset | revert | revert-layer`

**initial value**: there is no practical initial value for it.

| chrome | firefox | safari  |  edge  | ie  |
| :----: | :-----: | :-----: | :----: | :-: |
| **37** | **27**  | **9.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/all
  - animation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation>#`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **43**  | **16**  |  **9**  | **12** | **10** |
| 3 _-x-_ | 5 _-x-_ | 4 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation
  - animationrange (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <'animation-range-start'> <'animation-range-end'>? ]#`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/animation-range
  - background (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-layer>#? , <final-bg-layer>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background
  - backgroundposition (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-position>#`

**initial value**: `0\% 0\%`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/background-position
  - border (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width> || <line-style> || <color>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border
  - borderblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-block-start'>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block
  - borderblockcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-color'>{1,2}`

**initial value**: `currentcolor`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-color
  - borderblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-end
  - borderblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-start
  - borderblockstyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-style'>{1,2}`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-style
  - borderblockwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-width'>{1,2}`

**initial value**: `medium`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-block-width
  - borderbottom (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width> || <line-style> || <color>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-bottom
  - bordercolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<color>{1,4}`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-color
  - borderimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`

| chrome  |  firefox  | safari  |  edge  |   ie   |
| :-----: | :-------: | :-----: | :----: | :----: |
| **16**  |  **15**   |  **6**  | **12** | **11** |
| 7 _-x-_ | 3.5 _-x-_ | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-image
  - borderinline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-block-start'>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline
  - borderinlinecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-color'>{1,2}`

**initial value**: `currentcolor`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-color
  - borderinlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-end
  - borderinlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'> || <'border-top-style'> || <color>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **41**  | **12.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-start
  - borderinlinestyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-style'>{1,2}`

**initial value**: `none`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-style
  - borderinlinewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'border-top-width'>{1,2}`

**initial value**: `medium`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-inline-width
  - borderleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width> || <line-style> || <color>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-left
  - borderradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`

| chrome  | firefox | safari  |  edge  |  ie   |
| :-----: | :-----: | :-----: | :----: | :---: |
|  **4**  |  **4**  |  **5**  | **12** | **9** |
| 1 _-x-_ |         | 3 _-x-_ |        |       |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-radius
  - borderright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width> || <line-style> || <color>`

| chrome | firefox | safari |  edge  |   ie    |
| :----: | :-----: | :----: | :----: | :-----: |
| **1**  |  **1**  | **1**  | **12** | **5.5** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-right
  - borderstyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-style>{1,4}`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-style
  - bordertop (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width> || <line-style> || <color>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-top
  - borderwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>{1,4}`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/border-width
  - caret (optional): **syntax**: `<'caret-color'> || <'caret-shape'>`
  - columnrule (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`

| chrome  | firefox | safari  |  edge  |   ie   |
| :-----: | :-----: | :-----: | :----: | :----: |
| **50**  | **52**  |  **9**  | **12** | **10** |
| 1 _-x-_ |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/column-rule
  - columns (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-width'> || <'column-count'>`

| chrome | firefox | safari  |  edge  |   ie   |
| :----: | :-----: | :-----: | :----: | :----: |
| **50** | **52**  |  **9**  | **12** | **10** |
|        |         | 3 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/columns
  - containintrinsicsize (character | numeric; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ auto? [ none | <length> ] ]{1,2}`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **83** | **107** | **17** | **83** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/contain-intrinsic-size
  - container (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since february 2023.

**syntax**: `<'container-name'> [ / <'container-type'> ]?`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **105** | **110** | **16** | **105** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/container
  - flex (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`

|  chrome  | firefox | safari  |  edge  |    ie    |
| :------: | :-----: | :-----: | :----: | :------: |
|  **29**  | **22**  |  **9**  | **12** |  **11**  |
| 21 _-x-_ |         | 7 _-x-_ |        | 10 _-x-_ |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex
  - flexflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<'flex-direction'> || <'flex-wrap'>`

|  chrome  | firefox | safari  |  edge  |   ie   |
| :------: | :-----: | :-----: | :----: | :----: |
|  **29**  | **28**  |  **9**  | **12** | **11** |
| 21 _-x-_ |         | 7 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/flex-flow
  - font (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ [ <'font-style'> || <font-variant-css2> || <'font-weight'> || <font-width-css3> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'># ] | <system-family-name>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/font
  - gap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<'row-gap'> <'column-gap'>?`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/gap
  - grid (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<'grid-template'> | <'grid-template-rows'> / [ auto-flow && dense? ] <'grid-auto-columns'>? | [ auto-flow && dense? ] <'grid-auto-rows'>? / <'grid-template-columns'>`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid
  - gridarea (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line> [ / <grid-line> ]{0,3}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-area
  - gridcolumn (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line> [ / <grid-line> ]?`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-column
  - gridrow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<grid-line> [ / <grid-line> ]?`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-row
  - gridtemplate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `none | [ <'grid-template-rows'> / <'grid-template-columns'> ] | [ <line-names>? <string> <track-size>? <line-names>? ]+ [ / <explicit-track-list> ]?`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **57** | **52**  | **10.1** | **16** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/grid-template
  - inset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>{1,4}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset
  - insetblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-block
  - insetinline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **63**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/inset-inline
  - lineclamp (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <integer>`

**initial value**: `none`

|   chrome    |   firefox    |  safari   |     edge     | ie  |
| :---------: | :----------: | :-------: | :----------: | :-: |
| **6** _-x-_ | **68** _-x-_ | 18.2-18.4 | **17** _-x-_ | no  |
|             |              |  5 _-x-_  |              |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/line-clamp
  - liststyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'list-style-type'> || <'list-style-position'> || <'list-style-image'>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/list-style
  - margin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'margin-top'>{1,4}`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin
  - marginblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'margin-top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-block
  - margininline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'margin-top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/margin-inline
  - mask (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<mask-layer>#`

| chrome  | firefox |  safari   | edge  | ie  |
| :-----: | :-----: | :-------: | :---: | :-: |
| **120** | **53**  | **15.4**  | 12-79 | no  |
| 1 _-x-_ |         | 3.1 _-x-_ |       |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask
  - maskborder (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<'mask-border-source'> || <'mask-border-slice'> [ / <'mask-border-width'>? [ / <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>`

|              chrome              | firefox |             safari             |               edge                | ie  |
| :------------------------------: | :-----: | :----------------------------: | :-------------------------------: | :-: |
| **1** _(-webkit-mask-box-image)_ |   no    |            **17.2**            | **79** _(-webkit-mask-box-image)_ | no  |
|                                  |         | 3.1 _(-webkit-mask-box-image)_ |                                   |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/mask-border
  - motion (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?`

|    chrome     | firefox | safari |  edge  | ie  |
| :-----------: | :-----: | :----: | :----: | :-: |
|    **55**     | **72**  | **16** | **79** | no  |
| 46 _(motion)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset
  - offset (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?`

|    chrome     | firefox | safari |  edge  | ie  |
| :-----------: | :-----: | :----: | :----: | :-: |
|    **55**     | **72**  | **16** | **79** | no  |
| 46 _(motion)_ |         |        |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/offset
  - outline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `<'outline-width'> || <'outline-style'> || <'outline-color'>`

| chrome | firefox |  safari  |  edge  |  ie   |
| :----: | :-----: | :------: | :----: | :---: |
| **94** | **88**  | **16.4** | **94** | **8** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/outline
  - overflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ visible | hidden | clip | scroll | auto ]{1,2}`

**initial value**: `visible`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overflow
  - overscrollbehavior (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `[ contain | none | auto ]{1,2}`

**initial value**: `auto`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **63** | **59**  | **16** | **18** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/overscroll-behavior
  - padding (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'padding-top'>{1,4}`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **4** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding
  - paddingblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'padding-top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-block
  - paddinginline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'padding-top'>{1,2}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **87** | **66**  | **14.1** | **87** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/padding-inline
  - placecontent (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'align-content'> <'justify-content'>?`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **9**  | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/place-content
  - placeitems (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'align-items'> <'justify-items'>?`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **11** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/place-items
  - placeself (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'align-self'> <'justify-self'>?`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **59** | **45**  | **11** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/place-self
  - positiontry (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<'position-try-order'>? <'position-try-fallbacks'>`

| chrome  |   firefox   | safari |  edge   | ie  |
| :-----: | :---------: | :----: | :-----: | :-: |
| **125** | **preview** | **26** | **125** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/position-try
  - scrollmargin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2021.

**syntax**: `<length>{1,4}`

| chrome | firefox |          safari           |  edge  | ie  |
| :----: | :-----: | :-----------------------: | :----: | :-: |
| **69** | **90**  |         **14.1**          | **79** | no  |
|        |         | 11 _(scroll-snap-margin)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin
  - scrollmarginblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>{1,2}`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-block
  - scrollmargininline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `<length>{1,2}`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin-inline
  - scrollpadding (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `[ auto | <length-percentage> ]{1,4}`

| chrome | firefox |  safari  |  edge  | ie  |
| :----: | :-----: | :------: | :----: | :-: |
| **69** | **68**  | **14.1** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding
  - scrollpaddingblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `[ auto | <length-percentage> ]{1,2}`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-block
  - scrollpaddinginline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2021.

**syntax**: `[ auto | <length-percentage> ]{1,2}`

| chrome | firefox | safari |  edge  | ie  |
| :----: | :-----: | :----: | :----: | :-: |
| **69** | **68**  | **15** | **79** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-padding-inline
  - scrollsnapmargin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2021.

**syntax**: `<length>{1,4}`

| chrome | firefox |          safari           |  edge  | ie  |
| :----: | :-----: | :-----------------------: | :----: | :-: |
| **69** |  68-90  |         **14.1**          | **79** | no  |
|        |         | 11 _(scroll-snap-margin)_ |        |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-margin
  - scrolltimeline (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <'scroll-timeline-name'> <'scroll-timeline-axis'>? ]#`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/scroll-timeline
  - textdecoration (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'> || <'text-decoration-thickness'>`

| chrome | firefox | safari |  edge  |  ie   |
| :----: | :-----: | :----: | :----: | :---: |
| **1**  |  **1**  | **1**  | **12** | **3** |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-decoration
  - textemphasis (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `<'text-emphasis-style'> || <'text-emphasis-color'>`

|  chrome  | firefox | safari |   edge   | ie  |
| :------: | :-----: | :----: | :------: | :-: |
|  **99**  | **46**  | **7**  |  **99**  | no  |
| 25 _-x-_ |         |        | 79 _-x-_ |     |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-emphasis
  - textwrap (optional): since march 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<'text-wrap-mode'> || <'text-wrap-style'>`

**initial value**: `wrap`

| chrome  | firefox |  safari  |  edge   | ie  |
| :-----: | :-----: | :------: | :-----: | :-: |
| **114** | **121** | **17.4** | **114** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/text-wrap
  - transition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-transition>#`

| chrome  | firefox |  safari   |  edge  |   ie   |
| :-----: | :-----: | :-------: | :----: | :----: |
| **26**  | **16**  |   **9**   | **12** | **10** |
| 1 _-x-_ |         | 3.1 _-x-_ |        |        |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/transition
  - viewtimeline (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <'view-timeline-name'> [ <'view-timeline-axis'> || <'view-timeline-inset'> ]? ]#`

| chrome  | firefox | safari |  edge   | ie  |
| :-----: | :-----: | :----: | :-----: | :-: |
| **115** |   no    | **26** | **115** | no  |
@,see,https,://developer.mozilla.org/docs/web/css/reference/properties/view-timeline
  - mozanimationdelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - mozanimationdirection (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-direction>#`

**initial value**: `normal`
  - mozanimationduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ auto | <time [0s,∞]> ]#`

**initial value**: `0s`
  - mozanimationfillmode (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-fill-mode>#`

**initial value**: `none`
  - mozanimationiterationcount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-iteration-count>#`

**initial value**: `1`
  - mozanimationname (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ none | <keyframes-name> ]#`

**initial value**: `none`
  - mozanimationplaystate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-play-state>#`

**initial value**: `running`
  - mozanimationtimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
  - mozappearance (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'radio', 'searchfield', 'menulist-button', 'textfield', '-moz-mac-unified-toolbar', '-moz-win-borderless-glass', '-moz-win-browsertabbar-toolbox', '-moz-win-communications-toolbox', '-moz-win-communicationstext', '-moz-win-exclude-glass', '-moz-win-glass', '-moz-win-media-toolbox', '-moz-win-mediatext', '-moz-window-button-box', '-moz-window-button-box-maximized', '-moz-window-button-close', '-moz-window-button-maximize', '-moz-window-button-minimize', '-moz-window-button-restore', '-moz-window-frame-bottom', '-moz-window-frame-left', '-moz-window-frame-right', '-moz-window-titlebar', '-moz-window-titlebar-maximized', 'button-arrow-down', 'button-arrow-next', 'button-arrow-previous', 'button-arrow-up', 'button-bevel', 'button-focus', 'caret', 'checkbox-container', 'checkbox-label', 'checkmenuitem', 'dualbutton', 'groupbox', 'listitem', 'menuarrow', 'menubar', 'menucheckbox', 'menuimage', 'menuitem', 'menuitemtext', 'menulist-text', 'menulist-textfield', 'menupopup', 'menuradio', 'menuseparator', 'meterbar', 'meterchunk', 'progressbar', 'progressbar-vertical', 'progresschunk', 'progresschunk-vertical', 'radio-container', 'radio-label', 'radiomenuitem', 'range', 'range-thumb', 'resizer', 'resizerpanel', 'scale-horizontal', 'scale-vertical', 'scalethumb-horizontal', 'scalethumb-vertical', 'scalethumbend', 'scalethumbstart', 'scalethumbtick', 'scrollbarbutton-down', 'scrollbarbutton-left', 'scrollbarbutton-right', 'scrollbarbutton-up', 'scrollbarthumb-horizontal', 'scrollbarthumb-vertical', 'scrollbartrack-horizontal', 'scrollbartrack-vertical', 'separator', 'sheet', 'spinner', 'spinner-downbutton', 'spinner-textfield', 'spinner-upbutton', 'splitter', 'statusbar', 'statusbarpanel', 'tab', 'tab-scroll-arrow-back', 'tab-scroll-arrow-forward', 'tabpanel', 'tabpanels', 'textfield-multiline', 'toolbar', 'toolbarbutton', 'toolbarbutton-dropdown', 'toolbargripper', 'toolbox', 'tooltip', 'treeheader', 'treeheadercell', 'treeheadersortarrow', 'treeitem', 'treeline', 'treetwisty', 'treetwistyopen', 'treeview'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | button | button-arrow-down | button-arrow-next | button-arrow-previous | button-arrow-up | button-bevel | button-focus | caret | checkbox | checkbox-container | checkbox-label | checkmenuitem | dualbutton | groupbox | listbox | listitem | menuarrow | menubar | menucheckbox | menuimage | menuitem | menuitemtext | menulist | menulist-button | menulist-text | menulist-textfield | menupopup | menuradio | menuseparator | meterbar | meterchunk | progressbar | progressbar-vertical | progresschunk | progresschunk-vertical | radio | radio-container | radio-label | radiomenuitem | range | range-thumb | resizer | resizerpanel | scale-horizontal | scalethumbend | scalethumb-horizontal | scalethumbstart | scalethumbtick | scalethumb-vertical | scale-vertical | scrollbarbutton-down | scrollbarbutton-left | scrollbarbutton-right | scrollbarbutton-up | scrollbarthumb-horizontal | scrollbarthumb-vertical | scrollbartrack-horizontal | scrollbartrack-vertical | searchfield | separator | sheet | spinner | spinner-downbutton | spinner-textfield | spinner-upbutton | splitter | statusbar | statusbarpanel | tab | tabpanel | tabpanels | tab-scroll-arrow-back | tab-scroll-arrow-forward | textfield | textfield-multiline | toolbar | toolbarbutton | toolbarbutton-dropdown | toolbargripper | toolbox | tooltip | treeheader | treeheadercell | treeheadersortarrow | treeitem | treeline | treetwisty | treetwistyopen | treeview | -moz-mac-unified-toolbar | -moz-win-borderless-glass | -moz-win-browsertabbar-toolbox | -moz-win-communicationstext | -moz-win-communications-toolbox | -moz-win-exclude-glass | -moz-win-glass | -moz-win-mediatext | -moz-win-media-toolbox | -moz-window-button-box | -moz-window-button-box-maximized | -moz-window-button-close | -moz-window-button-maximize | -moz-window-button-minimize | -moz-window-button-restore | -moz-window-frame-bottom | -moz-window-frame-left | -moz-window-frame-right | -moz-window-titlebar | -moz-window-titlebar-maximized`

**initial value**: `none` (but this value is overridden in the user agent css)
  - mozbackfacevisibility (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `visible | hidden`

**initial value**: `visible`
  - mozbinding (optional): **syntax**: `<url> | none`

**initial value**: `none`
  - mozborderbottomcolors (optional): **syntax**: `<color>+ | none`

**initial value**: `none`
  - mozborderendcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`
  - mozborderendstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`
  - mozborderendwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-width'>`

**initial value**: `medium`
  - mozborderleftcolors (optional): **syntax**: `<color>+ | none`

**initial value**: `none`
  - mozborderrightcolors (optional): **syntax**: `<color>+ | none`

**initial value**: `none`
  - mozborderstartcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-color'>`

**initial value**: `currentcolor`
  - mozborderstartstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'hidden', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'border-top-style'>`

**initial value**: `none`
  - mozbordertopcolors (optional): **syntax**: `<color>+ | none`

**initial value**: `none`
  - mozboxsizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `content-box | border-box`

**initial value**: `content-box`
  - mozcolumnrulecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - mozcolumnrulestyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-style'>`

**initial value**: `none`
  - mozcolumnrulewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-width'>`

**initial value**: `medium`
  - mozcolumnwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since november 2016.

**syntax**: `<length> | auto`

**initial value**: `auto`
  - mozcontextproperties (optional): **syntax**: `none | [ fill | fill-opacity | stroke | stroke-opacity ]#`

**initial value**: `none`
  - mozfontfeaturesettings (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `normal | <feature-tag-value>#`

**initial value**: `normal`
  - mozfontlanguageoverride (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | <string>`

**initial value**: `normal`
  - mozhyphens (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | manual | auto`

**initial value**: `manual`
  - mozmarginend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`
  - mozmarginstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`
  - mozorient (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'block', 'inline', 'horizontal', 'vertical'; optional): the **`-moz-orient`** css property specifies the orientation of the element to which it's applied.

**syntax**: `inline | block | horizontal | vertical`

**initial value**: `inline`
  - mozosxfontsmoothing (character | numeric; optional): the **`font-smooth`** css property controls the application of anti-aliasing when fonts are rendered.

**syntax**: `auto | never | always | <absolute-size> | <length>`

**initial value**: `auto`
  - mozoutlineradiusbottomleft (character | numeric; optional): **syntax**: `<outline-radius>`

**initial value**: `0`
  - mozoutlineradiusbottomright (character | numeric; optional): **syntax**: `<outline-radius>`

**initial value**: `0`
  - mozoutlineradiustopleft (character | numeric; optional): **syntax**: `<outline-radius>`

**initial value**: `0`
  - mozoutlineradiustopright (character | numeric; optional): **syntax**: `<outline-radius>`

**initial value**: `0`
  - mozpaddingend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`
  - mozpaddingstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`
  - mozperspective (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <length>`

**initial value**: `none`
  - mozperspectiveorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<position>`

**initial value**: `50\% 50\%`
  - mozstacksizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'ignore', 'stretch-to-fit'; optional): **syntax**: `ignore | stretch-to-fit`

**initial value**: `stretch-to-fit`
  - moztabsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2021.

**syntax**: `<integer> | <length>`

**initial value**: `8`
  - moztextblink (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'blink'; optional): **syntax**: `none | blink`

**initial value**: `none`
  - moztextsizeadjust (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | auto | <percentage>`

**initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).
  - moztransform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <transform-list>`

**initial value**: `none`
  - moztransformorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**initial value**: `50\% 50\% 0`
  - moztransformstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `flat | preserve-3d`

**initial value**: `flat`
  - mozusermodify (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'read-only', 'read-write', 'write-only'; optional): the **`user-modify`** property has no effect in firefox. it was originally planned to determine whether or not the content of an element can be edited by a user.

**syntax**: `read-only | read-write | write-only`

**initial value**: `read-only`
  - mozuserselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | text | none | all`

**initial value**: `auto`
  - mozwindowdragging (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'drag', 'no-drag'; optional): **syntax**: `drag | no-drag`

**initial value**: `drag`
  - mozwindowshadow (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'default', 'menu', 'sheet', 'tooltip'; optional): **syntax**: `default | menu | tooltip | sheet | none`

**initial value**: `default`
  - msaccelerator (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'false', 'true'; optional): **syntax**: `false | true`

**initial value**: `false`
  - msblockprogression (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'bt', 'lr', 'rl', 'tb'; optional): **syntax**: `tb | rl | bt | lr`

**initial value**: `tb`
  - mscontentzoomchaining (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'chained'; optional): **syntax**: `none | chained`

**initial value**: `none`
  - mscontentzoomlimitmax (optional): **syntax**: `<percentage>`

**initial value**: `400\%`
  - mscontentzoomlimitmin (optional): **syntax**: `<percentage>`

**initial value**: `100\%`
  - mscontentzoomsnappoints (optional): **syntax**: `snapinterval( <percentage>, <percentage> ) | snaplist( <percentage># )`

**initial value**: `snapinterval(0\%, 100\%)`
  - mscontentzoomsnaptype (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **syntax**: `none | proximity | mandatory`

**initial value**: `none`
  - mscontentzooming (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'zoom'; optional): **syntax**: `none | zoom`

**initial value**: zoom for the top level element, none for all other elements
  - msfilter (optional): **syntax**: `<string>`

**initial value**: "" (the empty string)
  - msflexdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `row | row-reverse | column | column-reverse`

**initial value**: `row`
  - msflexpositive (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<number>`

**initial value**: `0`
  - msflowfrom (optional): **syntax**: `[ none | <custom-ident> ]#`

**initial value**: `none`
  - msflowinto (optional): **syntax**: `[ none | <custom-ident> ]#`

**initial value**: `none`
  - msgridcolumns (character | numeric; optional): **syntax**: `none | <track-list> | <auto-track-list>`

**initial value**: `none`
  - msgridrows (character | numeric; optional): **syntax**: `none | <track-list> | <auto-track-list>`

**initial value**: `none`
  - mshighcontrastadjust (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none'; optional): **syntax**: `auto | none`

**initial value**: `auto`
  - mshyphenatelimitchars (optional): **syntax**: `auto | <integer>{1,3}`

**initial value**: `auto`
  - mshyphenatelimitlines (optional): **syntax**: `no-limit | <integer>`

**initial value**: `no-limit`
  - mshyphenatelimitzone (character | numeric; optional): **syntax**: `<percentage> | <length>`

**initial value**: `0`
  - mshyphens (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | manual | auto`

**initial value**: `manual`
  - msimealign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'after'; optional): **syntax**: `auto | after`

**initial value**: `auto`
  - mslinebreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | loose | normal | strict | anywhere`

**initial value**: `auto`
  - msorder (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<integer>`

**initial value**: `0`
  - msoverflowstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', '-ms-autohiding-scrollbar', 'scrollbar'; optional): **syntax**: `auto | none | scrollbar | -ms-autohiding-scrollbar`

**initial value**: `auto`
  - msoverflowx (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `visible`
  - msoverflowy (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'hidden', 'visible', 'scroll', 'overlay', 'clip', '-moz-hidden-unscrollable'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `visible | hidden | clip | scroll | auto`

**initial value**: `visible`
  - msscrollchaining (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'chained'; optional): **syntax**: `chained | none`

**initial value**: `chained`
  - msscrolllimitxmax (character | numeric; optional): **syntax**: `auto | <length>`

**initial value**: `auto`
  - msscrolllimitxmin (character | numeric; optional): **syntax**: `<length>`

**initial value**: `0`
  - msscrolllimitymax (character | numeric; optional): **syntax**: `auto | <length>`

**initial value**: `auto`
  - msscrolllimitymin (character | numeric; optional): **syntax**: `<length>`

**initial value**: `0`
  - msscrollrails (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'railed'; optional): **syntax**: `none | railed`

**initial value**: `railed`
  - msscrollsnappointsx (optional): **syntax**: `snapinterval( <length-percentage>, <length-percentage> ) | snaplist( <length-percentage># )`

**initial value**: `snapinterval(0px, 100\%)`
  - msscrollsnappointsy (optional): **syntax**: `snapinterval( <length-percentage>, <length-percentage> ) | snaplist( <length-percentage># )`

**initial value**: `snapinterval(0px, 100\%)`
  - msscrollsnaptype (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **syntax**: `none | proximity | mandatory`

**initial value**: `none`
  - msscrolltranslation (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'vertical-to-horizontal'; optional): **syntax**: `none | vertical-to-horizontal`

**initial value**: `none`
  - msscrollbar3dlightcolor (optional): **syntax**: `<color>`

**initial value**: depends on user agent
  - msscrollbararrowcolor (optional): **syntax**: `<color>`

**initial value**: `buttontext`
  - msscrollbarbasecolor (optional): **syntax**: `<color>`

**initial value**: depends on user agent
  - msscrollbardarkshadowcolor (optional): **syntax**: `<color>`

**initial value**: `threeddarkshadow`
  - msscrollbarfacecolor (optional): **syntax**: `<color>`

**initial value**: `threedface`
  - msscrollbarhighlightcolor (optional): **syntax**: `<color>`

**initial value**: `threedhighlight`
  - msscrollbarshadowcolor (optional): **syntax**: `<color>`

**initial value**: `threeddarkshadow`
  - msscrollbartrackcolor (optional): **syntax**: `<color>`

**initial value**: `scrollbar`
  - mstextautospace (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'ideograph-alpha', 'ideograph-numeric', 'ideograph-parenthesis', 'ideograph-space'; optional): **syntax**: `none | ideograph-alpha | ideograph-numeric | ideograph-parenthesis | ideograph-space`

**initial value**: `none`
  - mstextcombinehorizontal (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | all | [ digits <integer>? ]`

**initial value**: `none`
  - mstextoverflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**initial value**: `clip`
  - mstouchaction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2019.

**syntax**: `auto | none | [ [ pan-x | pan-left | pan-right ] || [ pan-y | pan-up | pan-down ] || pinch-zoom ] | manipulation`

**initial value**: `auto`
  - mstouchselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'grippers'; optional): **syntax**: `grippers | none`

**initial value**: `grippers`
  - mstransform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <transform-list>`

**initial value**: `none`
  - mstransformorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**initial value**: `50\% 50\% 0`
  - mstransitiondelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - mstransitionduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - mstransitionproperty (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <single-transition-property>#`

**initial value**: all
  - mstransitiontimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
  - msuserselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'text', 'element'; optional): **syntax**: `none | element | text`

**initial value**: `text`
  - mswordbreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'break-word', 'auto-phrase', 'break-all', 'keep-all'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `normal | break-all | keep-all | break-word | auto-phrase`

**initial value**: `normal`
  - mswrapflow (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'end', 'start', 'both', 'clear', 'maximum'; optional): **syntax**: `auto | both | start | end | maximum | clear`

**initial value**: `auto`
  - mswrapmargin (character | numeric; optional): **syntax**: `<length>`

**initial value**: `0`
  - mswrapthrough (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'wrap'; optional): **syntax**: `wrap | none`

**initial value**: `wrap`
  - mswritingmode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**initial value**: `horizontal-tb`
  - webkitaligncontent (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position>`

**initial value**: `normal`
  - webkitalignitems (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | stretch | <baseline-position> | [ <overflow-position>? <self-position> ] | anchor-center`

**initial value**: `normal`
  - webkitalignself (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `auto | normal | stretch | <baseline-position> | <overflow-position>? <self-position> | anchor-center`

**initial value**: `auto`
  - webkitanimationdelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - webkitanimationdirection (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-direction>#`

**initial value**: `normal`
  - webkitanimationduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ auto | <time [0s,∞]> ]#`

**initial value**: `0s`
  - webkitanimationfillmode (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-fill-mode>#`

**initial value**: `none`
  - webkitanimationiterationcount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-iteration-count>#`

**initial value**: `1`
  - webkitanimationname (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ none | <keyframes-name> ]#`

**initial value**: `none`
  - webkitanimationplaystate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-play-state>#`

**initial value**: `running`
  - webkitanimationtimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
  - webkitappearance (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'button', 'checkbox', 'listbox', 'menulist', 'meter', 'progress-bar', 'radio', 'searchfield', 'textarea', 'menulist-button', 'textfield', 'button-bevel', 'caret', 'listitem', 'menulist-text', 'menulist-textfield', '-apple-pay-button', 'default-button', 'inner-spin-button', 'media-controls-background', 'media-controls-fullscreen-background', 'media-current-time-display', 'media-enter-fullscreen-button', 'media-exit-fullscreen-button', 'media-fullscreen-button', 'media-mute-button', 'media-overlay-play-button', 'media-play-button', 'media-seek-back-button', 'media-seek-forward-button', 'media-slider', 'media-sliderthumb', 'media-time-remaining-display', 'media-toggle-closed-captions-button', 'media-volume-slider', 'media-volume-slider-container', 'media-volume-sliderthumb', 'progress-bar-value', 'push-button', 'searchfield-cancel-button', 'searchfield-decoration', 'searchfield-results-button', 'searchfield-results-decoration', 'slider-horizontal', 'slider-vertical', 'sliderthumb-horizontal', 'sliderthumb-vertical', 'square-button'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | button | button-bevel | caret | checkbox | default-button | inner-spin-button | listbox | listitem | media-controls-background | media-controls-fullscreen-background | media-current-time-display | media-enter-fullscreen-button | media-exit-fullscreen-button | media-fullscreen-button | media-mute-button | media-overlay-play-button | media-play-button | media-seek-back-button | media-seek-forward-button | media-slider | media-sliderthumb | media-time-remaining-display | media-toggle-closed-captions-button | media-volume-slider | media-volume-slider-container | media-volume-sliderthumb | menulist | menulist-button | menulist-text | menulist-textfield | meter | progress-bar | progress-bar-value | push-button | radio | searchfield | searchfield-cancel-button | searchfield-decoration | searchfield-results-button | searchfield-results-decoration | slider-horizontal | slider-vertical | sliderthumb-horizontal | sliderthumb-vertical | square-button | textarea | textfield | -apple-pay-button`

**initial value**: `none` (but this value is overridden in the user agent css)
  - webkitbackdropfilter (optional): since september 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | <filter-value-list>`

**initial value**: `none`
  - webkitbackfacevisibility (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'hidden', 'visible'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `visible | hidden`

**initial value**: `visible`
  - webkitbackgroundclip (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-clip>#`

**initial value**: `border-box`
  - webkitbackgroundorigin (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<visual-box>#`

**initial value**: `padding-box`
  - webkitbackgroundsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-size>#`

**initial value**: `auto auto`
  - webkitborderbeforecolor (optional): **syntax**: `<color>`

**initial value**: `currentcolor`
  - webkitborderbeforestyle (optional): **syntax**: `<'border-style'>`

**initial value**: `none`
  - webkitborderbeforewidth (character | numeric; optional): **syntax**: `<'border-width'>`

**initial value**: `medium`
  - webkitborderbottomleftradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
  - webkitborderbottomrightradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
  - webkitborderimageslice (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ <number [0,∞]> | <percentage [0,∞]> ]{1,4}  && fill?`

**initial value**: `100\%`
  - webkitbordertopleftradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
  - webkitbordertoprightradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
  - webkitboxdecorationbreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'clone', 'slice'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `slice | clone`

**initial value**: `slice`
  - webkitboxreflect (character | numeric; optional): the **`-webkit-box-reflect`** css property lets you reflect the content of an element in one specific direction.

**syntax**: `[ above | below | right | left ]? <length>? <image>?`

**initial value**: `none`
  - webkitboxshadow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <shadow>#`

**initial value**: `none`
  - webkitboxsizing (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `content-box | border-box`

**initial value**: `content-box`
  - webkitclippath (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<clip-source> | [ <basic-shape> || <geometry-box> ] | none`

**initial value**: `none`
  - webkitcolumncount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<integer> | auto`

**initial value**: `auto`
  - webkitcolumnfill (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `auto | balance`

**initial value**: `balance`
  - webkitcolumnrulecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - webkitcolumnrulestyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-style'>`

**initial value**: `none`
  - webkitcolumnrulewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'border-width'>`

**initial value**: `medium`
  - webkitcolumnspan (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'all'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `none | all`

**initial value**: `none`
  - webkitcolumnwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since november 2016.

**syntax**: `<length> | auto`

**initial value**: `auto`
  - webkitfilter (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2016.

**syntax**: `none | <filter-value-list>`

**initial value**: `none`
  - webkitflexbasis (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `content | <'width'>`

**initial value**: `auto`
  - webkitflexdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'column', 'column-reverse', 'row', 'row-reverse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `row | row-reverse | column | column-reverse`

**initial value**: `row`
  - webkitflexgrow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<number>`

**initial value**: `0`
  - webkitflexshrink (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<number>`

**initial value**: `1`
  - webkitflexwrap (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'nowrap', 'wrap', 'wrap-reverse'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `nowrap | wrap | wrap-reverse`

**initial value**: `nowrap`
  - webkitfontfeaturesettings (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `normal | <feature-tag-value>#`

**initial value**: `normal`
  - webkitfontkerning (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'none'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `auto | normal | none`

**initial value**: `auto`
  - webkitfontsmoothing (character | numeric; optional): the **`font-smooth`** css property controls the application of anti-aliasing when fonts are rendered.

**syntax**: `auto | never | always | <absolute-size> | <length>`

**initial value**: `auto`
  - webkitfontvariantligatures (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]`

**initial value**: `normal`
  - webkithyphenatecharacter (optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `auto | <string>`

**initial value**: `auto`
  - webkithyphens (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'manual'; optional): since september 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `none | manual | auto`

**initial value**: `manual`
  - webkitinitialletter (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `normal | [ <number> <integer>? ]`

**initial value**: `normal`
  - webkitjustifycontent (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ]`

**initial value**: `normal`
  - webkitlinebreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | loose | normal | strict | anywhere`

**initial value**: `auto`
  - webkitlineclamp (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <integer>`

**initial value**: `none`
  - webkitlogicalheight (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'width'>`

**initial value**: `auto`
  - webkitlogicalwidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'width'>`

**initial value**: `auto`
  - webkitmarginend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`
  - webkitmarginstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'margin-top'>`

**initial value**: `0`
  - webkitmaskattachment (optional): **syntax**: `<attachment>#`

**initial value**: `scroll`
  - webkitmaskboximageoutset (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <length> | <number> ]{1,4}`

**initial value**: `0`
  - webkitmaskboximagerepeat (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ stretch | repeat | round | space ]{1,2}`

**initial value**: `stretch`
  - webkitmaskboximageslice (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<number-percentage>{1,4} fill?`

**initial value**: `0`
  - webkitmaskboximagesource (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <image>`

**initial value**: `none`
  - webkitmaskboximagewidth (character | numeric; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `[ <length-percentage> | <number> | auto ]{1,4}`

**initial value**: `auto`
  - webkitmaskclip (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ <coord-box> | no-clip | border | padding | content | text ]#`

**initial value**: `border`
  - webkitmaskcomposite (optional): the **`-webkit-mask-composite`** property specifies the manner in which multiple mask images applied to the same element are composited with one another. mask images are composited in the opposite order that they are declared with the `-webkit-mask-image` property.

**syntax**: `<composite-style>#`

**initial value**: `source-over`
  - webkitmaskimage (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<mask-reference>#`

**initial value**: `none`
  - webkitmaskorigin (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ <coord-box> | border | padding | content ]#`

**initial value**: `padding`
  - webkitmaskposition (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<position>#`

**initial value**: `0\% 0\%`
  - webkitmaskpositionx (character | numeric; optional): the `-webkit-mask-position-x` css property sets the initial horizontal position of a mask image.

**syntax**: `[ <length-percentage> | left | center | right ]#`

**initial value**: `0\%`
  - webkitmaskpositiony (character | numeric; optional): the `-webkit-mask-position-y` css property sets the initial vertical position of a mask image.

**syntax**: `[ <length-percentage> | top | center | bottom ]#`

**initial value**: `0\%`
  - webkitmaskrepeat (optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<repeat-style>#`

**initial value**: `repeat`
  - webkitmaskrepeatx (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'no-repeat', 'repeat', 'round', 'space'; optional): the `-webkit-mask-repeat-x` property specifies whether and how a mask image is repeated (tiled) horizontally.

**syntax**: `repeat | no-repeat | space | round`

**initial value**: `repeat`
  - webkitmaskrepeaty (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'no-repeat', 'repeat', 'round', 'space'; optional): the `-webkit-mask-repeat-y` property sets whether and how a mask image is repeated (tiled) vertically.

**syntax**: `repeat | no-repeat | space | round`

**initial value**: `repeat`
  - webkitmasksize (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `<bg-size>#`

**initial value**: `auto auto`
  - webkitmaxinlinesize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'max-width'>`

**initial value**: `none`
  - webkitorder (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<integer>`

**initial value**: `0`
  - webkitoverflowscrolling (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'touch'; optional): **syntax**: `auto | touch`

**initial value**: `auto`
  - webkitpaddingend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`
  - webkitpaddingstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<'padding-top'>`

**initial value**: `0`
  - webkitperspective (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <length>`

**initial value**: `none`
  - webkitperspectiveorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<position>`

**initial value**: `50\% 50\%`
  - webkitprintcoloradjust (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'economy', 'exact'; optional): since may 2025, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `economy | exact`

**initial value**: `economy`
  - webkitrubyposition (optional): since december 2024, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ alternate || [ over | under ] ] | inter-character`

**initial value**: `alternate`
  - webkitscrollsnaptype (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2022.

**syntax**: `none | [ x | y | block | inline | both ] [ mandatory | proximity ]?`

**initial value**: `none`
  - webkitshapemargin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<length-percentage>`

**initial value**: `0`
  - webkittaphighlightcolor (optional): **`-webkit-tap-highlight-color`** is a non-standard css property that sets the color of the highlight that appears over a link while it's being tapped. the highlighting indicates to the user that their tap is being successfully recognized, and indicates which element they're tapping on.

**syntax**: `<color>`

**initial value**: `black`
  - webkittextcombine (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | all | [ digits <integer>? ]`

**initial value**: `none`
  - webkittextdecorationcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - webkittextdecorationline (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**initial value**: `none`
  - webkittextdecorationskip (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | [ objects || [ spaces | [ leading-spaces || trailing-spaces ] ] || edges || box-decoration ]`

**initial value**: `objects`
  - webkittextdecorationstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `solid | double | dotted | dashed | wavy`

**initial value**: `solid`
  - webkittextemphasiscolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - webkittextemphasisposition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `auto | [ over | under ] && [ right | left ]?`

**initial value**: `auto`
  - webkittextemphasisstyle (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `none | [ [ filled | open ] || [ dot | circle | double-circle | triangle | sesame ] ] | <string>`

**initial value**: `none`
  - webkittextfillcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2016.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - webkittextorientation (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'mixed', 'sideways', 'sideways-right', 'upright'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2020.

**syntax**: `mixed | upright | sideways`

**initial value**: `mixed`
  - webkittextsizeadjust (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | auto | <percentage>`

**initial value**: `auto` for smartphone browsers supporting inflation, `none` in other cases (and then not modifiable).
  - webkittextstrokecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<color>`

**initial value**: `currentcolor`
  - webkittextstrokewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<length>`

**initial value**: `0`
  - webkittextunderlineposition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | from-font | [ under || [ left | right ] ]`

**initial value**: `auto`
  - webkittouchcallout (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'default'; optional): the `-webkit-touch-callout` css property controls the display of the default callout shown when you touch and hold a touch target.

**syntax**: `default | none`

**initial value**: `default`
  - webkittransform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <transform-list>`

**initial value**: `none`
  - webkittransformorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**initial value**: `50\% 50\% 0`
  - webkittransformstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'flat', 'preserve-3d'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `flat | preserve-3d`

**initial value**: `flat`
  - webkittransitiondelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - webkittransitionduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
  - webkittransitionproperty (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <single-transition-property>#`

**initial value**: all
  - webkittransitiontimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
  - webkitusermodify (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'read-only', 'read-write', 'read-write-plaintext-only'; optional): **syntax**: `read-only | read-write | read-write-plaintext-only`

**initial value**: `read-only`
  - webkituserselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | text | none | all`

**initial value**: `auto`
  - webkitwritingmode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal-tb', 'sideways-lr', 'sideways-rl', 'vertical-lr', 'vertical-rl'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr`

**initial value**: `horizontal-tb`
  - mozanimation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation>#`
  - mozborderimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
  - mozcolumnrule (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`
  - mozcolumns (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-width'> || <'column-count'>`
  - mozoutlineradius (character | numeric; optional): **syntax**: `<outline-radius>{1,4} [ / <outline-radius>{1,4} ]?`
  - moztransition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-transition>#`
  - mscontentzoomlimit (optional): **syntax**: `<'-ms-content-zoom-limit-min'> <'-ms-content-zoom-limit-max'>`
  - mscontentzoomsnap (optional): **syntax**: `<'-ms-content-zoom-snap-type'> || <'-ms-content-zoom-snap-points'>`
  - msflex (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`
  - msscrolllimit (optional): **syntax**: `<'-ms-scroll-limit-x-min'> <'-ms-scroll-limit-y-min'> <'-ms-scroll-limit-x-max'> <'-ms-scroll-limit-y-max'>`
  - msscrollsnapx (optional): **syntax**: `<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-x'>`
  - msscrollsnapy (optional): **syntax**: `<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-y'>`
  - mstransition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-transition>#`
  - webkitanimation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation>#`
  - webkitborderbefore (character | numeric; optional): the **`-webkit-border-before`** css property is a shorthand property for setting the individual logical block start border property values in a single place in the style sheet.

**syntax**: `<'border-width'> || <'border-style'> || <color>`
  - webkitborderimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
  - webkitborderradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`
  - webkitcolumnrule (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>`
  - webkitcolumns (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<'column-width'> || <'column-count'>`
  - webkitflex (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]`
  - webkitflexflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<'flex-direction'> || <'flex-wrap'>`
  - webkitmask (character | numeric; optional): since december 2023, this feature works across the latest devices and browser versions. this feature might not work in older devices or browsers.

**syntax**: `[ <mask-reference> || <position> [ / <bg-size> ]? || <repeat-style> || [ <visual-box> | border | padding | content | text ] || [ <visual-box> | border | padding | content ] ]#`
  - webkitmaskboximage (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `<'mask-border-source'> || <'mask-border-slice'> [ / <'mask-border-width'>? [ / <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>`
  - webkittextemphasis (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2022.

**syntax**: `<'text-emphasis-style'> || <'text-emphasis-color'>`
  - webkittextstroke (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2017.

**syntax**: `<length> || <color>`
  - webkittransition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-transition>#`
  - boxalign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): the **`box-align`** css property specifies how an element aligns its contents across its layout in a perpendicular direction. the effect of the property is only visible if there is extra space in the box.

**syntax**: `start | center | end | baseline | stretch`

**initial value**: `stretch`
@,deprecated
  - boxdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): the **`box-direction`** css property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**syntax**: `normal | reverse | inherit`

**initial value**: `normal`
@,deprecated
  - boxflex (optional): the **`-moz-box-flex`** and **`-webkit-box-flex`** css properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**syntax**: `<number>`

**initial value**: `0`
@,deprecated
  - boxflexgroup (optional): the **`box-flex-group`** css property assigns the flexbox's child elements to a flex group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - boxlines (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): the **`box-lines`** css property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**syntax**: `single | multiple`

**initial value**: `single`
@,deprecated
  - boxordinalgroup (optional): the **`box-ordinal-group`** css property assigns the flexbox's child elements to an ordinal group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - boxorient (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): the **`box-orient`** css property sets whether an element lays out its contents horizontally or vertically.

**syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**initial value**: `inline-axis`
@,deprecated
  - boxpack (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): the **`-moz-box-pack`** and **`-webkit-box-pack`** css properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. the effect of this is only visible if there is extra space in the box.

**syntax**: `start | center | end | justify`

**initial value**: `start`
@,deprecated
  - clip (optional): the **`clip`** css property defines a visible portion of an element. the `clip` property applies only to absolutely positioned elements — that is, elements with `position:absolute` or `position:fixed`.

**syntax**: `<shape> | auto`

**initial value**: `auto`
@,deprecated
  - fontstretch (optional): the **`font-stretch`** css property selects a normal, condensed, or expanded face from a font.

**syntax**: `<font-stretch-absolute>`

**initial value**: `normal`
@,deprecated
  - gridcolumngap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage>`

**initial value**: `0`
@,deprecated
  - gridgap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<'grid-row-gap'> <'grid-column-gap'>?`
@,deprecated
  - gridrowgap (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since october 2017.

**syntax**: `<length-percentage>`

**initial value**: `0`
@,deprecated
  - imemode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'active', 'disabled', 'inactive'; optional): **syntax**: `auto | normal | active | inactive | disabled`

**initial value**: `auto`
@,deprecated
  - insetarea (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | <position-area>`

**initial value**: `none`
@,deprecated
  - offsetblock (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>{1,2}`
@,deprecated
  - offsetblockend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`
@,deprecated
  - offsetblockstart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`
@,deprecated
  - offsetinline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>{1,2}`
@,deprecated
  - offsetinlineend (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`
@,deprecated
  - offsetinlinestart (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since april 2021.

**syntax**: `<'top'>`

**initial value**: `auto`
@,deprecated
  - pagebreakafter (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'always', 'avoid', 'recto', 'verso'; optional): the **`page-break-after`** css property adjusts page breaks _after_ the current element.

**syntax**: `auto | always | avoid | left | right | recto | verso`

**initial value**: `auto`
@,deprecated
  - pagebreakbefore (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'always', 'avoid', 'recto', 'verso'; optional): the **`page-break-before`** css property adjusts page breaks _before_ the current element.

**syntax**: `auto | always | avoid | left | right | recto | verso`

**initial value**: `auto`
@,deprecated
  - pagebreakinside (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'avoid'; optional): the **`page-break-inside`** css property adjusts page breaks _inside_ the current element.

**syntax**: `auto | avoid`

**initial value**: `auto`
@,deprecated
  - positiontryoptions (optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `none | [ [<dashed-ident> || <try-tactic>] | <'position-area'> ]#`

**initial value**: `none`
@,deprecated
  - scrollsnapcoordinate (character | numeric; optional): **syntax**: `none | <position>#`

**initial value**: `none`
@,deprecated
  - scrollsnapdestination (character | numeric; optional): **syntax**: `<position>`

**initial value**: `0px 0px`
@,deprecated
  - scrollsnappointsx (optional): **syntax**: `none | repeat( <length-percentage> )`

**initial value**: `none`
@,deprecated
  - scrollsnappointsy (optional): **syntax**: `none | repeat( <length-percentage> )`

**initial value**: `none`
@,deprecated
  - scrollsnaptypex (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **syntax**: `none | mandatory | proximity`

**initial value**: `none`
@,deprecated
  - scrollsnaptypey (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'mandatory', 'proximity'; optional): **syntax**: `none | mandatory | proximity`

**initial value**: `none`
@,deprecated
  - khtmlboxalign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): the **`box-align`** css property specifies how an element aligns its contents across its layout in a perpendicular direction. the effect of the property is only visible if there is extra space in the box.

**syntax**: `start | center | end | baseline | stretch`

**initial value**: `stretch`
@,deprecated
  - khtmlboxdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): the **`box-direction`** css property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**syntax**: `normal | reverse | inherit`

**initial value**: `normal`
@,deprecated
  - khtmlboxflex (optional): the **`-moz-box-flex`** and **`-webkit-box-flex`** css properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**syntax**: `<number>`

**initial value**: `0`
@,deprecated
  - khtmlboxflexgroup (optional): the **`box-flex-group`** css property assigns the flexbox's child elements to a flex group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - khtmlboxlines (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): the **`box-lines`** css property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**syntax**: `single | multiple`

**initial value**: `single`
@,deprecated
  - khtmlboxordinalgroup (optional): the **`box-ordinal-group`** css property assigns the flexbox's child elements to an ordinal group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - khtmlboxorient (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): the **`box-orient`** css property sets whether an element lays out its contents horizontally or vertically.

**syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**initial value**: `inline-axis`
@,deprecated
  - khtmlboxpack (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): the **`-moz-box-pack`** and **`-webkit-box-pack`** css properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. the effect of this is only visible if there is extra space in the box.

**syntax**: `start | center | end | justify`

**initial value**: `start`
@,deprecated
  - khtmllinebreak (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'strict', 'anywhere', 'loose'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2020.

**syntax**: `auto | loose | normal | strict | anywhere`

**initial value**: `auto`
@,deprecated
  - khtmlopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<opacity-value>`

**initial value**: `1`
@,deprecated
  - khtmluserselect (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'all', 'text', '-moz-none'; optional): this feature is not baseline because it does not work in some of the most widely-used browsers.

**syntax**: `auto | text | none | all`

**initial value**: `auto`
@,deprecated
  - mozbackgroundclip (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-clip>#`

**initial value**: `border-box`
@,deprecated
  - mozbackgroundorigin (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<visual-box>#`

**initial value**: `padding-box`
@,deprecated
  - mozbackgroundsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-size>#`

**initial value**: `auto auto`
@,deprecated
  - mozborderradius (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?`
@,deprecated
  - mozborderradiusbottomleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
@,deprecated
  - mozborderradiusbottomright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
@,deprecated
  - mozborderradiustopleft (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
@,deprecated
  - mozborderradiustopright (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<length-percentage [0,∞]>{1,2}`

**initial value**: `0`
@,deprecated
  - mozboxalign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): the **`box-align`** css property specifies how an element aligns its contents across its layout in a perpendicular direction. the effect of the property is only visible if there is extra space in the box.

**syntax**: `start | center | end | baseline | stretch`

**initial value**: `stretch`
@,deprecated
  - mozboxdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): the **`box-direction`** css property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**syntax**: `normal | reverse | inherit`

**initial value**: `normal`
@,deprecated
  - mozboxflex (optional): the **`-moz-box-flex`** and **`-webkit-box-flex`** css properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**syntax**: `<number>`

**initial value**: `0`
@,deprecated
  - mozboxordinalgroup (optional): the **`box-ordinal-group`** css property assigns the flexbox's child elements to an ordinal group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - mozboxorient (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): the **`box-orient`** css property sets whether an element lays out its contents horizontally or vertically.

**syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**initial value**: `inline-axis`
@,deprecated
  - mozboxpack (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): the **`-moz-box-pack`** and **`-webkit-box-pack`** css properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. the effect of this is only visible if there is extra space in the box.

**syntax**: `start | center | end | justify`

**initial value**: `start`
@,deprecated
  - mozboxshadow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `none | <shadow>#`

**initial value**: `none`
@,deprecated
  - mozcolumncount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `<integer> | auto`

**initial value**: `auto`
@,deprecated
  - mozcolumnfill (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'balance'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2017.

**syntax**: `auto | balance`

**initial value**: `balance`
@,deprecated
  - mozfloatedge (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'border-box', 'content-box', 'padding-box', 'margin-box'; optional): the non-standard **`-moz-float-edge`** css property specifies whether the height and width properties of the element include the margin, border, or padding thickness.

**syntax**: `border-box | content-box | margin-box | padding-box`

**initial value**: `content-box`
@,deprecated
  - mozforcebrokenimageicon (optional): the **`-moz-force-broken-image-icon`** extended css property can be used to force the broken image icon to be shown even when a broken image has an `alt` attribute.

**syntax**: `0 | 1`

**initial value**: `0`
@,deprecated
  - mozopacity (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<opacity-value>`

**initial value**: `1`
@,deprecated
  - mozoutline (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since march 2023.

**syntax**: `<'outline-width'> || <'outline-style'> || <'outline-color'>`
@,deprecated
  - mozoutlinecolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <color>`

**initial value**: `auto`
@,deprecated
  - mozoutlinestyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge', 'solid'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `auto | <outline-line-style>`

**initial value**: `none`
@,deprecated
  - mozoutlinewidth (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<line-width>`

**initial value**: `medium`
@,deprecated
  - moztextalignlast (a value equal to: 'left', 'right', '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'center', 'end', 'start', 'justify'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2022.

**syntax**: `auto | start | end | left | right | center | justify`

**initial value**: `auto`
@,deprecated
  - moztextdecorationcolor (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<color>`

**initial value**: `currentcolor`
@,deprecated
  - moztextdecorationline (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `none | [ underline || overline || line-through || blink ] | spelling-error | grammar-error`

**initial value**: `none`
@,deprecated
  - moztextdecorationstyle (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'dashed', 'dotted', 'double', 'solid', 'wavy'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `solid | double | dotted | dashed | wavy`

**initial value**: `solid`
@,deprecated
  - moztransitiondelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
@,deprecated
  - moztransitionduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
@,deprecated
  - moztransitionproperty (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <single-transition-property>#`

**initial value**: all
@,deprecated
  - moztransitiontimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
@,deprecated
  - mozuserfocus (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'none', 'ignore', 'select-after', 'select-all', 'select-before', 'select-menu', 'select-same'; optional): the **`-moz-user-focus`** css property is used to indicate whether an element can have the focus.

**syntax**: `ignore | normal | select-after | select-before | select-menu | select-same | select-all | none`

**initial value**: `none`
@,deprecated
  - mozuserinput (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'none', 'disabled', 'enabled'; optional): in mozilla applications, **`-moz-user-input`** determines if an element will accept user input.

**syntax**: `auto | none | enabled | disabled`

**initial value**: `auto`
@,deprecated
  - msimemode (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'normal', 'active', 'disabled', 'inactive'; optional): **syntax**: `auto | normal | active | inactive | disabled`

**initial value**: `auto`
@,deprecated
  - oanimation (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation>#`
@,deprecated
  - oanimationdelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
@,deprecated
  - oanimationdirection (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-direction>#`

**initial value**: `normal`
@,deprecated
  - oanimationduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ auto | <time [0s,∞]> ]#`

**initial value**: `0s`
@,deprecated
  - oanimationfillmode (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-fill-mode>#`

**initial value**: `none`
@,deprecated
  - oanimationiterationcount (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-iteration-count>#`

**initial value**: `1`
@,deprecated
  - oanimationname (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ none | <keyframes-name> ]#`

**initial value**: `none`
@,deprecated
  - oanimationplaystate (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-animation-play-state>#`

**initial value**: `running`
@,deprecated
  - oanimationtimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
@,deprecated
  - obackgroundsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<bg-size>#`

**initial value**: `auto auto`
@,deprecated
  - oborderimage (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>`
@,deprecated
  - oobjectfit (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'none', 'contain', 'cover', 'fill', 'scale-down'; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `fill | contain | cover | none | scale-down`

**initial value**: `fill`
@,deprecated
  - oobjectposition (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since january 2020.

**syntax**: `<position>`

**initial value**: `50\% 50\%`
@,deprecated
  - otabsize (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since august 2021.

**syntax**: `<integer> | <length>`

**initial value**: `8`
@,deprecated
  - otextoverflow (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since july 2015.

**syntax**: `[ clip | ellipsis | <string> ]{1,2}`

**initial value**: `clip`
@,deprecated
  - otransform (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <transform-list>`

**initial value**: `none`
@,deprecated
  - otransformorigin (character | numeric; optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `[ <length-percentage> | left | center | right | top | bottom ] | [ [ <length-percentage> | left | center | right ] && [ <length-percentage> | top | center | bottom ] ] <length>?`

**initial value**: `50\% 50\% 0`
@,deprecated
  - otransition (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<single-transition>#`
@,deprecated
  - otransitiondelay (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
@,deprecated
  - otransitionduration (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<time>#`

**initial value**: `0s`
@,deprecated
  - otransitionproperty (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `none | <single-transition-property>#`

**initial value**: all
@,deprecated
  - otransitiontimingfunction (optional): this feature is well established and works across many devices and browser versions. it’s been available across browsers since september 2015.

**syntax**: `<easing-function>#`

**initial value**: `ease`
@,deprecated
  - webkitboxalign (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'stretch', 'center', 'end', 'start', 'baseline'; optional): the **`box-align`** css property specifies how an element aligns its contents across its layout in a perpendicular direction. the effect of the property is only visible if there is extra space in the box.

**syntax**: `start | center | end | baseline | stretch`

**initial value**: `stretch`
@,deprecated
  - webkitboxdirection (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'normal', 'reverse'; optional): the **`box-direction`** css property specifies whether a box lays out its contents normally (from the top or left edge), or in reverse (from the bottom or right edge).

**syntax**: `normal | reverse | inherit`

**initial value**: `normal`
@,deprecated
  - webkitboxflex (optional): the **`-moz-box-flex`** and **`-webkit-box-flex`** css properties specify how a `-moz-box` or `-webkit-box` grows to fill the box that contains it, in the direction of the containing box's layout.

**syntax**: `<number>`

**initial value**: `0`
@,deprecated
  - webkitboxflexgroup (optional): the **`box-flex-group`** css property assigns the flexbox's child elements to a flex group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - webkitboxlines (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'multiple', 'single'; optional): the **`box-lines`** css property determines whether the box may have a single or multiple lines (rows for horizontally oriented boxes, columns for vertically oriented boxes).

**syntax**: `single | multiple`

**initial value**: `single`
@,deprecated
  - webkitboxordinalgroup (optional): the **`box-ordinal-group`** css property assigns the flexbox's child elements to an ordinal group.

**syntax**: `<integer>`

**initial value**: `1`
@,deprecated
  - webkitboxorient (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'horizontal', 'vertical', 'block-axis', 'inline-axis'; optional): the **`box-orient`** css property sets whether an element lays out its contents horizontally or vertically.

**syntax**: `horizontal | vertical | inline-axis | block-axis | inherit`

**initial value**: `inline-axis`
@,deprecated
  - webkitboxpack (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'center', 'end', 'start', 'justify'; optional): the **`-moz-box-pack`** and **`-webkit-box-pack`** css properties specify how a `-moz-box` or `-webkit-box` packs its contents in the direction of its layout. the effect of this is only visible if there is extra space in the box.

**syntax**: `start | center | end | justify`

**initial value**: `start`
@,deprecated
  - colorinterpolation (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'linearrgb', 'srgb'; optional)
  - colorrendering (a value equal to: '-moz-initial', 'inherit', 'initial', 'revert', 'revert-layer', 'unset', 'auto', 'optimizespeed', 'optimizequality'; optional)
  - glyphorientationvertical (optional). CSS styles to apply to the root container element}

\item{supportsPopout}{Logical. If left undefined will do simple check based on userAgent}

\item{useStateForModel}{Logical. Flag that we should use internal state to manage the layout. If the layout is not being
used by dash anywhere (for example, saving and re-hydrating the layout), it is more efficient
to use the internal state (as this limits the number of round trips between JSON
and the Model object).

WARNING: If you set this, do not expect the dash property `model` to reflect the current
state of the layout!}
}

\value{named list of JSON elements corresponding to React.js properties and their values}

