# Global settings
export HOMEBREW_PREFIX=/opt/homebrew
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export XDG_CONFIG_HOME="$HOME/.config"
export CPU_NUMBER=$(sysctl -n hw.ncpu)
export collect_analytics=false
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export TERM_PROGRAM=kitty
export TERM=xterm-kitty

# Misc
export THOR_MERGE=merge_tool_for_rails

# CPP
export LDFLAGS="-L/usr/local/opt/node@14/lib"
export CPPFLAGS="-I/usr/local/opt/node@14/include"

export EDITOR="nvim"
export DISABLE_PRY_RAILS=1
export ANDROID_HOME="/Users/nicholasrq/Library/Android/sdk"
export GOOGLE_APPLICATION_CREDENTIALS="/Users/nicholasrq/gcs-credentials.json"

export NODE_ENV=development
export NODE_NO_WARNINGS=1

# Vim
export MYVIMRC=$HOME/.config/nvim/init.lua
export TMUX_FZF_LAUNCH_KEY="C-f"

# Lib
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#000000,bg:#000000,spinner:#aaaaaa,hl:#D70000 \
--color=fg:#aaaaaa,header:#D70000,info:#7788AA,pointer:#f5e0dc \
--color=marker:#7788AA,fg+:#cdd6f4,prompt:#cba6f7,hl+:#D70000 \
--color=selected-bg:#45475a \
--multi"
