# Plugins

if ! zgenom saved; then
  # Autocompletions
  zgenom load Aloxaf/fzf-tab
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load jeffreytse/zsh-vi-mode
  zgenom load unixorn/fzf-zsh-plugin
fi
