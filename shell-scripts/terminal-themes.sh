#!/bin/zsh

sed_replace_str=""
sed_replace_str_capital=""

# Function to switch theme in n(v)im panes inside tmux
switch_vim_theme() {
  theme_for_vim_panes="$1"
  tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
    grep vim | # this captures vim and nvim
    cut -d ' ' -f 1 |
    xargs -I PANE tmux send-keys -t PANE ESCAPE \
      ":set background=${theme_for_vim_panes}" ENTER
}

# Function to set the fzf theme 
set_fzf_theme() {
  export BASE_OPTS="--preview='bat --color=always {}' --layout=reverse-list --preview-window=top,70% --multi"
  # export FZF_DEFAULT_OPTS="--preview='bat --color=always {}' --layout=reverse-list --preview-window=top,70% --multi"
  declare -A themes

  themes["light"]=" \
    --color=fg:#797593,bg:#faf4ed,hl:#d7827e \
	  --color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e \
	  --color=border:#dfdad9,header:#286983,gutter:#faf4ed \
	  --color=spinner:#ea9d34,info:#56949f \
	  --color=pointer:#907aa9,marker:#b4637a,prompt:#797593" 
  themes["dark"]="\
    --color=fg:#908caa,bg:#232136,hl:#ea9a97 \
	  --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97 \
	  --color=border:#44415a,header:#3e8fb0,gutter:#232136
	  --color=spinner:#f6c177,info:#9ccfd8
	  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
  export FZF_DEFAULT_OPTS="${BASE_OPTS} ${themes["$1"]}"
}

if [[ $1 == "dark" ]]; then
    sed_replace_str='s/dawn/moon/g'
    # sed_replace_str_capital='s/Dawn/Moon/g'
    switch_vim_theme "dark"
    set_fzf_theme "dark"
else 
    sed_replace_str='s/moon/dawn/g'
    # sed_replace_str_capital='s/Moon/Dawn/g'
    switch_vim_theme "light"
    set_fzf_theme "light"
fi

# sed -i -e "${sed_replace_str}" ~/.tmux.conf
sed -i -e "${sed_replace_str}" ~/.config/k9s/config.yaml
sed -i -e "${sed_replace_str}" ~/.config/bat/config

# tmux source ~/.tmux.conf
