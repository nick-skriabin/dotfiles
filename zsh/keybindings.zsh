# Vim mode
export KEYTIMEOUT=20
export VI_MODE_SET_CURSOR=true

# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# The prompt cursor in normal mode
export ZVM_NORMAL_MODE_CURSOR

export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

# set editing-mode vi
# bindkey -v
# bindkey -M viins jj vi-cmd-mode
# bindkey -v '^?' backward-delete-char

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
        for c in {a,i}{\',\",\`}; do
                bindkey -M $m $c select-quoted
        done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
        for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
                bindkey -M $m $c select-bracketed
        done
done

