function fish_prompt
    set -l git_branch (git symbolic-ref --short HEAD 2> /dev/null)

    set_color 828282
    echo -n "$USER "(prompt_pwd)' '

    if [ -n "$git_branch" ]
        set -l git_changed (git ls-files -m)

        echo -n "($git_branch"
        if [ -n "$git_changed" ]
            echo -n '*'
        end
        echo -n ') '
    end

    set_color normal
    echo -n '> '
end
