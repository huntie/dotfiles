---
name: code-frame
description: Use when surfacing a specific code location in CLI/terminal output — errors, investigation findings, code review comments, or "look at line N" pointers. Formats the location like Jest, Babel, and ESLint do: file path with line:column, then 2-3 lines of context with a caret marking the target line. Use whenever you would otherwise write "see foo.ts line 42" — show the frame instead.
---

# Code Frame Output

Format inline code pointers the way JS tooling does: a file header with `path:line:column`, a few lines of surrounding context, line numbers in a gutter, and a marker on the target line. Readers can locate and understand the issue without opening the file.

## When to use

- Reporting an error or finding tied to a specific line
- Investigation audit trails (pairs naturally with `tracing-logs`)
- Code review comments in CLI/chat output
- Anywhere you would otherwise write "see `foo.ts:42`"

Do **not** use for: multi-file diffs (use a diff format), whole-function listings (use a fenced code block), or output that will be rendered as Markdown in a rich UI (the ASCII gutter is for monospace terminals).

## Usage

Prefer the bundled script — it handles tab expansion, gutter alignment, and edge-of-file trimming, and avoids pulling the file into context.

```bash
scripts/code_frame.py <path> <line> [--col N] [--span N] [--context N]
```

- `path` — source file (required)
- `line` — 1-indexed target line (required)
- `--col` — 1-indexed column; omit to skip the caret row
- `--span` — caret width in characters (default 1)
- `--context` — lines above/below (default 2)

Run it, paste stdout into your reply inside a fenced block. Exits non-zero with a stderr message if the file or line is unreadable — fall back to hand-formatting using the spec below, or to a bare `path:line:column` if the file genuinely can't be read.

## Format spec

```
  src/parser/tokens.ts:42:11
  40 |   const next = peek();
  41 |   if (next.kind === 'eof') return null;
> 42 |   return parse(next.value);
     |           ^
  43 | }
  44 |
```

Rules:

1. **Header line:** `  path:line:column` — two-space indent, no decoration. Column is optional but include it when you have it.
2. **Context window:** 2 lines before, 2 lines after by default. Trim if the target is near the start/end of the file. Expand to 3 only if the surrounding logic genuinely needs it.
3. **Gutter:** right-aligned line number, space, pipe, space. Width matches the widest line number in the frame.
4. **Marker line:** `>` replaces the leading space on the target line's gutter. Below it, an aligned `^` (or `^^^` spanning the relevant token) on a gutter-less continuation row: `     | ` then spaces then carets.
5. **Monospace assumption.** Tabs in source must be expanded to spaces before measuring caret position, otherwise alignment breaks.
6. **One frame per location.** If pointing at multiple lines in the same file, emit multiple frames separated by a blank line — don't try to mark two carets in one frame.

## Examples

**Single-line pointer with column:**

```
  metro/src/DeltaBundler/Serializers/baseJSBundle.js:88:23
  86 |   const preloadedModules = entryPoint.preloaded ?? false;
  87 |   const modules = [...graph.dependencies.values()];
> 88 |   return processModules(modules, options);
     |                          ^^^^^^^
  89 | }
```

**Pointer at start of file (trimmed context):**

```
  packages/cli/index.ts:1:1
> 1 | import {parseArgs} from 'node:util';
    | ^^^^^^
  2 |
  3 | const {values} = parseArgs({...});
```

**Two locations in the same file:**

```
  src/auth/session.ts:14:3
  12 | export function createSession(user: User) {
  13 |   const id = randomUUID();
> 14 |   sessions.set(id, user);
     |   ^^^^^^^^^^^^^^^^^^^^^^
  15 |   return id;
  16 | }

  src/auth/session.ts:31:3
  29 | export function destroySession(id: string) {
  30 |   metrics.increment('session.destroy');
> 31 |   sessions.delete(id);
     |   ^^^^^^^^^^^^^^^^^^^
  32 | }
```

## Notes

- This is purely a presentation format. Do not invent line content — the script reads the file directly; if hand-formatting, read the file first.
- If the file isn't readable (deleted, generated, remote), fall back to `path:line:column` on its own. Don't fabricate context.
- Keep frames tight. The point is fast scanning in a terminal, not a full code listing.
