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
  export BASE_OPTS="--preview='bat --color=always {}' --layout=reverse-list --preview-window=top,70% --tmux=center,90% --multi"
  # export FZF_DEFAULT_OPTS="--preview='bat --color=always {}' --layout=reverse-list --preview-window=top,70% --multi"
  declare -A themes

  themes["light"]=" \
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
    --color=selected-bg:#bcc0cc \
    --color=border:#ccd0da,label:#4c4f69"
  themes["dark"]="\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --color=border:#313244,label:#cdd6f4"

  export FZF_DEFAULT_OPTS="${BASE_OPTS} ${themes["$1"]}"
}

if [[ $1 == "dark" ]]; then
    sed_replace_str='s/latte/mocha/g'
    sed_replace_str_capital='s/Latte/Mocha/g'
    switch_vim_theme "dark"
    set_fzf_theme "dark"
else 
    sed_replace_str='s/mocha/latte/g'
    sed_replace_str_capital='s/Mocha/Latte/g'
    switch_vim_theme "light"
    set_fzf_theme "light"
fi

# sed -i -e "${sed_replace_str}" ~/.tmux.conf
sed -i -e "${sed_replace_str}" ~/.config/k9s/config.yaml
sed -i -e "${sed_replace_str_capital}" ~/.config/bat/config

# tmux source ~/.tmux.conf
