# Android SDK
if [[ -d /opt/android_sdk ]]; then
    export ANDROID_HOME=/opt/android_sdk
elif [[ -d $HOME/Library/Android/sdk ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
fi
if [[ -n "$ANDROID_HOME" ]]; then
    export PATH=$ANDROID_HOME/emulator:$PATH
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/tools/bin:$PATH
    export PATH=$ANDROID_HOME/platform-tools:$PATH
fi

# Composer
if [[ -d $HOME/.composer/vendor/bin ]]; then
    export PATH=$HOME/.composer/vendor/bin:$PATH
fi

# fastlane
if [[ -d $HOME/.fastlane/bin ]]; then
    export PATH=$HOME/.fastlane/bin:$PATH
fi

# Rust
if [ -f $HOME/.cargo/env ]; then
    source "$HOME/.cargo/env"
fi
