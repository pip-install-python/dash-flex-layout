#!/usr/bin/env python3
"""Count the fleet-class traps in a `.claude/CLAUDE.md` traps section.

1.6.44 item 14 (emojimart 166e33a). A fork's traps section can sit fifteen
entries behind the template's — 7 against 22 on emojimart, whose HEAD trap
still carried the diagnosis 1.6.32 had corrected. The kit is contract-class,
so the sync never copied it, and nothing printed the gap.

This prints the PAIR: `fork N / template M` plus the titles the fork is
missing.

ADAPTED FOR A FORK. On the template, "the template kit" is the repo's own
`.claude/CLAUDE.md`. Here it is a DIFFERENT repository, so there is no
sensible default for it — this script takes the template path as an argument
and, given none, reports only this repo's own count rather than silently
comparing the fork against itself and printing a reassuring `N / N`.

    python3 scripts/kit_traps.py
        # this repo's trap count, nothing compared

    python3 scripts/kit_traps.py ../dash-documentation-boilerplate/.claude/CLAUDE.md
        # this repo vs that template

    python3 scripts/kit_traps.py <template_kit> <fork_kit>
        # any pair, for an ops seat sweeping the fleet

Matching is by the first sentence of each entry, lower-cased and squeezed —
NOT by exact text, because a fork is expected to have merged a trap into its
own wording and adding a host-specific clause must not read as absence. That
is deliberately generous: the check exists to find a fork that never
received a trap, not to police prose.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

HEADING = "### Verification traps"
REPO_ROOT = Path(__file__).resolve().parent.parent
OWN_KIT = REPO_ROOT / ".claude" / "CLAUDE.md"


def traps_section(text: str) -> str:
    """The traps section, or "" when the file has none."""
    if HEADING not in text:
        return ""
    after = text.split(HEADING, 1)[1]
    # The section runs to the next `## ` heading, or to end of file.
    return re.split(r"^## ", after, maxsplit=1, flags=re.M)[0]


def trap_entries(text: str) -> list:
    """One entry per top-level `- ` bullet, continuation lines folded in."""
    section = traps_section(text)
    entries, current = [], None
    for line in section.splitlines():
        if line.startswith("- "):
            if current is not None:
                entries.append(" ".join(current))
            current = [line[2:].strip()]
        elif current is not None and line.startswith("  "):
            current.append(line.strip())
        elif current is not None and not line.strip():
            continue
    if current is not None:
        entries.append(" ".join(current))
    return entries


def key(entry: str) -> str:
    """A readable identity for printing: the first sentence, normalised."""
    first = re.split(r"(?<=[.:])\s", entry, maxsplit=1)[0]
    first = re.sub(r"[`*_\"']", "", first)
    return re.sub(r"\s+", " ", first).strip().lower()[:60]


def _tokens(entry: str, whole: bool = False) -> set:
    """Content words for overlap matching.

    ``whole=False`` reads only the first sentence — the template side, where
    the opening sentence IS the trap's identity. ``whole=True`` reads the
    entire entry, and is used for the FORK side.

    THE ASYMMETRY IS THE FIX, and it was measured on this very repo. Matching
    first-sentence-to-first-sentence looks symmetric and is not: the score is
    `shared / len(template tokens)`, so every clause the template later adds
    to its opening sentence RAISES the bar a fork must clear with wording it
    merged months earlier. This fork's "which branch Render builds" trap —
    present, correct, and carrying the same leaflet measurement — scored
    11/23 = 0.48 against a template sentence that had since grown
    "2026-08-31", "waiting", "red", "method" and "answer", and was reported
    MISSING.

    That is item 14's own stated failure mode: a strict check reports a
    fork's adaptation as absence and trains it to paste over its
    adaptations. Letting the fork answer from its whole entry keeps the
    template's opening sentence as the identity while allowing a fork to
    have said the same thing in its own shape.
    """
    text = entry if whole else re.split(r"(?<=[.:])\s", entry, maxsplit=1)[0]
    words = re.findall(r"[a-z0-9_./>=-]+", text.lower())
    return {w for w in words if len(w) > 2}


# How much of a template trap's opening sentence a fork entry must share to
# count as the same trap. Deliberately loose: a fork is EXPECTED to merge a
# trap into its own wording and to add host-specific clauses, and a check
# that reported those as absence would train forks to paste over their own
# adaptations — the opposite of what item 14 asks for.
OVERLAP = 0.6


# Below OVERLAP but above REVIEW is a NEAR MISS: reported for a human to
# read, never counted as absent. Measured here 2026-09-05, this band is not
# hypothetical — two traps this fork had genuinely merged scored 0.57 and
# 0.35, and every token they lacked was PROVENANCE from the template's
# opening sentence ("2026-08-27", "after two rounds of wrong diagnoses",
# "clerkhook", "measured twice") rather than anything about the trap.
#
# The temptation is to keep lowering OVERLAP until they match. That is the
# wrong repair: a threshold loose enough to catch every rewording is loose
# enough to match any two traps that share a topic, and the tool stops being
# able to find the thing it exists to find. A third verdict is the honest
# shape — the prose question is genuinely not decidable by token overlap,
# so the tool says so instead of guessing.
REVIEW = 0.3


def _score(template_entry: str, fork_entries: list) -> float:
    wanted = _tokens(template_entry)
    if not wanted:
        return 1.0
    return max(
        (len(wanted & _tokens(c, whole=True)) / len(wanted) for c in fork_entries),
        default=0.0,
    )


def _present(template_entry: str, fork_entries: list) -> bool:
    return _score(template_entry, fork_entries) >= OVERLAP


def compare(fork_text: str, template_text: str):
    """(fork count, template count, missing entries, near-miss entries).

    `missing` is what to act on. `near` is what to read: an entry the fork
    probably carries in its own words, which a fork is EXPECTED to do.
    """
    fork = trap_entries(fork_text)
    template = trap_entries(template_text)
    missing, near = [], []
    for entry in template:
        score = _score(entry, fork)
        if score >= OVERLAP:
            continue
        (near if score >= REVIEW else missing).append((entry, score))
    return len(fork), len(template), missing, near


def main(argv: list) -> int:
    if len(argv) < 2:
        count = len(trap_entries(OWN_KIT.read_text()))
        print(f"{OWN_KIT}: {count} trap entries (nothing compared — pass a "
              "template kit path to compare)")
        return 0 if count else 1

    template_path = Path(argv[1])
    fork_path = Path(argv[2]) if len(argv) > 2 else OWN_KIT
    if not template_path.exists():
        print(f"template kit not readable: {template_path}")
        return 2

    fork_n, template_n, missing, near = compare(
        fork_path.read_text(), template_path.read_text())
    print(f"{fork_path}: fork {fork_n} / template {template_n}")
    for entry, score in missing:
        print(f"  MISSING ({score:.2f}): {key(entry)}…")
    for entry, score in near:
        print(f"  REVIEW  ({score:.2f}): {key(entry)}…")
    if near and not missing:
        print("  (near misses are probably merged in this fork's own "
              "wording — read them, do not paste over them)")
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
