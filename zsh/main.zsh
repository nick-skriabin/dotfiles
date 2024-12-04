# Custom configurations
source $HOME/.config/zsh/custom.zsh

# Various initializers
export NVM_DIR="$HOME/development/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
{
  eval "$(/usr/local/bin/starship init zsh)"
}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
