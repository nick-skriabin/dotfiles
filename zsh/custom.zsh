CONFIG_PATH="~/.config/zsh"

# Load all plugins
source ~/.config/zsh/znap.zsh
source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/locale.zsh
source ~/.config/zsh/keys.zsh
source ~/.config/zsh/atuin.zsh
source ~/.config/zsh/keybindings.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/fn.zsh
source ~/.config/zsh/functions.zsh

# Lazy load NVM
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() {
  unset -f node
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  node "$@"
}

npm() {
  unset -f npm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  npm "$@"
}

npx() {
  unset -f npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  npx "$@"
}

# Lazy load zoxide
z() {
  unset -f z
  if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
  fi
  z "$@"
}


# Lazy load brew
brew() {
  unset -f brew
  if command -v brew &>/dev/null; then
    eval "$(brew shellenv)"
  fi
  brew "$@"
}
