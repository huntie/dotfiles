# Dotfiles

Personal OS and Unix tool configuration files.

## Installation

Files are organised by individual application, which can be selectively linked to the host home directory using the [GNU Stow](https://www.gnu.org/software/stow/) utility.

    stow -t ~/ git

## Highlights

### fish

- [`fish_plugins`](https://github.com/huntie/dotfiles/blob/master/fish/.config/fish/fish_plugins)

### macOS

- [Map print_screen to system screenshot tool](https://github.com/huntie/dotfiles/commit/c298d939672dfa32512464901e06bbeb3cdbf5c6#diff-1e8586f694c8d7ae25cf4c644dff3fdcdef67ec374c6481c27bd6d28a7f751b6)
- [Map home and end to cmd+left and cmd+right](https://github.com/huntie/dotfiles/commit/a5d7efd2c1872974dc2b796f733e15d1946273ff#diff-d96ab56edb58947d8cb196fa92ece9f4cf6813e99c654f48ca5145331a006697R19-R58)
- [Reduce keyboard repeat rate](https://github.com/huntie/dotfiles/blob/0f1b7a40c172c9e8c155959950e558f0ccbb7c79/macos/.macos-prefs/input.sh#L12-L14)

### VS Code

- [Add keybindings for sub-word selection](https://github.com/huntie/dotfiles/commit/c19d78b17f67be9b5e7bad88072edc40c478aaa8#diff-c600edf6ce0739a94a591d68b4a42d84b76a117e0395a1bb88c36aa5ae9024d7)
- [Add keybindings for Sublime-like split layouts](https://github.com/huntie/dotfiles/commit/59ae2c30ee83cf4a0f78c65f3ba21dac5fb41ec8#diff-c600edf6ce0739a94a591d68b4a42d84b76a117e0395a1bb88c36aa5ae9024d7)
- [Enable Emmet for additional languages (JSX), set expand shortcut](https://github.com/huntie/dotfiles/commit/90d8619c9510d4969bf8ff277205dd94275f3ff0#diff-c600edf6ce0739a94a591d68b4a42d84b76a117e0395a1bb88c36aa5ae9024d7)
- [Disable auto-reveal of active file, add reveal file binding](https://github.com/huntie/dotfiles/commit/72ede826b756796d95e332916062cdc542c5eff2#diff-c600edf6ce0739a94a591d68b4a42d84b76a117e0395a1bb88c36aa5ae9024d7)