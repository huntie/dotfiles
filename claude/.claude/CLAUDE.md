## Output

- When pointing to a specific code location, use the `/code-frame` skill. Always read the file first — never rely on prior search output for surrounding context lines.

## Writing style

- Use American English for artifacts: code, comments, and docs.
- Do not hard-wrap text bodies (commit messages, Markdown, etc.). Let each paragraph be a single long line. Exception: match existing style in the file or codebase.

## Code style

- Use `import type` for type-only imports.
- Do not add `@ts-ignore`, `@ts-expect-error`, or `$FlowFixMe` without a comment explaining why.
- Do not use `any` — prefer `unknown`, proper generics, or a specific type.
- Prefer `test()` over `it()` for Jest tests.
- When marking code sections, use `// #region` / `// #endregion` pairs. Keep blank lines around the code inside a region, but no blank line between an `#endregion` and the next `#region`.

### Android/Kotlin

- Use `Log.d(ReactConstants.TAG, "[PREFIX] message")` — import `com.facebook.react.common.ReactConstants`.

### iOS/ObjC++

- Use `RCTLog` macros for logging, not `NSLog`.

## Workflow

- In Sapling/hg repos, run `hg addremove --similarity 50` after adding, deleting, or moving files. This keeps the working copy status accurate.
- Update Jest snapshots with `-u` when changes are intentional, and call them out in the summary.

### Commits

- Do not create or amend commits unless explicitly asked, e.g. in plan mode, or when explicitly told to commit.
- Always use the `/commit-msg` skill to generate commit messages (git or hg/sl).
- When amending a commit, also update the commit message to reflect the new changes.

### Build & verification

- Use `buck2 build` for iOS and Android native targets, not `buck`.
- Run the specific test file you changed, not the full suite: `yarn jest path/to/file.test.ts`.
- Run lint and typecheck before considering a task complete.
