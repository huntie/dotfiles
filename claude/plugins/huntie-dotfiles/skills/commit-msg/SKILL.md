---
name: commit-msg
description: Generate a commit message for the current changes. Use when committing or when asked to draft a commit message.
---

# Commit Messages

Generate a commit message for the current changes. Follow these steps:

1. Detect the repo type: run `sl root` (success = Sapling/hg repo), otherwise git.
2. Review the current diff to understand what changed.
3. Draft the message using the rules below, then apply the [self-check](#self-check-before-you-hand-it-over).

## The bar

**The two-sentence test.** A reviewer who reads only the title and the first two sentences must know what changed and why. If they'd still have to read the diff to find that out, rewrite — don't add a third sentence.

**Write for the reviewer, not the author.** The summary justifies the change and flags what needs scrutiny. It is not a record of the work, a changelog of your edit sequence, or a defence of every decision.

**Budget.** Overshooting is the default failure. Aim low and expand only under pressure:

| Diff | Summary body |
|---|---|
| Cleanup, flag removal, dependency bump, rename | 1-2 sentences, sometimes bullets |
| Typical feature or refactor | 2-4 sentences, optionally 3-5 bullets |
| Behavior change, migration, subtle bug | Add a short Motivation/Context block, or a code snippet if semantics need showing |
| Anything | Stop at ~150 words unless a snippet or table is carrying real weight |

Subheadings, bullet lists, and tables are all **opt-in**. Plain prose is the default and usually sufficient.

## What earns a place in the summary

Apply this filter to every sentence and bullet. **Would a reviewer act differently knowing this?** If not, cut it.

Earns a place:

- Why the change is worth making — the pain, the driver, the rollout stage.
- Behavior a user or caller can observe changing.
- A decision a reviewer might disagree with, and briefly why you made it.
- A caveat, known gap, or follow-up that affects whether this should land.
- Cross-references: `Directly follows D123`, `Resolves T456`, an upstream PR link.

Does **not** earn a place — the diff already says it:

- Renames, moved helpers, extracted or deleted intermediate types, signature changes.
- Which file gained or lost which function.
- Internal plumbing that has no effect outside the change.
- Restating the title in longer form.
- Narrating the refactor sequence ("first X was extracted, then Y took a parameter instead of Z").
- Test/lint/typecheck results — those belong in the test plan.

> A structural refactor with no behavior change is usually **one or two sentences**: name the shape it now has and why. The reviewer reads the code for the rest.

**Group and count.** Collapse bulk edits into one bullet with a number — "Repoint deep type imports to the public root API — 146 files" — never a file inventory. If a bullet list is drifting toward one-bullet-per-file, replace it with a sentence.

**Backtick every code symbol** — API names, packages, paths, flags, files. Err toward more.

## Shape

Front-load the why, then what. For a stacked or follow-up diff, open with the shared goal in one line, then what *this* one does.

Bullets, when used, are terse, parallel and verb-first — a phrase each, not a sentence each:

```
- Remove `enableNetworkEventReporting` and `fuseboxNetworkInspectionEnabled` flag definitions.
- Remove all feature guards in code.
- Update tests (add mocks).
- (fbsource) Remove all overrides.
```

Reach for a `**Heading**` (own line, blank line either side) only when the summary genuinely has two or more parts. In rough order of usefulness: **Motivation** / **Context** (why, or setup for a stack), **This diff** (pairs with either), **Notes** (caveats and follow-ups). **Problem** / **Fix** for bug narratives. Anything beyond these is over-structuring.

Use a code snippet when semantics are hard to state in prose — a Flow-vs-TypeScript behavior difference, a before/after of generated output. That is high-value detail, not noise. Use `>` blockquotes for reviewer asides. Lead a gating caveat with `NOTE:` at the very top, above everything.

### Worked example

A refactor that also changed one behavior. Both versions are accurate; only one is worth reading.

**Too long** — narrates the refactor, buries the one thing that matters:

> The commands and message layout that differ between checkouts sit behind a `CommitBackend` record: `commit-backend.js` holds the Git implementation and loads a Meta-internal one when present, leaving `sync-and-build.js` to orchestrate the sync. `--create-diff` shrinks to gating only the code review submission that can follow, and errors where one isn't supported rather than being silently ignored. `checkCanCreateDiff` becomes `checkCanCommit` and no longer returns a struct that was mostly its own arguments echoed back, removing the `DiffBaseInfo` type. `commitSync` takes `isUnlandable` rather than `noBuild`, so the commit step no longer reads `Is local checkout:` back out of the `BUILD_INFO` file it just wrote.

**Right** — same diff:

> The commands and message layout that differ between checkouts now sit behind a `CommitBackend` record, leaving `sync-and-build.js` to orchestrate the sync. `--create-diff` gates only the code review submission that can follow, and errors where one isn't supported rather than being silently ignored.
>
> **Notes**
>
> A `DO NOT LAND` commit is now abandoned after submission for a local checkout too, not just under `--no-build`.

The renames, the deleted type and the `BUILD_INFO` round-trip are all visible in the diff. The abandon change is not, and it is the only line a reviewer must not miss.

## Title

- Concise and specific, imperative mood ("Fix bug", not "Fixed bug"). Aim for ~72 characters excluding `[area]` tags, but a precise title beats hitting a number.
- Plain text only — no backticks or Markdown. Markdown belongs in the summary.

### Tags (Sapling/hg only)

Prefix with one or more `[area]` tags, broadest first, narrowing by sub-area, feature, then platform. Check the history of the changed files to pick them: `sl log -l 10 path/to/file`.

- Project/repo shorthand as the primary tag: `[RN]`, `[metro]`. Lowercase for standalone projects or packages: `[dev-middleware]`, `[flow-api-translator]`.
- Stack for sub-area or platform, platform last: `[RN][scripts]`, `[RN][Network Inspection][Android]`.
- Omit the project tag when it's obvious from context.

Examples: `[RN] Clean up network inspection feature flags`, `[RN][dev-middleware] Drop chrome-launcher dependency`.

## Test plan

Show what you ran and what it proved — concrete over prose. Commands in fenced blocks; `✅` / `⚠️` / `ℹ️` to mark outcomes; screenshots or `pxl.cl` links for anything visual; a Before/After table when a comparison genuinely needs one.

State the bar honestly. If verification was mechanical rather than end-to-end, say so rather than filing it under a stronger heading. Name what you did **not** run and why. `Signals` alone is a fine test plan when CI genuinely is the test.

## React Native conventions

- **`Changelog:` is a required trailer** on nearly every RN diff, placed at the end of the summary.
  - Internal-only: `Changelog: [Internal]`, optionally `- <short note>`.
  - Public: `Changelog: [Category][Type] - <description>`, Type being `Added` / `Fixed` / `Changed` / `Breaking` / `Deprecated`. Lead with the affected surface in bold: `[General][Fixed] - **React Native DevTools**: ...`.
- Put fbsource-only notes below the Changelog under `Internal:` — always that marker, never `Facebook:`, even when the existing message uses it. Task numbers, internal URLs, fbsource paths, MobileConfig names and internal product names go there, never above it.
- Do not write `Differential Revision:` lines, and never strip an existing one.

## Self-check before you hand it over

1. Do the title and first two sentences alone convey the change?
2. Is every remaining sentence something a reviewer would act on?
3. Any bullet that just restates a rename, a moved function, or a deleted internal type — cut it.
4. Is it under budget for this kind of diff?
5. Are the internal-only details below `Internal:`?

## Committing

Re-read the existing message before overwriting it — the user may have edited it outside Claude Code (`sl log -r . -T '{desc}'`, `git log -1 --format=%B`, or `jf sync` to pull Phabricator's copy first).

```bash
# Sapling — with summary:
sl commit -m "<Title>" --message-field "Summary=<Summary>"
# Sapling — without summary:
sl commit -m "<Title>"

# Git:
git commit -m "<Title>" -m "<Summary>"
```

Editing an existing Sapling commit message: `sl amend -l /tmp/msg.txt` (never `sl metaedit -m`, which drops `Differential Revision:`). Once a diff exists, prefer `meta phabricator.diff update -n D<number> --summary=... --test-plan=...` then `jf sync -r .` — that edits fields in place with no new version and no CI re-run. Only use `jf template --override-*` + `jf submit -u` when you are re-uploading code anyway.
