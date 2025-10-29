# Homebrew
if [[ -f $HOME/homebrew/bin/brew ]]; then
    eval "$($HOME/homebrew/bin/brew shellenv)"
elif [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Android SDK
if [[ -d $HOME/Library/Android/sdk ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
elif [[ -d /opt/android_sdk ]]; then
    export ANDROID_HOME=/opt/android_sdk
fi
if [[ -n "$ANDROID_HOME" ]]; then
    export PATH=$ANDROID_HOME/emulator:$PATH
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/tools/bin:$PATH
    export PATH=$ANDROID_HOME/platform-tools:$PATH
fi
if [[ -d $HOME/Library/Android/sdk ]]; then
    export ANDROID_NDK_REPOSITORY=$HOME/Library/Android/ndk
elif [[ -d /opt/android_ndk ]]; then
    export ANDROID_NDK_REPOSITORY=/opt/android_ndk
fi

# Bun
if [[ -d $HOME/.bun/bin ]]; then
    export PATH=$HOME/.bun/bin:$PATH
fi

# Composer
if [[ -d $HOME/.composer/vendor/bin ]]; then
    export PATH=$HOME/.composer/vendor/bin:$PATH
fi

# fastlane
if [[ -d $HOME/.fastlane/bin ]]; then
    export PATH=$HOME/.fastlane/bin:$PATH
fi

# fnm (Fast Node Manager)
if [[ -f $HOMEBREW_PREFIX/bin/fnm ]]; then
    export PATH=$HOME/Library/Application\ Support/fnm:$PATH
    eval "$(fnm env --use-on-cd --shell bash)"
fi

# jenv
if [[ -d $HOME/.jenv/shims ]]; then
    eval "$(jenv init - --no-rehash)"
    (jenv rehash &) 2> /dev/null
fi

# JetBrains Toolbox
# Note: This enables the `studio` launcher command for Android Studio, which
# will inherit the env variables from the current session.
if [[ -d $HOME/Library/Application\ Support/JetBrains/Toolbox/scripts ]]; then
    export PATH=$HOME/Library/Application\ Support/JetBrains/Toolbox/scripts:$PATH
fi

# depot_tools (Chromium)
if [[ -d $HOME/Development/depot_tools ]]; then
    export PATH=$HOME/Development/depot_tools:$PATH
fi
