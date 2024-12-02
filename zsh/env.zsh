# Global settings
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export XDG_CONFIG_HOME="$HOME/.config"
export CPU_NUMBER=$(sysctl -n hw.ncpu)
export collect_analytics=false

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
