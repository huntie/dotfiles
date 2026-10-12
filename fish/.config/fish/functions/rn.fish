function rn --description 'Go to devroot/projects/react-native'
    pushd (set -q DEVROOT; and echo $DEVROOT; or echo $HOME/devroot)/projects/react-native
end
