# Disable sound effects on boot
sudo nvram SystemAudioV

# Disable user interface sound effects
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -bool false

# Stop Apple Music from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null
