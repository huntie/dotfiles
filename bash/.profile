# Composer
export PATH=$HOME/.composer/vendor/bin:$PATH

# Rust
if [ -f $HOME/.cargo/env ]; then
    source "$HOME/.cargo/env"
fi

# Android SDK (macOS)
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH

# fastlane (macOS)
export PATH=$HOME/.fastlane/bin:$PATH
