#!/usr/bin/env bash

brightnessctl s 70
setxkbmap -option caps:escape
nm-applet &
feh --bg-fill "$HOME/personal/nixe/config/wall.jpg" &
"$HOME/personal/nixe/config/scripts/dwm-bar.sh" &

xset s 600 600
xset dpms 0 0 900
xss-lock --transfer-sleep-lock -- "i3lock --nofork--color=#171717 && sleep 5 && xset dpms force off && systemctl suspend" &
