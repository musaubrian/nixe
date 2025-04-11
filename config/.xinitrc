#!/usr/bin/env sh

eval "$(dbus-launch --sh-syntax --exit-with-session)"

#brightnessctl s 70
#setxkbmap -option caps:escape
#nm-applet &
#feh --bg-fill $HOME/personal/nixe/config/wall.jpg &
#$HOME/personal/nixe/config/scripts/dwm-bar.sh $

#xset s 600 600
#xset dpms 0 0 900
#xss-lock --transfer-sleep-lock -- "slock && sleep 5 && xset dpms force off && systemctl suspend" &

exec dwm
