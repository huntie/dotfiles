# GitHub Codespaces prompt, copied over fish_prompt.fish by install.sh
function fish_prompt
    echo -n "[$GITHUB_USER@$CODESPACE_NAME "(prompt_pwd)(fish_git_prompt)']> '
end
