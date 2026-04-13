Rebase the current stack onto `remote/fbsource/stable`

1. `sl commit -m "WIP $(date '+%Y-%m-%d %H:%M')" || true`
2. `sl pull --rebase -d remote/fbsource/stable`
3. Resolve conflicts if any, then `sl rebase --continue`.
