## Code style

- Use American English for all code, comments, and docs.
- Use `import type` for type-only imports.
- Do not add `@ts-ignore`, `@ts-expect-error`, or `$FlowFixMe` without a comment explaining why.
- Do not use `any` — prefer `unknown`, proper generics, or a specific type.
- Prefer `test()` over `it()` for Jest tests.
- Before creating a new abstraction, search for existing patterns in the codebase.
- When marking code sections, use `// #region` / `// #endregion` pairs. Do not add blank lines between consecutive pairs.

## Build & verification

- Use `buck2 build` for iOS and Android native targets, not `buck`.
- Run the specific test file you changed, not the full suite: `yarn jest path/to/file.test.ts`.
- Run lint and typecheck before considering a task complete.

## Commits

- Always use the `/commit-msg` skill to generate commit messages (git or hg/sl).
- The `/commit-msg` skill auto-detects the VCS and includes committing instructions — follow them to commit in one step.

## Writing style

- Be concise by default.

### Android/Kotlin

- Use `Log.d(ReactConstants.TAG, "[PREFIX] message")` — import `com.facebook.react.common.ReactConstants`.

### iOS/ObjC++

- Use `RCTLog` macros for logging, not `NSLog`.
