# AUTO GENERATED FILE - DO NOT EDIT

#' @export
dashFlexLayout <- function(children=NULL, id=NULL, colorScheme=NULL, debugMode=NULL, font=NULL, headers=NULL, loading_state=NULL, model=NULL, popoutURL=NULL, realtimeResize=NULL, style=NULL, supportsPopout=NULL, useStateForModel=NULL) {
    
    props <- list(children=children, id=id, colorScheme=colorScheme, debugMode=debugMode, font=font, headers=headers, loading_state=loading_state, model=model, popoutURL=popoutURL, realtimeResize=realtimeResize, style=style, supportsPopout=supportsPopout, useStateForModel=useStateForModel)
    if (length(props) > 0) {
        props <- props[!vapply(props, is.null, logical(1))]
    }
    component <- list(
        props = props,
        type = 'DashFlexLayout',
        namespace = 'dash_flex_layout',
        propNames = c('children', 'id', 'colorScheme', 'debugMode', 'font', 'headers', 'loading_state', 'model', 'popoutURL', 'realtimeResize', 'style', 'supportsPopout', 'useStateForModel'),
        package = 'dashFlexLayout'
        )

    structure(component, class = c('dash_component', 'list'))
}
