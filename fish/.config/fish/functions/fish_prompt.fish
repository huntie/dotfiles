function fish_prompt
    set -l git_branch (git symbolic-ref --short HEAD 2> /dev/null)

    set_color white
    echo -n "$USER "(prompt_pwd)' '

    if [ -n "$git_branch" ]
        echo -n "($git_branch"
        if not git diff --quiet 2>/dev/null
            echo -n '*'
        end
        echo -n ') '
    end

    set_color normal
    echo -n '> '
end
