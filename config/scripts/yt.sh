#!/usr/bin/env bash


pushd ~/Videos/yt

yt-dlp \
  --cookies-from-browser firefox \
  --remote-components ejs:github \
  -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" \
  --merge-output-format mp4 \
  "$1"

popd
