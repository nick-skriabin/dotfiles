# aliases
alias hflush="dscacheutil -flushcache"
alias chromedebug="adb forward tcp:9222 localabstract:chrome_devtools_remote"
alias pserv="python -m SimpleHTTPServer"
alias md="mkdir -p"
alias zshconfig="cd $HOME/.config/zsh && nvim"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias gtf="cd ~/Git/gettaxfree"
alias pick="cd ~/Git/pickio"
alias rc="bundle exec rails console"
alias python="python3"
alias ls='exa'
alias la='exa -l --icons --git -a --group-directories-first'
alias lt='exa --tree --level=2 --long --icons --git --group-directories-first'
alias v="/opt/homebrew/bin/nvim"
alias cat="bat"
alias c="clear"
alias s="source ~/.config/fish/config.fish"
alias fc="nvim ~/.config/fish/config.fish"

alias dls="cd ~/htx && docker run --rm -p 8080:8080 -v `pwd`/labeling:/label-studio/labeling --name label-studio heartexlabs/label-studio:latest label-studio start labeling --init"
alias lsf="cd ~/Git/label-studio-frontend"
alias lso="cd ~/Git/label-studio"
alias lse="cd ~/Git/label-studio-enterprise"
alias lsp="cd ~/Git/label-studio-enterprise/label-studio-private/label_studio/frontend"
alias dm="cd ~/Git/dm2"
alias ecm='git commit --allow-empty -m "trigger ci" && git push'

alias venv-create='mkdir -p ~/py-env && python3 -m venv ~/py-env/htx'
alias venv-drop='rm -rf ~/py-env/htx'
alias venv='source ~/py-env/htx/bin/activate'
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
alias gd="gh dash"
alias lg="lazygit"

# Cargo
alias cargo-watch='cargo watch -i "www/*" -i .gitignore -i "pkg/*" -s "wasm-pack build --dev"'

# Tmux shortcuts
alias tma='tmux attach -t'
alias tms='tmux new -s'
alias vimconfig='cd ~/.config/$NVIM_APPNAME/ && nvim'
alias txl='tmuxifier load-session'
alias txe='tmuxifier edit-session'
alias txn='tmuxifier new-session'

alias x='clear && tmux clear-history'
alias sc='source ~/.zshrc'
alias f="ranger"

# Github workflows
alias gwls='gh workflow list'
alias gws='gh workflow view'
alias gwr='gh workflow run'

# Specific workflows
# alias gwr-sass='echo {"ref": $0, "deploy_to_prod": true, "sure": "sure"} gwr 30106738'
#
alias gws-sass='gws 30106738'

alias jira="jirust"
alias jj="jirust"
alias ld="lazydocker"
