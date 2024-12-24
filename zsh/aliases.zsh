# aliases
alias hflush="dscacheutil -flushcache"
alias pserv="python -m SimpleHTTPServer"
alias python="python3"
alias ls='eza'
alias ll='ls -l --icons --git -a --group-directories-first'
alias lt='ls --tree --level=2 --long --icons --git --group-directories-first'
alias v="nvim"
alias cat="bat"
alias c="clear"
alias s="source $HOME/.zshrc"
alias fc="nvim $HOME/.zshcr"
alias yy="yazi"

alias lso="cd ~/Git/label-studio"
alias lse="cd ~/Git/label-studio-enterprise"

alias fcpxreset='rm ~/Library/Application\ Support/.ffuserdata'

# Git
alias gp='git push'
alias gl='git pull'
alias gm='git merge'
alias gmc='git merge --continue'
alias gc='git checkout'
alias ga='git add'
alias gcm='git commit -m'
alias grm='git checkout origin/master -- '
alias grh='git checkout HEAD -- '
alias gby="git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy"
alias ecm='git commit --allow-empty -m "trigger ci" && git push'
alias gd="gh dash"
alias lg="lazygit"

# Jujutsu
alias jk="jj" # remap to unlock "jj" as "esc"

# Cargo
alias cargo-watch='cargo watch -i "www/*" -i .gitignore -i "pkg/*" -s "wasm-pack build --dev"'

# Tmux shortcuts
alias tma='tmux attach -t'
alias vimconfig='cd ~/.config/$NVIM_APPNAME/ && nvim'

alias x='clear && tmux clear-history'

# Github workflows
alias gwls='gh workflow list'
alias gws='gh workflow view'
alias gwr='gh workflow run'

# Specific workflows
# alias gwr-sass='echo {"ref": $0, "deploy_to_prod": true, "sure": "sure"} gwr 30106738'
#
alias gws-sass='gws 30106738'

alias ji="jirust"
alias ld="lazydocker"

# Mutt
alias mt="neomutt"
alias mts="mbsync"
alias mtsa="mbsync -a"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcd="docker-compose down"
alias dce="docker-compose exec"
alias dcl="docker-compose logs"
alias dcu="docker-compose up"
alias dcr="dcd && dcu -d"

# Nix commands
alias nixb="darwin-rebuild switch --flake $HOME/Git/dotfiles/nix-darwin"
alias nixe="v ~/.config/nix-jarwin/flake.nix"

# FS
alias '..'="cd .."
alias '...'="cd ../.."
alias '....'="cd ../../.."
alias '.....'="cd ../../../.."

# Serve
alias lserve="python3 -m http.server $1"

gwr-sass() {
  REF=$1
  PARAMS="{\"ref\": ${REF}, \"deploy_to_prod\": true, \"sure\": \"sure\"}"
  CMD="$PARAMS | gwr 30106738"

  echo $CMD
}

v2g() {
  filename=$1
  output=$2
  offset=$3
  duration=$4
  scale=$5

  ffmpeg -ss $offset -t $duration -i $filename \
    -vf "fps=10,scale=$scale:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $output
}
