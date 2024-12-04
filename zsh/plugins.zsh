# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

# Start Znap
source $HOME/Git/zsh-snap/znap.zsh

# Plugins
# Autocompletions
znap source Aloxaf/fzf-tab
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
