#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# commands with color
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# extra ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Bash colors and symbols
if [ -f ./.bash_fonts ]; then
    . ./.bash_fonts
fi

# Bash aliases
if [ -f ./.bash_aliases ]; then
    . ./.bash_aliases
fi

# Bash environment variables
if [ -f ./.bash_enviros ]; then
    . ./.bash_enviros
fi

# Hook for finding commands
source /usr/share/doc/pkgfile/command-not-found.bash

# Prompt string
#PS1='[\u@\h \W]\$ ' # Default

set_prompt () {
    Last=$?
    PS1=""
    if [[ $Last == 0 ]]; then
        PS1+="\[$Green\]"
    else
        PS1+="\[$Red\]"
    fi
    PS1+="$Last "
    if [[ $EUID == 0 ]]; then
        PS1+="\[$BRed\]"
    else
        PS1+="\[$BGreen\]"
    fi
    PS1+="\\u\[$BBlack\]@\\h \\s \[$Cyan\]\\d \\@ \\w\\n"
    if [[ $EUID == 0 ]]; then
        PS1+="\[$BRed\]"
    else
        PS1+="\[$BGreen\]"
    fi
    PS1+="\\\$\[$BWhite\] "
}
PROMPT_COMMAND='set_prompt'

# Type commands in bold white, see output in regular white
trap 'echo -ne "$Color_Off"' DEBUG

# Custom cd
if [ -f ~/play/bash/mycd.sh ]; then
    source ~/play/bash/mycd.sh
fi

# Send signal to rewrap text on window size change
shopt -s checkwinsize
