# Enable when profiling zsh, adding 'zprof' to the end of this file
# https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof

# rbenv (zsh)
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh)"
fi

# Hook for VS Code terminal
if [[ -n $VSCODE_ZSH_INIT_COMMAND ]]; then
    # Workaround for Claude Code color detection against TERM_PROGRAM=vscode
    # See https://github.com/anthropics/claude-code/issues/35148#issuecomment-4602417531
    export TERM_PROGRAM="generic"
    eval "$VSCODE_ZSH_INIT_COMMAND"
fi
