#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    pkg=$(pacman -Qe | fzf | awk '{print $1}')
    [ -n "$pkg" ] && sudo pacman -Rns $pkg
else
    sudo pacman -Rns $1
fi
