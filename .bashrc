export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

[ -f "$HOME/.config/bash/prompt" ] && source "$HOME/.config/bash/prompt"
[ -f "$HOME/.config/bash/aliases" ] && source "$HOME/.config/bash/aliases"
[ -f "$HOME/.config/bash/function" ] && source "$HOME/.config/bash/function"
[ -f /etc/bash_completion ] && source "/etc/bash_completion"

