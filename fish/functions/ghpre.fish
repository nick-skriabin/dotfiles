function ghpre
    gh pr checkout $argv
    nvim -c ":Octo pr edit $argv"
end
