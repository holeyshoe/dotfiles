#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="vim"

#aliases
alias ls='ls -h --color=auto'
alias steam='wine ~/.wine/drive_c/Program\ Files/Steam/Steam.exe >/dev/null 2>&1 &'
alias df='df -h'

# PS1='[\u@\h \W]\$ '
PS1='\[\e[0;32m\][\u@\h \W]\$\[\e[0m\]'
