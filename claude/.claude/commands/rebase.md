Rebase the current branch or stack onto an upstream target.

Accepts an optional argument: `$ARGUMENTS` (a branch or bookmark name).

## Mercurial (sl/hg)

Default bookmark: `remote/fbsource/stable`.

1. `sl commit -m "WIP $(date '+%Y-%m-%d %H:%M')" || true`
2. `sl pull --rebase -d <bookmark>`
3. Resolve conflicts if any, then `sl rebase --continue`.

## Git

Default branch: `main`.

1. `git stash --include-untracked`
2. `git fetch --all`
3. Determine the rebase target: use `upstream/<branch>` if the `upstream` remote exists, otherwise `origin/<branch>`.
4. `git rebase <target>`
5. Resolve conflicts if any, then `git rebase --continue`.
6. `git stash pop || true`
