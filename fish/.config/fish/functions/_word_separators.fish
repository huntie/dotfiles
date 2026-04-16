function _word_separators
    # Returns a PCRE character class matching VS Code-style word separators
    # plus whitespace. Used by forward-word-custom and backward-word-custom.
    printf '%s' '[]./\\()"'"'"':,;<>~!#%^&*|+=\[{}\x60?\s-]'
end
