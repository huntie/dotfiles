---
name: commit-msg
description: Generate a commit message for the current changes
---

Generate a commit message for the current changes. Follow these steps:

1. Detect the repo type: run `sl root` (success = Sapling/hg repo), otherwise check for git.
2. Review the current diff to understand what changed.
3. Draft the commit message using the format below.

## General rules

- Keep the title under 72 characters.
- Use imperative mood ("Fix bug", not "Fixed bug").
- Focus on **why**, not just what.
- Don't use backticks or other Markdown formatting in the title. Formatting is fine in the body/summary.
- Description is optional — skip for trivial changes. When included, write flowing paragraphs without hard line breaks at a fixed character width.

## Message style

### Sapling/hg repos

Prefix the title with one or more `[area]` bracket tags to categorize the change. Tags are hierarchical — start with the broadest relevant area, then narrow by sub-area, feature, or platform as needed.

To choose the right tags, check the commit history of the changed files and their parent folders (e.g. `sl log -l 10 path/to/file`).

**Tag conventions:**

- Use the project/repo shorthand as the primary tag (e.g. `[RN]`, `[metro]`).
- Stack additional tags for sub-area, feature initiative, or platform: `[RN][DevTools]`, `[RN][Network Inspection][Android]`.
- Platform tags go last: `[Android]`, `[iOS]`.
- Use lowercase for standalone projects or packages: `[react_cdp_tools]`, `[dev-middleware]`.
- Omit the project tag when the project is obvious from context (e.g. in a single-project repo).

**Examples:**

- `[RN] Narrow file set for no-commonjs-exports lint rule`
- `[RN][performance] Refactor PerformanceEntry as std::variant`
- `[RN][Network Inspection][Android] Add onCreateRequest compatibility overload`
- `[RN][scripts] Add build_debugger_shell check to CI`

**Additional notes:**

- Do not include "Differential Revision" lines — those are managed separately.
- For React Native repos: internal changes must include `Changelog: [Internal]` in the summary. Public changes require a proper changelog category (e.g. `Changelog: [Android][Fixed] - ...`).
- Output the message using explicit `Title:` and `Summary:` labels:

```
Title: [area] Short summary of the change
Summary: Optional longer description.
```

### Git repos

Use a plain summary line with no bracket tags.

```
Short summary of the change

Optional longer description.
```

## Committing

When the user asks to commit (e.g. `hg commit`, `sl commit`, `git commit`), use the generated message to run the commit in one step:

### Sapling (hg/sl)

```bash
# With summary:
sl commit -m "<Title>" --message-field "Summary=<Summary>"

# Without summary:
sl commit -m "<Title>"
```

### Git

```bash
# With description:
git commit -m "<title>" -m "<description>"

# Without description:
git commit -m "<title>"
```
