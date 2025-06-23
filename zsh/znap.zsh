# Download Znap, if it's not there yet.
[[ -f "${HOME}/.zgenom/zgenom.zsh" ]] ||
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"
