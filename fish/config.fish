if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source
fish_vi_key_bindings

set -U fish_greeting
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

source ~/.config/fish/conf.d/keys.fish
source ~/.config/fish/conf.d/env.fish
source ~/.config/fish/conf.d/path.fish
source ~/.config/fish/conf.d/aliases.fish
source ~/.config/fish/functions/*
