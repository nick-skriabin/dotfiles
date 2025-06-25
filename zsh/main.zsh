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

# Lazy load completion on first use
autoload -Uz compinit
compinit() {
  unset -f compinit
  autoload -Uz compinit
  compinit -d ~/.cache/zsh/.zcompdump
  
  # Load completion styles
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  
  # Load Homebrew completions (only if needed)
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    compinit -d ~/.cache/zsh/.zcompdump
  fi
  
  compinit "$@"
}

# Fix Atuin keybindings after zsh-vi-mode initializes
autoload -Uz add-zsh-hook
add-zsh-hook precmd _fix_atuin_keybindings
_fix_atuin_keybindings() {
  # Only run once after first prompt
  add-zsh-hook -d precmd _fix_atuin_keybindings
  
  # Set Atuin keybindings after zsh-vi-mode has initialized
  bindkey -M viins '^r' atuin-search-viins
  bindkey -M emacs '^r' atuin-search
  bindkey -M vicmd '/' atuin-search
}