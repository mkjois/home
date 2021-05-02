# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash colors/symbols, aliases, env vars
test -f ~/.bash_fonts   && source ~/.bash_fonts
test -f ~/.bash_enviros && source ~/.bash_enviros
test -f ~/.bash_aliases && source ~/.bash_aliases

# iTerm2 integrations
test -e ~/.iterm2_shell_integration.bash && source ~/.iterm2_shell_integration.bash

# Git prompt
if test -f ~/lib/git-prompt.sh; then
    source ~/lib/git-prompt.sh
elif test -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh; then
    source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

# Autocompletion
if type brew > /dev/null 2>&1; then

    test -f $(brew --prefix)/etc/bash_completion \
        && source $(brew --prefix)/etc/bash_completion
    test -d $(brew --prefix)/etc/bash_completion.d \
        && source $(brew --prefix)/etc/bash_completion.d/*

    if test -f ~/lib/git-completion.bash; then
        source ~/lib/git-completion.bash
    elif test -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash; then
        source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
    fi
fi

# AWS CLI autocompletion
which aws_completer > /dev/null 2>&1 && complete -C "$(which aws_completer)" aws

set_prompt () {
    Last=$(printf "%03d" $?)
    PS1=""
    [[ $Last == "000" ]] && PS1+="\[$DGreen\]" || PS1+="\[$DRed\]"
    PS1+="$Last "
    [[ $EUID == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    Branch=$(__git_ps1 "[%s]")
    PS1+="\u\[$DYellow\]@qc \[$BPurple\]$Branch\[$BBlue\]\w\n"
    [[ $EUID == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    PS1+="\$ \[$BBlack\]"
    [[ $EUID == 0 ]] && PS2="\[$BRed\]> \[$BBlack\]" || PS2="\[$BGreen\]> \[$BBlack\]"
    [[ $EUID == 0 ]] && PS4="\[$BRed\]+ \[$BBlack\]" || PS4="\[$BGreen\]+ \[$BBlack\]"
}
PROMPT_COMMAND='set_prompt'

# Reset color after command is entered
trap 'echo -ne $Reset' DEBUG

# Send signal to rewrap text on window size change
shopt -s checkwinsize

# Command history
shopt -s cmdhist
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=ignoreboth
export HISTIGNORE='d:g:l:la:ll:lr:ls:bg:fg:jobs:clear:reset:exit:history'
