function forward-word-custom
    set -l cmd (commandline)
    set -l pos (commandline --cursor)
    set -l len (string length -- "$cmd")
    set -l sep (_word_separators)

    # Skip non-separator (word) chars
    while test $pos -lt $len
        set -l char (string sub -s (math $pos + 1) -l 1 -- "$cmd")
        string match -qr -- "$sep" "$char"; and break
        set pos (math $pos + 1)
    end

    # Skip separator chars
    while test $pos -lt $len
        set -l char (string sub -s (math $pos + 1) -l 1 -- "$cmd")
        string match -qr -- "$sep" "$char"; or break
        set pos (math $pos + 1)
    end

    commandline --cursor $pos
end
