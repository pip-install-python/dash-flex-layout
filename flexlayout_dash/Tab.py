# AUTO GENERATED FILE - DO NOT EDIT

import typing  # noqa: F401
from typing_extensions import TypedDict, NotRequired, Literal # noqa: F401
from dash.development.base_component import Component, _explicitize_args
try:
    from dash.types import NumberType  # noqa: F401
except ImportError:
    # Backwards compatibility for dash<=4.1.0
    if typing.TYPE_CHECKING:
        raise
    NumberType = typing.Union[  # noqa: F401
        typing.SupportsFloat, typing.SupportsInt, typing.SupportsComplex
    ]

ComponentSingleType = typing.Union[str, int, float, Component, None]
ComponentType = typing.Union[
    ComponentSingleType,
    typing.Sequence[ComponentSingleType],
]


class Tab(Component):
    """A Tab component.
This is a simple component that holds content to be rendered within a Tab.
Takes an ID that corresponds to a particular tab in the layout.

Keyword arguments:

- children (a list of or a singular dash component, string or number; optional):
    Children to render within Tab.

- id (string; required):
    Unique ID to identify this component in Dash callbacks."""
    _children_props: typing.List[str] = []
    _base_nodes = ['children']
    _namespace = 'flexlayout_dash'
    _type = 'Tab'


    def __init__(
        self,
        children: typing.Optional[ComponentType] = None,
        id: typing.Optional[typing.Union[str, dict]] = None,
        **kwargs
    ):
        self._prop_names = ['children', 'id']
        self._valid_wildcard_attributes =            []
        self.available_properties = ['children', 'id']
        self.available_wildcard_properties =            []
        _explicit_args = kwargs.pop('_explicit_args')
        _locals = locals()
        _locals.update(kwargs)  # For wildcard attrs and excess named props
        args = {k: _locals[k] for k in _explicit_args if k != 'children'}

        for k in ['id']:
            if k not in args:
                raise TypeError(
                    'Required argument `' + k + '` was not specified.')

        super(Tab, self).__init__(children=children, **args)

setattr(Tab, "__init__", _explicitize_args(Tab.__init__))
