# Global set -Uxtings
set -Ux LDFLAGS -L/usr/local/opt/zlib/lib
set -Ux CPPFLAGS -I/usr/local/opt/zlib/include
set -Ux PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig
set -Ux CPU_NUMBER $(sysctl -n hw.ncpu)
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux collect_analytics false

# CPP
set -Ux LDFLAGS "-L/usr/local/opt/node@14/lib"
set -Ux CPPFLAGS "-I/usr/local/opt/node@14/include"

set -Ux EDITOR nvim
set -Ux ANDROID_HOME /Users/nicholasrq/Library/Android/sdk
set -Ux GOOGLE_APPLICATION_CREDENTIALS "/Users/nicholasrq/gcs-credentials.json"

# For Jira <> Slack
set -Ux JIRA_API_TOKEN O7aP8E3hp6eBYwyyV7h85B21
set -Ux JIRA_USER "robot-ci@heartex.com"
set -Ux JIRA_URL "https://heartex.atlassian.net"

# Docker M1
set -Ux DOCKER_BUILDKIT 1
set -Ux COMPOSE_DOCKER_CLI_BUILD 1
# set -Ux DOCKER_DEFAULT_PLATFORM=lienux/amd64

set -Ux NODE_ENV development
set -Ux NODE_NO_WARNINGS 1
set -e NODE_OPTIONS
# set -Ux NODE_OPTIONS="--max-old-space-size=8192"

# Vim
set -Ux NVIM_APPNAME lazynvim

set -Ux GIT_PAGER delta
