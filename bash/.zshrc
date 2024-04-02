# Enable when profiling zsh, adding 'zprof' to the end of this file
# https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof

# Hook for VS Code terminal
if [[ -n $VSCODE_ZSH_INIT_COMMAND ]]; then
    eval "$VSCODE_ZSH_INIT_COMMAND"
fi

# rbenv (zsh)
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh)"
fi
