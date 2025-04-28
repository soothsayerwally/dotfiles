# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export LS_COLORS="$(echo $LS_COLORS | sed -E 's/;4[0-7]//g')"

alias emacs="emacs -nw"
