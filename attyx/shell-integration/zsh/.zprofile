#!/bin/zsh
# Attyx shell integration (zsh .zprofile)
__ATTYX_ZDOTDIR="${__ATTYX_ORIGINAL_ZDOTDIR:-$HOME}"
[[ -f "$__ATTYX_ZDOTDIR/.zprofile" ]] && source "$__ATTYX_ZDOTDIR/.zprofile"
