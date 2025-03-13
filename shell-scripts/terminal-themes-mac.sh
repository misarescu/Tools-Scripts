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

if [[ $1 == "dark" ]]; then
    sed_replace_str='s/latte/mocha/g'
    sed_replace_str_capital='s/Latte/Mocha/g'
    switch_vim_theme "dark"
else 
    sed_replace_str='s/mocha/latte/g'
    sed_replace_str_capital='s/Mocha/Latte/g'
    switch_vim_theme "light"
fi

sed -i '' -e "${sed_replace_str}" ~/.tmux.conf
sed -i '' -e "${sed_replace_str}" ~/Library/Application\ Support/k9s/config.yaml
sed -i '' -e "${sed_replace_str_capital}" ~/.config/bat/config
