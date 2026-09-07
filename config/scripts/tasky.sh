#!/usr/bin/env bash

## kill processes because `awk` is pretty good
raw_process=$(ps ax | fuzzel --dmenu -p"process ")
process=$(echo "$raw_process"| awk 'NR== 1{ print $1 }')
process_name=$(echo "$raw_process"| awk 'NR== 1{ print $5 }')

if [[ -n "$process" && -n "$process_name" ]]; then
  kill -9 "$process"
  notify-send "☠️ Tasky" "Killed process: $process_name" -u low
fi
