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
alias la='ls -AF'
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

# Display time in top right corner (currently buggy)
#(clock &)

# Hook for finding commands
source /usr/share/doc/pkgfile/command-not-found.bash

# Git prompt
if [ -f ~/app/bash/git-prompt.sh ]; then
    source ~/app/bash/git-prompt.sh
fi

# Prompt string
#PS1='[\u@\h \W]\$ ' # Default

set_prompt () {
    Last=$(printf "%03d" $?)
    PS1="\[\e[s\e[1;$(($COLUMNS-18))H$BPurple\]\d \@\[\e[u\]"
    if [[ $Last == "000" ]]; then
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
    Branch=$(__git_ps1 "[%s]")
    PS1+="\u\[$Yellow\]@\h \[$BYellow\]$Branch\[$BCyan\]\w\n"
    if [[ $EUID == 0 ]]; then
        PS1+="\[$BRed\]"
    else
        PS1+="\[$BGreen\]"
    fi
    PS1+="\$ \[$BWhite\]"
}
PROMPT_COMMAND='set_prompt'

# Type commands in bold white, see output in regular white
trap 'echo -ne "$Reset"' DEBUG

# Custom cd
if [ -f ~/app/bash/mycd.sh ]; then
    source ~/app/bash/mycd.sh
fi

# Send signal to rewrap text on window size change
shopt -s checkwinsize
