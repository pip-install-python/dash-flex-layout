import importlib
import inspect
import re

from markdown2dash.src.directives.kwargs import Kwargs as KwargsBase


def convert_docstring_to_dict(docstring):
    """Parse a numpy-style ``Parameters\n----------`` docstring into a list of
    ``{name, type, description}`` dicts."""
    lines: list[str] = docstring.split("----------\n")[-1].split("\n")

    params = []
    new_param = None
    for line in lines:
        if not line.startswith("    "):
            if new_param is not None:
                params.append(new_param)
            name, type = line.split(": ", 1)
            new_param = {"name": name, "type": type, "description": ""}
        else:
            new_param["description"] += " " + line.strip()
    params.append(new_param)

    return params


def convert_dash_docstring_to_dict(docstring):
    """Parse a Dash-generated ``Keyword arguments:`` docstring into a list of
    ``{name, type, description}`` dicts.

    Dash component classes document props as::

        Keyword arguments:

        - model (dict; required):
            Model layout.

        - useStateForModel (boolean; default False):
            Flag that we should use internal state ...

    The numpy-style parser the boilerplate ships only understands
    ``Parameters\n----------`` blocks, so Dash components (whose docstrings use
    the format above) would otherwise render an empty table.
    """
    if "Keyword arguments:" in docstring:
        docstring = docstring.split("Keyword arguments:", 1)[1]

    params = []
    # Top-level props start with "- " at column 0; nested dict sub-fields are
    # indented, so the lookahead on a non-indented "- " keeps them grouped into
    # their parent's description rather than splitting them out.
    for entry in re.split(r"\n(?=- )", docstring):
        entry = entry.strip()
        match = re.match(r"^- ([A-Za-z_][\w-]*) \((.*?)\):\s*(.*)$", entry, re.DOTALL)
        if not match:
            continue
        name, type_, description = match.group(1), match.group(2), match.group(3)
        description = " ".join(description.split())
        if len(description) > 240:
            description = description[:237].rstrip() + "..."
        params.append({"name": name, "type": type_, "description": description})

    return params


class Kwargs(KwargsBase):

    def hook(self, md, state):
        sections = []

        for tok in state.tokens:
            if tok["type"] == self.block_name:
                sections.append(tok)

        for section in sections:
            attrs = section["attrs"]

            # Parse the component specification (e.g., "dmc.Button" or
            # "flexlayout_dash.DashFlexLayout").
            component_spec = attrs["title"]

            # Common package name mappings
            package_map = {
                "dmc": "dash_mantine_components",
                "html": "dash.html",
                "dcc": "dash.dcc",
                "dash": "dash",
            }

            if "." in component_spec:
                package_abbr, component_name = component_spec.rsplit(".", 1)
                package = package_map.get(package_abbr, package_abbr)
            else:
                package = attrs.pop("library", "dash_mantine_components")
                component_name = component_spec

            try:
                imported = importlib.import_module(package)
                component = getattr(imported, component_name)
                docstring = inspect.getdoc(component) or ""

                if "----------" in docstring:
                    section_text = docstring.split("----------\n")[-1]
                    attrs["kwargs"] = convert_docstring_to_dict(section_text)
                elif "Keyword arguments:" in docstring:
                    # Dash-generated components (incl. flexlayout_dash, DMC).
                    attrs["kwargs"] = convert_dash_docstring_to_dict(docstring)
                else:
                    attrs["kwargs"] = []
            except (ModuleNotFoundError, AttributeError, Exception):
                attrs["kwargs"] = []
