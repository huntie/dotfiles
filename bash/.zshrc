# Homebrew
if [[ -f $HOME/homebrew/bin/brew ]]; then
    eval "$($HOME/homebrew/bin/brew shellenv)"
elif [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Hook for VS Code terminal
if [[ -n $VSCODE_ZSH_INIT_COMMAND ]]; then
    eval "$VSCODE_ZSH_INIT_COMMAND"
fi

# rbenv (zsh)
if [[ -f $HOME/.rbenv/bin/rbenv ]]; then
    eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
fi
