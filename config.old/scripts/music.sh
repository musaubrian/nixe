#!/usr/bin/env bash

pushd ~/Music

yt-dlp -f "bestaudio[ext=m4a]/bestaudio[ext=mp3]/bestaudio" $1

# change title removing ytdlp's wierd `[chars]` values
python3 ~/scripts/titly.py m

echo "DONE: run ~/scripts/reformat to convert all audio to mp3"
popd

