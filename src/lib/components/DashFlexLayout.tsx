import React, { useState, useEffect, useMemo, useCallback, useRef } from "react";
import ReactDOM from "react-dom";
import * as CaplinFlexLayout from "flexlayout-react";
import { IJsonModel, TabNode, Layout, Model, ITabRenderValues } from "flexlayout-react";
import { renderDashComponent } from "dash-extensions-js";

// Import FlexLayout styles and our custom theme styles
import "flexlayout-react/style/light.css";
import "../styles/theme.css";
import { isDash3, getChildLayout } from "../utils/dash3";

type Props = {
  /**
   * Unique ID to identify this component in Dash callbacks.
   */
  id?: string;

  /**
   * Update props to trigger callbacks.
   */
  setProps?: (props: Record<string, any>) => void;

  /**
   * The tab font (overrides value in css).
   * Example: font={{size:"12px", style:"italic"}}
   */
  font?: any;

  /**
   * If left undefined will do simple check based on userAgent
   */
  supportsPopout?: boolean;

  /**
   * URL of popout window relative to origin, defaults to popout.html
   */
  popoutURL?: string;

  /**
   * Boolean value, defaults to false, resize tabs as splitters are dragged.
   * Warning: this can cause resizing to become choppy when tabs are slow to draw
   */
  realtimeResize?: boolean;

  /**
   * Model layout.
   */
  model: IJsonModel;

  /**
   * List of children to be rendered. Children are allocated to their respective tab
   * based on the ID of the element.
   *
   * WARNING: There is no validation done on whether the children here will be rendered in any tab.
   * If there is no matching tab for a particular ID, that element will be silently ignored in
   * rendering (although callbacks will still be applied).
   */
  children: React.ReactNode;

  /**
   * Map of headers to render for each tab. Uses the `onRenderTab` function to override
   * the default headers, where a custom header mapping is supplied.
   *
   * Note: where possible, it is likely better to use classes to style the headers, rather than
   * using this prop.
   */
  headers?: { [key: string]: React.ReactNode };

  /**
   * Flag that we should use internal state to manage the layout. If the layout is not being
   * used by dash anywhere (for example, saving and re-hydrating the layout), it is more efficient
   * to use the internal state (as this limits the number of round trips between JSON
   * and the Model object).
   *
   * WARNING: If you set this, do not expect the dash property `model` to reflect the current
   * state of the layout!
   */
  useStateForModel?: boolean;

  /**
   * Debug mode flag
   */
  debugMode?: boolean;

  /**
   * Current color scheme, automatically detected from Mantine theme
   * If not specified, will try to auto-detect from HTML data-mantine-color-scheme
   */
  colorScheme?: 'light' | 'dark';

  /**
   * CSS styles to apply to the root container element
   */
  style?: React.CSSProperties;

  /**
   * Loading state.
   */
  loading_state?: {
    is_loading: boolean;
    component_name: string;
    prop_name: string;
  };
};

/**
 * Helper to extract ID from a child element (Dash 3 compatible)
 */
const getChildId = (child: any): string | null => {
  if (!child?.props) return child?.key || null;

  // Dash 3: use componentPath to get layout
  if (isDash3() && child.props.componentPath) {
    try {
      const layout = getChildLayout(child);
      if (layout?.props?.id) return layout.props.id;
    } catch (e) {
      // Fall through to other methods
    }
  }

  // Dash 2: use _dashprivate_layout
  if (child.props._dashprivate_layout?.props?.id) {
    return child.props._dashprivate_layout.props.id;
  }

  // Direct id prop
  if (child.props.id) return child.props.id;

  // Key-based fallback
  return child.key || null;
};

/**
 * Check if a child matches a given tab ID
 */
const idMatches = (child: any, id: string): boolean => {
  const childId = getChildId(child);
  return childId === id;
};

/**
 * DashFlexLayout is a wrapper around FlexLayout-React that provides
 * flexible docking windows for Dash applications.
 *
 * Features:
 * - Dockable, resizable, and floatable window panels
 * - Drag-and-drop tab management
 * - Seamless Mantine theme integration (light/dark mode)
 * - Dash 2 and Dash 3 compatibility
 */
