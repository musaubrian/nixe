#!/usr/bin/env bash


pushd ~/Videos/yt
yt-dlp --cookies-from-browser firefox --remote-components ejs:github -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 "$1"

popd
