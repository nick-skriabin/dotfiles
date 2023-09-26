function cdm
    mkdir -p $argv
    cd $argv
end

function ghpre
    gh pr checkout $argv
    nvim -c ":Octo pr edit $argv"
end
