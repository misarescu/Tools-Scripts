#!/bin/zsh

sed_replace_str=""
sed_replace_str_capital=""

if [[ $1 == "dark" ]]; then
    sed_replace_str='s/latte/mocha/g'
    sed_replace_str_capital='s/Latte/Mocha/g'
else 
    sed_replace_str='s/mocha/latte/g'
    sed_replace_str_capital='s/Mocha/Latte/g'
fi

sed -i '' -e "${sed_replace_str}" ~/.tmux.conf
sed -i '' -e "${sed_replace_str}" ~/Library/Application\ Support/k9s/config.yaml
sed -i '' -e "${sed_replace_str_capital}" ~/.config/bat/config