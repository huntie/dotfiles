function backward-word-custom
    set -l cmd (commandline)
    set -l pos (commandline --cursor)
    set -l sep (_word_separators)

    # Skip separator chars going left
    while test $pos -gt 0
        set -l char (string sub -s $pos -l 1 -- "$cmd")
        string match -qr -- "$sep" "$char"; or break
        set pos (math $pos - 1)
    end

    # Skip non-separator (word) chars going left
    while test $pos -gt 0
        set -l char (string sub -s $pos -l 1 -- "$cmd")
        string match -qr -- "$sep" "$char"; and break
        set pos (math $pos - 1)
    end

    commandline --cursor $pos
end
