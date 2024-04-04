setopt autocd
setopt magicequalsubst
setopt notify
setopt promptsubst
setopt numericglobsort 
setopt ksharrays

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'


export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT=$'${COLOR_USR}┌──(%n) ${COLOR_DIR}[%~]${COLOR_GIT}$(parse_git_branch)${COLOR_USR}\n└─${COLOR_DEF}$ '
autoload -Uz compinit && compinit
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
PATH=$(pyenv root)/shims:$PATH
