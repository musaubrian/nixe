#!/usr/bin/env bash

# watches for copy-to-clipboard
# and saves it to a hist file
PLACEHOLDER="<NL>"
CLIP_HIST="$HOME/.cache/clip_history"
OPT="$1"


[ -f "$CLIP_HIST" ] || touch "$CLIP_HIST"

watch_clip() {
  while true; do
    raw=$(xclip -selection clipboard -o 2>/dev/null)
    current="$(echo "$raw" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

    [ -z "$current" ] && continue #skip if empty

    # flatten only if multiline
    if [[ "$current" == *$'\n'* ]]; then
      flattened_multiline=$(echo "$current" | sed ':a;N;$!ba;s/\n/'"$PLACEHOLDER"'/g')
    else
      flattened_multiline="$current"
    fi

    grep -Fxq "$flattened_multiline" "$CLIP_HIST" || echo "$flattened_multiline" >> "$CLIP_HIST"

    sleep 0.3
  done
}

copy() {
  sel="$(tac $CLIP_HIST | rofi -dmenu -p clipboard-history)"
  [ -n "$sel" ] &&  echo "$sel" | sed "s/$PLACEHOLDER/\n/g" | xclip -i -selection clipboard
}

usage() {
  echo "Usage:
  cliphist <watch|copy>"
  exit 1
}

[ -z "$OPT" ] && usage

if [[ "$OPT" == "watch" ]]; then
  watch_clip
elif [[ "$OPT" == "copy" ]]; then
  copy
else
  usage
fi
