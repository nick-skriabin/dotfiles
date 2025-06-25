# Global settings - minimal for instant loading
export HOMEBREW_PREFIX=/opt/homebrew
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export XDG_CONFIG_HOME="$HOME/.config"
export collect_analytics=false
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
export TERM_PROGRAM=kitty

# Set TERM more safely
if [[ "$TERM_PROGRAM" == "kitty" ]]; then
  # Try xterm-kitty first, fallback to xterm-256color
  if infocmp xterm-kitty >/dev/null 2>&1; then
    export TERM=xterm-kitty
  else
    export TERM=xterm-256color
  fi
else
  export TERM=${TERM:-xterm-256color}
fi

export FZF_PATH=$HOME/.fzf

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

# Set slow environment variables synchronously (no background jobs)
export CPU_NUMBER=$(sysctl -n hw.ncpu 2>/dev/null || echo "4")
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix 2>/dev/null || echo "/opt/homebrew")/lib:$DYLD_FALLBACK_LIBRARY_PATH"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#000000,bg:#000000,spinner:#aaaaaa,hl:#D70000 \
--color=fg:#aaaaaa,header:#D70000,info:#7788AA,pointer:#f5e0dc \
--color=marker:#7788AA,fg+:#cdd6f4,prompt:#cba6f7,hl+:#D70000 \
--color=selected-bg:#45475a \
--multi"
