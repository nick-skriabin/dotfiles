if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source
fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

source ./conf.d/keys.fish
source ./conf.d/env.fish
source ./conf.d/path.fish
source ./conf.d/aliases.fish
source ./conf.d/scripts.fish
