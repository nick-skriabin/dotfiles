# Vim mode
export KEYTIMEOUT=20
export VI_MODE_SET_CURSOR=true
set editing-mode vi
bindkey -v
bindkey -M viins jj vi-cmd-mode

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
