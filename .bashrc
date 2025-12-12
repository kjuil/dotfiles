### Completion
if [ -f /etc/bash_completion ]; then source /etc/bash_completion; fi

shopt -s histappend
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:erasedups



### Environment
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

### Alias
alias ll="ls -lhF"
alias la="ls -alhF"
alias mv="mv -i"
alias cp="cp -i"
alias c="clear"
alias vi="nvim"
alias vim="nvim"

# git
alias ga="git add"
alias gcm="git commit -m"
alias gb="git branch"
alias gco="git checkout"
alias gs="git status"
alias gdiff="git diff"
alias gpull="git pull"
alias gpush="git push"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lg="lazygit"

# tmux
alias tn="tmux new-session -s main"
alias ta="tmux attach"
alias tls="tmux ls"
alias trs="tmux rename-session -t"
alias tk="tmux kill-session -t"



### Command Prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}

PS1="╭─["
PS1+="\[\033[1;34m\]\u"
PS1+="\[\033[0m\]@"
PS1+="\[\033[1;33m\]\h"
PS1+="\[\033[0m\]] in "
PS1+="\[\033[1;36m\]  \w"
PS1+="\[\033[1;32m\]\$(parse_git_branch)"
PS1+=" \[\033[0m\]\$(printf \"%*s\" \$((\$(tput cols) - \$(echo -n \"\u\h\w\$(parse_git_branch)\" | wc -c) - 24)) \"\" | sed 's/ /·/g')\[\]"
PS1+="  \t"
PS1+="\n╰─ "
PS1+="\[\033[1;37m\]\$"
PS1+="\[\033[1;36m\] > \[\033[0m\]"

PS2="\[\033[1;36m\] → \[\033[0m\]"

export PS1
export PS2

