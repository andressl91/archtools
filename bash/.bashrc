#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# >>> Added by cnchi installer
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano

#USER DEFINED 
alias gs='git status'
alias tailf='tailf -n 100 f'
alias cd..='cd ../../'
alias cd...='cd ../../../'
