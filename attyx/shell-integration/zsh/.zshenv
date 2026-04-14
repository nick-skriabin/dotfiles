#!/bin/zsh
# Attyx shell integration (zsh .zshenv)
# ZDOTDIR stays pointed at our integration dir so zsh also picks up
# our .zshrc wrapper (which re-installs hooks after user's .zshrc).
# Resolve user's original ZDOTDIR for sourcing their config files.
__ATTYX_ZDOTDIR="${__ATTYX_ORIGINAL_ZDOTDIR:-$HOME}"
if [[ -n "$__ATTYX_BIN_DIR" ]] && [[ ":$PATH:" != *":$__ATTYX_BIN_DIR:"* ]]; then
  export PATH="$__ATTYX_BIN_DIR:$PATH"
fi
unset __ATTYX_BIN_DIR
# OSC 7: report cwd on directory changes and on every prompt
# Write to stderr so OSC sequences reach the terminal even when stdout
# is redirected (e.g. --wait capture pipe).
__attyx_chpwd() { printf '\e]7;file://%s%s\a' "${HOST}" "${PWD}" >&2 }
# OSC 7337: report PATH for popup commands
__attyx_report_path() { printf '\e]7337;set-path;%s\a' "$PATH" >&2 }
# Execute startup command after full shell init, then remove the hook
__attyx_startup() {
  __attyx_chpwd; __attyx_report_path
  if [[ -n "$__ATTYX_STARTUP_CMD" ]]; then
    local cmd="$__ATTYX_STARTUP_CMD"
    unset __ATTYX_STARTUP_CMD
    eval "$cmd"
  fi
}
__attyx_precmd() { __attyx_chpwd; __attyx_report_path }
# Run startup hook once on first prompt, then switch to normal precmd
__attyx_first_precmd() {
  __attyx_startup
  precmd_functions=(${precmd_functions:#__attyx_first_precmd} __attyx_precmd)
}
# Source user's .zshenv
[[ -f "$__ATTYX_ZDOTDIR/.zshenv" ]] && source "$__ATTYX_ZDOTDIR/.zshenv"
# Sensible history defaults — only set if user hasn't configured them.
# Without these, zsh defaults to SAVEHIST=0 (no history saved to disk).
[[ -z "$HISTFILE" ]] && export HISTFILE="$HOME/.zsh_history"
(( HISTSIZE <= 100 )) && HISTSIZE=10000
(( SAVEHIST <= 0 )) && SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS 2>/dev/null
# Emit initial CWD report
__attyx_chpwd
