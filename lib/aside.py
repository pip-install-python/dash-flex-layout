"""Which pages render the right-hand aside (item 16, 2026-08-30).

The AppShell reserves the aside column on EVERY page; only pages that
render a `.. toc::` fill it. Without this, /changelog and the admin pages
render inside the docs column with an empty right gutter. This registry
lets the shell collapse the aside where nothing would fill it —
pages/markdown.py records every endpoint whose Markdown carries the
directive; everything else (home, changelog, api, admin) is full width.
"""
from __future__ import annotations

ASIDE_PATHS: set[str] = set()

ASIDE_WIDTH = 280
ASIDE_BREAKPOINT = "xl"


def register(path: str) -> None:
    ASIDE_PATHS.add(path)


def has_aside(pathname: str | None) -> bool:
    return (pathname or "/") in ASIDE_PATHS


def aside_config(pathname: str | None) -> dict:
    """The AppShell `aside` prop for this pathname."""
    return {
        "width": ASIDE_WIDTH,
        "breakpoint": ASIDE_BREAKPOINT,
        "collapsed": {"desktop": not has_aside(pathname), "mobile": True},
    }
