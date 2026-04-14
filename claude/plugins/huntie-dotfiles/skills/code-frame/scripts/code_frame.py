#!/usr/bin/env python3
"""
code_frame.py — print a Jest/Babel-style code frame for a file location.

Usage:
    code_frame.py <path> <line> [--col N] [--span N] [--context N]

Exits non-zero with a message on stderr if the file or line is unreadable.
"""

import argparse
import sys
from pathlib import Path


def expand_tabs(line: str, tabsize: int = 4) -> str:
    return line.expandtabs(tabsize)


def build_frame(
    path: str,
    target_line: int,
    col: int | None,
    span: int,
    context: int,
) -> str:
    file_path = Path(path)
    if not file_path.is_file():
        raise FileNotFoundError(f"not a readable file: {path}")

    raw = file_path.read_text(encoding="utf-8", errors="replace").splitlines()
    total = len(raw)

    if target_line < 1 or target_line > total:
        raise ValueError(
            f"line {target_line} out of range (file has {total} lines)"
        )

    start = max(1, target_line - context)
    end = min(total, target_line + context)

    gutter_width = len(str(end))
    out: list[str] = []

    # Header
    header = f"  {path}:{target_line}"
    if col is not None:
        header += f":{col}"
    out.append(header)

    # Context lines
    for n in range(start, end + 1):
        content = expand_tabs(raw[n - 1])
        marker = ">" if n == target_line else " "
        num = str(n).rjust(gutter_width)
        out.append(f"{marker} {num} | {content}")

        if n == target_line and col is not None:
            # Caret line — gutter-less continuation
            pad = " " * gutter_width
            caret_offset = " " * (col - 1)
            carets = "^" * max(1, span)
            out.append(f"  {pad} | {caret_offset}{carets}")

    return "\n".join(out)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Print a Jest/Babel-style code frame for a file location."
    )
    parser.add_argument("path", help="Path to source file")
    parser.add_argument("line", type=int, help="Target line number (1-indexed)")
    parser.add_argument("--col", type=int, default=None, help="Target column (1-indexed)")
    parser.add_argument("--span", type=int, default=1, help="Caret width (default 1)")
    parser.add_argument("--context", type=int, default=2, help="Lines of context above/below (default 2)")
    args = parser.parse_args()

    try:
        print(build_frame(args.path, args.line, args.col, args.span, args.context))
    except (FileNotFoundError, ValueError) as e:
        print(f"code_frame: {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
