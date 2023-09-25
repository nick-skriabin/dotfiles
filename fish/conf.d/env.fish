# Global settings
set LDFLAGS -L/usr/local/opt/zlib/lib
set CPPFLAGS -I/usr/local/opt/zlib/include
set PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig
set CPU_NUMBER $(sysctl -n hw.ncpu)
set collect_analytics false

# CPP
set LDFLAGS "-L/usr/local/opt/node@14/lib"
set CPPFLAGS "-I/usr/local/opt/node@14/include"

set EDITOR nvim
set ANDROID_HOME /Users/nicholasrq/Library/Android/sdk
set GOOGLE_APPLICATION_CREDENTIALS "/Users/nicholasrq/gcs-credentials.json"

# For Jira <> Slack
set JIRA_API_TOKEN O7aP8E3hp6eBYwyyV7h85B21
set JIRA_USER "robot-ci@heartex.com"
set JIRA_URL "https://heartex.atlassian.net"

# Docker M1
set DOCKER_BUILDKIT 1
set COMPOSE_DOCKER_CLI_BUILD 1
# set DOCKER_DEFAULT_PLATFORM=lienux/amd64

set NODE_ENV development
set NODE_NO_WARNINGS 1
set -e NODE_OPTIONS
# set NODE_OPTIONS="--max-old-space-size=8192"

# Vim
set MYVIMRC $HOME/.config/nvim/init.lua
set NVIM_APPNAME lazynvim
set TMUX_FZF_LAUNCH_KEY C-f
