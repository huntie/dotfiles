# dotfiles

Personal configuration for macOS and Linux, one directory per tool. This is a public repo: nothing private belongs here.

## Applying changes

- Treat `brew/Brewfile` as a reference of what a machine should have, not a script to replay. Never run `brew bundle` or reinstall from it wholesale.
- When pulling dotfiles and applying changes, apply only what changed: diff the Brewfile against the previous revision and `brew install` just the newly added packages.
