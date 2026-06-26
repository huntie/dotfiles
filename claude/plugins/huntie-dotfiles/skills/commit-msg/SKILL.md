---
name: commit-msg
description: Generate a commit message for the current changes. Use when committing or when asked to draft a commit message.
---

# Commit Messages

Generate a commit message for the current changes. Follow these steps:

1. Detect the repo type: run `sl root` (success = Sapling/hg repo), otherwise git.
2. Review the current diff to understand what changed.
3. Draft the commit message using the rules and format below.

## Title (subject line)

- Under 72 characters. Imperative mood ("Fix bug", not "Fixed bug").
- No backticks or Markdown formatting in the title — plain text only. Markdown belongs in the Summary (below).
- In Sapling/hg repos, prefix with `[area]` bracket tags (see [Title tags](#title-tags-saplinghg-only)).

## Summary (description)

Skip for trivial changes.

**Front-load the why.** The first sentence should let a reader who stops there understand the diff.

Use bold subheadings to organize longer summaries — each `**Heading**` on its own line with a blank line before and after:

```
**Motivation**

Why this change is worth making.

**This diff**

What this diff does about it.
```

Short summaries need no subheadings — don't force structure where a plain paragraph suffices. Choose from these as needed:

| Subheading | When to use |
|---|---|
| Context | Background for follow-up diffs or stacked changes. |
| Motivation | Why this change is worth making — the user pain or technical driver. |
| Problem / Root cause / Fix | Bug narratives. Use the subset that fits — all three for complex bugs, just Problem + Fix for straightforward ones. |
| This diff | What specifically *this* diff does, when Context sets up a broader effort. |
| Changes | Bullet list of what changed — useful for multi-faceted diffs. |
| Impact | What this means for users, performance, or downstream consumers. |
| Notes | Caveats, limitations, or remaining work. |

Use Before/After tables for visual or behavioral comparisons. Reference prior work concisely: "Follows D1234" or "Follow-up to #1234".

## Title tags (Sapling/hg only)

Prefix the title with one or more `[area]` bracket tags. Tags are hierarchical — broadest area first, narrowing by sub-area, feature, or platform.

To choose the right tags, check the commit history of the changed files and their parent folders (e.g. `sl log -l 10 path/to/file`).

- Use the project/repo shorthand as the primary tag (e.g. `[RN]`, `[metro]`).
- Stack additional tags for sub-area, feature, or platform: `[RN][scripts]`, `[RN][Network Inspection][Android]`.
- Platform tags go last: `[Android]`, `[iOS]`.
- Use lowercase for standalone projects or packages: `[react_cdp_tools]`, `[dev-middleware]`.
- Omit the project tag when obvious from context (e.g. single-project repo).

Examples: `[RN] Narrow file set for no-commonjs-exports lint rule`, `[RN][Network Inspection][Android] Add onCreateRequest compatibility overload`.

## React Native conventions

- Internal changes: include `Changelog: [Internal]` in the summary.
- Public changes: use a changelog category, e.g. `Changelog: [Android][Fixed] - ...`.
- Do not include "Differential Revision" lines — those are managed separately.

## Committing

Always re-read the current commit or diff message (e.g. `git log -1 --format="%B"`, `sl log -r . -T '{desc}'`, `jf sync`) before overwriting it. The user may have edited it outside Claude Code.

When asked to commit, use the generated message directly:

```bash
# Sapling — with summary:
sl commit -m "<Title>" --message-field "Summary=<Summary>"
# Sapling — without summary:
sl commit -m "<Title>"

# Git — with summary:
git commit -m "<Title>" -m "<Summary>"
# Git — without summary:
git commit -m "<Title>"
```
