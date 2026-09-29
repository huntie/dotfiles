#!/usr/bin/env bash
#
# GitHub Codespaces only. Installs git, fish, and Claude Code settings.

set -euo pipefail

if [ -z "${CODESPACES:-}" ]; then
  echo "install.sh: GitHub Codespaces only; elsewhere, stow packages by hand (see README)" >&2
  exit 1
fi

DOTFILES=$(cd "$(dirname "$0")" && pwd -P)

if ! git config --global --fixed-value --get-all include.path "$DOTFILES/git/.gitconfig_devcontainer" > /dev/null; then
  git config --global --add include.path "$DOTFILES/git/.gitconfig_devcontainer"
fi

mkdir -p "$HOME/.config/git" "$HOME/.config/fish" "$HOME/.claude"
cp "$DOTFILES/git/.config/git/ignore" "$HOME/.config/git/ignore"
cp -R "$DOTFILES/fish/.config/fish/." "$HOME/.config/fish/"
cp "$DOTFILES/fish/.config/fish/functions/fish_prompt_devcontainer.fish" "$HOME/.config/fish/functions/fish_prompt.fish"
cp "$DOTFILES/claude/.claude/settings.json" "$HOME/.claude/settings.json"

if command -v fish > /dev/null; then
  sudo chsh "$(id -un)" --shell "$(command -v fish)"
fi
