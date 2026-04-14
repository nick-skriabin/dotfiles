# Ultra-minimal startup for instant prompt
# Disable bell and job notifications
unsetopt BEEP
setopt NO_NOTIFY

# Load starship prompt immediately for better UX
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  # Fallback minimal prompt
  PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{red}%#%f '
fi

# Load everything else quickly but synchronously
source ~/.config/zsh/env.zsh
source ~/.config/zsh/path.zsh
source ~/.config/zsh/custom.zsh

# Deferred compinit — runs async after first prompt renders
autoload -Uz add-zsh-hook

_deferred_compinit() {
  add-zsh-hook -d precmd _deferred_compinit

  # Set up brew completions FPATH before compinit
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  fi

  autoload -Uz compinit
  compinit -d ~/.cache/zsh/.zcompdump

  # Completion styles
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
}
add-zsh-hook precmd _deferred_compinit

# Fix Atuin keybindings after zsh-vi-mode initializes
add-zsh-hook precmd _fix_atuin_keybindings
_fix_atuin_keybindings() {
  # Only run once after first prompt
  add-zsh-hook -d precmd _fix_atuin_keybindings

  # Set Atuin keybindings after zsh-vi-mode has initialized
  bindkey -M viins '^r' atuin-search-viins
  bindkey -M emacs '^r' atuin-search
  bindkey -M vicmd '/' atuin-search
}

# Check if binaries are available and only define functions if they're not
NODE_BINARY="$NVM_DIR/versions/node/$(ls "$NVM_DIR/versions/node" | sort -V | tail -1)/bin/node"
ZOXIDE_BINARY="/run/current-system/sw/bin/zoxide"
BREW_BINARY="/opt/homebrew/bin/brew"

# Lazy load NVM (only if not already in PATH)
if [[ ! -f "$NODE_BINARY" ]]; then
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
fi

# Lazy load zoxide (only if not already in PATH)
z() {
  unset -f z
  if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
  fi
  z "$@"
}

# Lazy load brew (only if not already in PATH)
if [[ ! -f "$BREW_BINARY" ]]; then
  brew() {
    unset -f brew
    if command -v brew &>/dev/null; then
      eval "$(brew shellenv)"
    fi
    brew "$@"
  }
fi

# Init enva
eval $(enva hook zsh)
