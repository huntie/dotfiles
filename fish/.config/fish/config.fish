set fish_greeting

# - Exports -

set -x EDITOR vim

if type -q nvim
    set -x EDITOR nvim
    abbr -a n nvim
    abbr -a vim nvim
    abbr -a vimdiff 'nvim -d'
end

# Repaint screen upon exiting less
set -x LESS r

# Highlight color for grep matches
set -x GREP_COLOR '1;32'

# Homebrew options
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_AUTO_UPDATE 1

# Perform fzf searches using fd, with options
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --no-ignore --max-depth 10 --follow --exclude .git --exclude node_modules'
set -x FZF_DEFAULT_OPTS '--preview \'[ -f {} ] && bat --color=always {}\''

# fish fzf options
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND

# ripgrep
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/rc

# Enable true color support
set -x COLORTERM truecolor

# Claude Code truecolor override
# (https://github.com/anthropics/claude-code/issues/35148)
set -x CLAUDE_CODE_TMUX_TRUECOLOR 1

# - Aliases -

alias ls 'ls -F -h'
alias grep 'grep -n --color'

abbr -a rsync 'rsync --progress'
abbr -a ywd 'pwd | pbcopy'
abbr -a rand 'openssl rand -base64'
abbr -a nvm fnm
abbr -a tower gittower

alias sail './vendor/bin/sail'

if [ (uname) = 'Darwin' ]
    alias ls 'ls -F -h -G'
else
    alias open xdg-open
    alias pbcopy 'xclip -selection c'
    alias pbpaste 'xclip -selection c -o'
end

# - Colors -

set -U fish_color_autosuggestion 555 brblack
set -U fish_color_cancel -r
set -U fish_color_command --bold
set -U fish_color_comment red
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end brmagenta
set -U fish_color_error brred
set -U fish_color_escape bryellow --bold
set -U fish_color_history_current --bold
set -U fish_color_host normal
set -U fish_color_host_remote yellow
set -U fish_color_match --background=brblue
set -U fish_color_normal normal
set -U fish_color_operator bryellow
set -U fish_color_param cyan
set -U fish_color_quote yellow
set -U fish_color_redirection brblue
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path --underline

# - Packages -

# Install and run Fisher package manager on first run
if status is-interactive && not functions -q fisher
    curl -sL https://git.io/fisher | source; and fisher install jorgebucaran/fisher
end
