# Path - optimized for faster loading
# Core paths
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$PATH"

# Development tools
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.yarn/bin:$PATH"

# Language-specific paths
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/.cargo/env:$PATH"

# Android SDK (only if directory exists)
if [[ -d "$ANDROID_HOME" ]]; then
  export PATH="$PATH:$ANDROID_HOME/tools"
  export PATH="$PATH:$ANDROID_HOME/tools/bin"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi

# Flutter (only if directory exists)
if [[ -d "$HOME/development/flutter/bin" ]]; then
  export PATH="$HOME/development/flutter/bin:$PATH"
fi

# Go (only if GOPATH is set)
if [[ -n "$GOPATH" ]]; then
  export PATH="$GOPATH/bin:$PATH"
fi

# Additional paths (only if they exist)
[[ -d "/usr/local/mysql/bin" ]] && export PATH="/usr/local/mysql/bin:$PATH"
[[ -d "/opt/local/bin" ]] && export PATH="/opt/local/bin:$PATH"
[[ -d "/opt/local/sbin" ]] && export PATH="/opt/local/sbin:$PATH"
[[ -d "$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin" ]] && export PATH="$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH"
