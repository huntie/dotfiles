---
name: investigation-logs
description: Use when investigating a build or runtime issue where the data flow is unclear, crosses multiple layers/languages/abstractions, or involves caching. Instruments code with log statements to trace values through the system without changing any behavior. Use when asked to "trace", "investigate", "figure out why X has value Y", "why does the build use X", or "add debug logging".
---

# Investigation Logs

Investigate a build or runtime issue by instrumenting code with log statements — without changing any semantics or behavior. Your remit is purely to trace data flow and explain what the code is doing AS IS.

## Invocation

```text
/investigation-logs <description of issue>
```

## Goal

Produce an **audit trail**: an ordered explanation of how the system arrived at the observed behavior. This might trace a value through transformations, a sequence of decisions that led to a code path, or the ordering of operations across scripts. Every link must be backed by observed log output.

## Rules

1. **Do not fix anything.** Only add log/print/echo statements and read existing code. Do not change semantics, control flow, or behavior. When the root cause is found, stop and report. Do not apply the fix in the same session.
2. **Tag every log line with a versioned slug.** Choose a short, descriptive prefix for the investigation (e.g. `RNPATH`). Every log you add gets this prefix plus a version number: `[RNPATH-v1]`. Whenever you modify that line or file, bump the version (e.g. `[RNPATH-v2]`). Without versioning, a stale log line from a cached build is indistinguishable from your new one.
3. **Prove your logs ran.** After each run, search output for your slug. A missing slug means caching or a dead code path — investigate which. Never assume changes took effect without evidence.
4. **Bust caches proactively.** Before each run, delete known caches that could serve stale artifacts (e.g. `ios/Pods/`, `ios/build/`, DerivedData, Metro cache, `node_modules/.cache`, Gradle build cache). Document which caches you clear and why.
5. **Log values, not just execution.** Print the actual runtime value, the working directory, and how the value was derived — not just "reached line N".
6. **Work incrementally.** Start at the failure point, add logs, run, observe, then trace one step upstream. Repeat. Do not try to instrument everything at once.
7. **Beware name reuse across layers.** The same identifier may refer to different things in different scripts or languages. Verify each occurrence independently.
8. **Maintain an investigation log** in a scratch file. After each run cycle, record: what you logged, what you observed, what it tells you, and what to investigate next. This file is your persistent state across long investigations.

## Workflow

1. **Read the error.** Identify the exact failure message and location.
2. **Instrument the failure site.** Log the relevant state at the point of failure, with a version slug.
3. **Clear caches and run.**
4. **Check for your slug.** If present, note the value. If absent, investigate why.
5. **Trace upstream.** Find where the observed state was produced or decided. Add a log there. Repeat from step 3.
6. **Present the audit trail** once every link from origin to failure is backed by an observed log line with the current version slug.

## Presenting the trail

The audit trail has two kinds of content:

1. **Evidence** — raw log output and any captured run artifacts. Keep these as files on disk and reference them by path as needed. Do not reformat or polish.
2. **Explanation** — the inline prose that ties the evidence together and walks the reader through the trace. When the explanation points at a specific line of *source code* (the place a value was set, a branch was taken, a transformation happened), render it as a code frame using the `code-frame` skill if available, rather than a bare `path:line` string.

Code frames are for source citations in the explanation only. They are not a presentation format for log output.
