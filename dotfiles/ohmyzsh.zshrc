export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export EDITOR=$(which nvim)
alias vim=nvim
alias vi=nvim

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="apple"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git you-should-use zsh-syntax-highlighting zsh-autosuggestions golang docker docker-compose kubectl tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias task='go-task'

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/istio-1.21.0/bin
export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH
# loop and extract all kube config files automatically
export KUBECONFIG=
for kube_file in $(find $HOME/.kube -maxdepth 1 -type f)
do
KUBECONFIG=$KUBECONFIG:$kube_file
done
# reset go env stuff here
go env -w GONOSUMDB=''
go env -w GOPROXY=direct
go env -w GOPRIVATE=''

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
PATH=$(pyenv root)/shims:$PATH

# set correct cli tools theme
export DARK_MODE=light
if [[ $(uname) == 'Darwin' ]]; then
        if [[ $(osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode') == true ]]; then
                export DARK_MODE=dark
        fi
else
	if [[ $(gsettings get org.gnome.desktop.interface color-scheme) == "'prefer-dark'" ]]; then
                export DARK_MODE=dark
        fi
fi

source ~/terminal-themes.sh $DARK_MODE

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source <(fzf --zsh)
source <(zoxide init zsh --cmd cd)

export FZF_DEFAULT_OPTS="--preview='bat --color=always {}' --tmux=center,90% --layout=reverse-list --preview-window=top,70% --multi"
export FZF_ALT_C_OPTS="--preview='tree -c {}'"
export FZF_CTRL_R_OPTS="--height 50% --preview 'echo {2..} | bat --color=always -pl sh' --tmux=center,75% --preview-window='wrap,up,50%'"

RELOAD='reload:rg --column --color=always --smart-case {q} || :'
OPENER_VIM='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
		$EDITOR {1} +{2}     # No selection. Open the current line in Vim.
	else
		$EDITOR +cw -q {+f}  # Build quickfix list for the selected items.
	fi'
OPENER_CODE='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                code --goto {1}:{2}:{3} .    # No selection. Open the current line in Vim.
	else
		code {+f}  # Build quickfix list for the selected items.
	fi'
# ripgrep > fzf > vim
function rfv() {
    fzf --disabled --ansi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER_VIM" \
      --bind "ctrl-o:execute:$OPENER_VIM" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
}

# ripgrep > fzf > vscode
function rfc() {
    fzf --disabled --ansi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER_CODE" \
      --bind "ctrl-o:execute:$OPENER_CODE" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --query "$*"
}

# ripgrep search with fzf
function rf() {
    fzf --disabled --ansi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --query "$*"
}

# fzf > vim
function fzfv() {
    fzf --bind "enter:become:$OPENER_VIM" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --query "$*"
}

# fzf > vscode
function fzfc() {
    fzf --bind "enter:become:$OPENER_CODE" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --query "$*"
}
