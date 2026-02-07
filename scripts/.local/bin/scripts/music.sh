#!/usr/bin/env bash

pushd ~/Music

yt-dlp --cookies-from-browser firefox --remote-components ejs:github -f "bestaudio[ext=m4a]/bestaudio[ext=mp3]/bestaudio" $1

# change title removing ytdlp's wierd `[chars]` values
python3 ~/.local/bin/scripts/titly.py m

echo "DONE: run ~/scripts/reformat to convert all audio to mp3"
popd

