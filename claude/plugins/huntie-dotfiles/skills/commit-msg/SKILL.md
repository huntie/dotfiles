---
name: commit-msg
description: Generate a commit message for the current changes
disable-model-invocation: true
---

Generate a commit message for the current changes. Follow these steps:

1. Review the current diff to understand what changed.
2. Detect the repo type by checking which VCS is in use:
    - Run `sl root` (success = Sapling/hg repo)
    - Otherwise, check for git
3. Draft the commit message using the appropriate format below.

## Sapling/hg repos

Use `[area]` bracket tag prefixes to categorize the change. Choose the most specific relevant area by checking the current diff stack and the commit history of the changed files and their parent folders (e.g. `sl log -l 10 path/to/file`).

Format:

```
[area] Short summary of the change

Optional longer description if the change is non-trivial.
```

Examples:

- `[auth] Fix token refresh race condition`
- `[nav][android] Add bottom tab animation`

## Git repos

Use a plain summary line with no bracket tags.

Format:

```
Short summary of the change

Optional longer description if the change is non-trivial.
```

## General rules

- Keep the summary line under 72 characters.
- Use imperative mood ("Fix bug", not "Fixed bug").
- Focus on **why**, not just what.
- In descriptions, write flowing paragraphs — do not insert hard line breaks at a fixed character width.
- Do not include "Differential Revision" lines — those are managed separately.
