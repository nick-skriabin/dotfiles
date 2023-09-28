function checkout
    git checkout $(git branch --all | fzf | tr -d '[:space:]')
end
