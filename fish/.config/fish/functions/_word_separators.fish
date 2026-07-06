function _word_separators
    # Returns a PCRE character class matching VS Code-style word separators
    # plus whitespace. Used by _forward_word_custom and _backward_word_custom.
    printf '%s' '[]./\\()"'"'"':,;<>~!#%^&*|+=\[{}\x60?\s-]'
end
