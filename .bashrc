export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

alias ll="ls -lh"
alias la="ls -ah"
alias lla="ls -alh"

alias mv="mv -i"
alias cp="cp -i"

alias clr="clear"
alias cls="clear"

# nvim
alias vi="nvim"
alias vim="nvim"

# git
alias ga="git add"
alias gcm="git commit -m"
alias gbr="git branch"
alias gco="git checkout"
alias gs="git status"
alias gdiff="git diff"
alias gpull="git pull"
alias gpush="git push"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias lg="lazygit"

# tmux
alias tn='tmux new-session -s main'
alias ta='tmux attach'
alias tls='tmux ls'
alias tk='tmux kill-session -t'

# openlist
alias ols="cd ~/.config/openlist && openlist server"


parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

PS1="╭─["
PS1+="\[\033[1;34m\]\u"
PS1+="\[\033[0m\]@"
PS1+="\[\033[1;33m\]\h"
PS1+="\[\033[0m\]:"
PS1+="\[\033[1;36m\]\w"
PS1+="\[\033[1;32m\]\$(parse_git_branch)"
PS1+="\[\033[0m\]]—(\t)"
PS1+="\n╰─ "
PS1+="\[\033[1;37m\]\$"
PS1+="\[\033[1;36m\] > \[\033[0m\]"

PS2="\[\033[1;36m\] → \[\033[0m\]"

export PS1
export PS2
