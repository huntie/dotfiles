# Claude Code

Personal Claude Code settings.

## Contents

- **CLAUDE.md** - Project rules and workflow conventions
- **commands/** - User commands
    - `/conflicts` - Resolve merge conflicts in the working tree
    - `/rebase` - Rebase the current branch or stack onto an upstream target (git and Mercurial)
- **plugins/huntie-dotfiles** - Custom skills plugin
    - `/code-frame` - Format a code location as a terminal-style frame (non-invocable)
    - `/commit-msg` - Generate commit messages
    - `/deep-system-trace` - Trace data flow through a system using log instrumentation

## Installation

Using GNU Stow from the dotfiles root:

    stow -t ~/ claude

This symlinks `CLAUDE.md` and `commands/` into `~/.claude/`. The plugin directory is excluded from stow (see `.stow-local-ignore`) because Claude Code cannot load plugins from symlinked directories.

## Plugin setup

Register the dotfiles plugin directory as a local marketplace in
`~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "huntie": {
      "source": {
        "source": "directory",
        "path": "/Users/huntie/Development/dotfiles/claude/plugins/huntie-dotfiles"
      }
    }
  },
  "enabledPlugins": {
    "huntie-dotfiles@huntie": true
  }
}
```

Then install the plugin:

    /plugin update

## Syncing skills

After editing skills in the dotfiles repo, refresh the plugin cache:

    /plugin update
