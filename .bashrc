case $- in
    *i*) ;;
      *) return;;
esac

### Env
export EDITOR="nvim"
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%F %T  "
shopt -s histappend



### Prompt
__git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " ($branch)"
}

C_RESET='\[\e[0m\]'
C_RED='\[\e[0;31m\]'
C_GREEN='\[\e[0;32m\]'
C_YELLOW='\[\e[0;33m\]'
C_BLUE='\[\e[0;34m\]'
C_CYAN='\[\e[0;36m\]'

if [[ $EUID -eq 0 ]]; then
    C_USER=${C_RED}
    USER="#"
else
    C_USER=${C_BLUE}
    USER="\$"
fi

PS1="╭─["
PS1+="${C_USER}\u"
PS1+="${C_RESET}@"
PS1+="${C_YELLOW}\h"
PS1+="${C_RESET} in "
PS1+="${C_CYAN}  \w"
PS1+="${C_GREEN}\$(__git_branch)"
PS1+=" ${C_RESET}\$(printf \"%*s\" \$((\$(stty size 2>/dev/null | awk '{print \$2}') - \$(echo -n \"\u\h\w\$(__git_branch)\" | wc -c) - 24)) \"\" | sed 's/ /·/g')\[\]"
PS1+="${C_YELLOW}  \t"
PS1+="\n${C_RESET}╰─ ${USER}"
PS1+="${C_CYAN} > ${C_RESET}"

PS2="${C_CYAN} → ${C_RESET}"

export PS1
export PS2



### Alias
# basic
alias ls="ls --color=auto"
alias ll="ls -lAhF --color=auto"
alias la="ls -A --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias c="clear"
alias vi="nvim"
alias vim="nvim"
alias tree="tree -C --dirsfirst"

# git
alias ga="git add"
alias gcm="git commit -m"
alias gb="git branch"
alias gco="git checkout"
alias gs="git status"
alias gd="git diff"
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



## Functions
extract() {
    if [[ ! -f "$1" ]]; then
        echo "错误: '$1' 不是有效文件" >&2
        return 1
    fi
    case "$1" in
        *.tar.bz2)   tar xjf "$1"   ;;
        *.tar.gz)    tar xzf "$1"   ;;
        *.tar.xz)    tar xJf "$1"   ;;
        *.bz2)       bunzip2 "$1"   ;;
        *.rar)       unrar x "$1"   ;;
        *.gz)        gunzip "$1"    ;;
        *.tar)       tar xf "$1"    ;;
        *.tbz2)      tar xjf "$1"   ;;
        *.tgz)       tar xzf "$1"   ;;
        *.zip)       unzip "$1"     ;;
        *.Z)         uncompress "$1";;
        *.7z)        7z x "$1"      ;;
        *.xz)        xz -d "$1"     ;;
        *.zst)       zstd -d "$1"   ;;
        *)           echo "无法识别的压缩格式: '$1'" >&2; return 1 ;;
    esac
}

fcd() {
    local dir
    dir=$(find "${1:-.}" -type d 2>/dev/null | fzf --preview 'ls -la {}')
    [[ -n "$dir" ]] && cd "$dir"
}

serve() {
    local port="${1:-8000}"
    echo "在 http://localhost:$port 启动文件服务器..."
    python3 -m http.server "$port"
}



### Tool
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

if command -v fzf &>/dev/null; then
    eval "$(fzf --bash)" 2>/dev/null
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
fi


