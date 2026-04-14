#!/bin/zsh
# Attyx shell integration (zsh .zshrc)
# Restore ZDOTDIR so subsequent zsh invocations use user's config
if [[ -n "$__ATTYX_ORIGINAL_ZDOTDIR" ]]; then
  ZDOTDIR="$__ATTYX_ORIGINAL_ZDOTDIR"
elif [[ -z "$__ATTYX_ORIGINAL_ZDOTDIR" ]]; then
  ZDOTDIR="$HOME"
fi
unset __ATTYX_ORIGINAL_ZDOTDIR
# Source user's .zshrc
[[ -f "$ZDOTDIR/.zshrc" ]] && source "$ZDOTDIR/.zshrc"
# Re-install hooks — user's .zshrc may have reset the arrays
[[ -z "${chpwd_functions[(r)__attyx_chpwd]}" ]] && chpwd_functions+=(__attyx_chpwd)
if [[ -z "${precmd_functions[(r)__attyx_precmd]}" ]] && [[ -z "${precmd_functions[(r)__attyx_first_precmd]}" ]]; then
  precmd_functions+=(__attyx_first_precmd)
fi
