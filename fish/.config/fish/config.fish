set fish_greeting

# - Exports -

set -x EDITOR vim

if type -q nvim
    set -x EDITOR nvim
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

if [ -n $VIM ]
    # Explicitly set 24-bit colors in NeoVim terminal windows
    # https://github.com/neovim/neovim/issues/10836
    set -x COLORTERM 'truecolor'
end

# - Aliases -

alias ls 'ls -F -h'
alias grep 'grep -n --color'

alias setclip 'xclip -selection c'
alias getclip 'xclip -selection c -o'

abbr -a ywd 'pwd | setclip'
abbr -a rsync 'rsync --progress'
abbr -a npmlist 'npm list -g --depth=0'
abbr -a rand 'openssl rand -base64'

alias sail './vendor/bin/sail'

if [ (uname) = 'Darwin' ]
    alias ls 'ls -F -h -G'
    alias setclip pbcopy
    alias getclip pbpaste

    abbr -a brewdeps 'brew deps --tree --installed'
    abbr -a tldr 'tldr --platform linux'
    abbr -a tower gittower
else
    alias open xdg-open
end

# - Packages -

# Install and run Fisher package manager on first run
if status is-interactive && not functions -q fisher
    curl -sL https://git.io/fisher | source; and fisher install jorgebucaran/fisher
end
