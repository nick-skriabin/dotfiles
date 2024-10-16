if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source
tput cup $COLUMNS 0

set fish_key_bindings fish_user_key_bindings

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

set -U fish_greeting
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

source ~/.config/fish/conf.d/keys.fish
source ~/.config/fish/conf.d/env.fish
source ~/.config/fish/conf.d/path.fish
source ~/.config/fish/conf.d/aliases.fish
source ~/.config/fish/conf.d/hs_aws.fish
source ~/.config/fish/functions/*
