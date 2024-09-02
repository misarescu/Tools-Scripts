#!/bin/zsh

sed_replace_str=""

if [ $1 = "dark" ] 
then
    sed_replace_str='s/latte/mocha/g'
else 
    sed_replace_str='s/mocha/latte/g'
fi

sed -i ${sed_replace_str} ~/.tmux.conf
sed -i ${sed_replace_str} ~/.config/k9s/config.yaml
