# - Display -

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# - Menu Bar -

# Hide the Time Machine, Volume, and User items
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
done

# Show Bluetooth, AirPort, Battery, and Clock
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"

# - Windows -

# Disable wallpaper tinting in windows
defaults write NSGlobalDomain AppleReduceDesktopTinting -int 1

# - Dock -

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Set Dock orientation
defaults write com.apple.dock orientation -string "bottom"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 45

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Minimise apps to Dock icon
defaults write com.apple.dock minimize-to-application -float 1

# Remove the Dock recents section
defaults write com.apple.dock show-recents -float 0

# Disable the Launchpad gesture
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# - Mission Control -

# Disable automatic rearrangement of Spaces
defaults write com.apple.dock mru-spaces -int 0

# - Hot Corners -

# Set bottom right screen corner to no-op
defaults write com.apple.dock wvous-br-corner -int 0
