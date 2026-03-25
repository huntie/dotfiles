# Claude Code

Personal Claude Code settings.

## Contents

- **CLAUDE.md** - Project rules and workflow conventions
- **plugins/huntie-dotfiles** - Custom skills plugin
    - `/commit-msg` - Generate commit messages

## Installation

Using GNU Stow from the dotfiles root:

    stow -t ~/ claude

This symlinks `CLAUDE.md` into `~/.claude/`. The plugin directory is excluded from stow (see `.stow-local-ignore`) because Claude Code cannot traverse directory symlinks outside `~/.claude/`.

## Syncing skills

After editing skills in the dotfiles repo, copy them to the plugin cache:

    cp -r claude/plugins/huntie-dotfiles/. ~/.claude/plugins/huntie-dotfiles/
