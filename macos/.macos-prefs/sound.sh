# Disable sound effects on boot
sudo nvram SystemAudioV

# Disable user interface sound effects
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -bool false