const DashFlexLayout = ({
  id,
  model,
  children,
  headers,
  setProps,
  useStateForModel = false,
  popoutURL = "/assets/popout.html",
  colorScheme,
  style,
  loading_state,
  debugMode = false,
  ...restProps
}: Props) => {
  // Track current color scheme
  const [currentTheme, setCurrentTheme] = useState<'light' | 'dark'>(
    colorScheme || (typeof document !== 'undefined' &&
      document.documentElement.getAttribute('data-mantine-color-scheme') === 'dark'
        ? 'dark'
        : 'light')
  );

  // Model state for internal management
  const [modelState, setModelState] = useState(() => Model.fromJson(model));
  const [currentModel, setCurrentModel] = useState<Model | null>(null);

  // Track mounted tab containers for portal rendering
  const tabContainersRef = useRef<Map<string, HTMLDivElement>>(new Map());

  // Force re-render counter - incremented when we need to update portals
  const [renderKey, setRenderKey] = useState(0);

  // Store children in ref for stable access
  const childrenRef = useRef<React.ReactNode>(children);
  childrenRef.current = children;

  // Listen to Mantine theme changes
  useEffect(() => {
    if (typeof document === 'undefined') return;

    const detectTheme = () => {
      const htmlEl = document.documentElement;
      const theme = htmlEl.getAttribute('data-mantine-color-scheme') as 'light' | 'dark';
      if (theme && theme !== currentTheme) {
        setCurrentTheme(theme);
      }
    };

    detectTheme();

    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (
          mutation.type === 'attributes' &&
          mutation.attributeName === 'data-mantine-color-scheme'
        ) {
          detectTheme();
        }
      });
    });

    observer.observe(document.documentElement, { attributes: true });

    return () => {
      observer.disconnect();
    };
  }, [currentTheme]);

  // Handle model updates
  useEffect(() => {
    const baseModel = setProps && !useStateForModel
      ? Model.fromJson(model)
      : modelState;
    setCurrentModel(baseModel);
  }, [model, modelState, setProps, useStateForModel]);

  // Model change handler
  const onModelChange = useCallback((updatedModel: Model) => {
    if (setProps && !useStateForModel) {
      setProps({ model: updatedModel.toJson() });
    } else {
      setModelState(updatedModel);
    }
  }, [setProps, useStateForModel]);

  // Tab header renderer
  const onRenderTab = useCallback((
    node: TabNode,
    renderValues: ITabRenderValues
  ) => {
    if (headers && headers[node.getId()]) {
      const header = headers[node.getId()];
      if (React.isValidElement(header) && (header as any).props?.namespace) {
        renderValues.content = renderDashComponent(header);
      } else {
        renderValues.content = header;
      }
    }
  }, [headers]);

  /**
   * Factory function - creates portal containers for each tab
   * Instead of rendering children directly (which causes stale closure issues),
   * we render empty containers that will receive content via React portals.
   */
  const factory = useCallback((node: CaplinFlexLayout.TabNode) => {
    const tabId = node.getId();

    return (
      <TabPortalContainer
        key={`portal-container-${tabId}`}
        tabId={tabId}
        onMount={(container) => {
          tabContainersRef.current.set(tabId, container);
          // Trigger re-render to create portals
          setRenderKey(k => k + 1);
        }}
        onUnmount={() => {
          tabContainersRef.current.delete(tabId);
        }}
      />
    );
  }, []);

  // Build portals for all children into their respective tab containers
  const childPortals = useMemo(() => {
    const portals: React.ReactNode[] = [];
    const childArray = React.Children.toArray(childrenRef.current);

    childArray.forEach((child, index) => {
      const childId = getChildId(child);
      if (!childId) return;

      const container = tabContainersRef.current.get(childId);
      if (container) {
        portals.push(
          ReactDOM.createPortal(
            <div key={`portal-content-${childId}`} style={{ height: '100%', width: '100%' }}>
              {child}
            </div>,
            container
          )
        );
      }
    });

    return portals;
  }, [renderKey, children]); // Re-compute when containers mount or children change

  // Loading state
  if (!currentModel) {
    return <div className="dash-flex-layout-loading" style={style}>Loading layout...</div>;
  }

  return (
    <div className={`dash-dock-container dash-dock-${currentTheme}`} style={style}>
      <Layout
        model={currentModel}
        factory={factory}
        onModelChange={onModelChange}
        onRenderTab={onRenderTab}
        popoutURL={popoutURL}
        {...restProps}
      />
      {/* Render children via portals into their tab containers */}
      {childPortals}
    </div>
  );
};

/**
 * TabPortalContainer - A simple container component that registers itself
 * for portal rendering when mounted.
 */
interface TabPortalContainerProps {
  tabId: string;
  onMount: (container: HTMLDivElement) => void;
  onUnmount: () => void;
}

const TabPortalContainer: React.FC<TabPortalContainerProps> = React.memo(({
  tabId,
  onMount,
  onUnmount
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  // Store callbacks in refs to avoid dependency changes triggering re-renders
  const onMountRef = useRef(onMount);
  const onUnmountRef = useRef(onUnmount);

  // Keep refs up to date
  onMountRef.current = onMount;
  onUnmountRef.current = onUnmount;

  useEffect(() => {
    if (containerRef.current) {
      onMountRef.current(containerRef.current);
    }

    return () => {
      onUnmountRef.current();
    };
  }, []); // Empty dependency array - only run on mount/unmount

  return (
    <div
      ref={containerRef}
      data-tab-id={tabId}
      style={{ height: '100%', width: '100%' }}
    />
  );
});

TabPortalContainer.displayName = 'TabPortalContainer';

export default DashFlexLayout;