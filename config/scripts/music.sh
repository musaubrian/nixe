#!/usr/bin/env bash

pushd ~/Music

yt-dlp -f "bestaudio[ext=m4a]/bestaudio[ext=mp3]/bestaudio" $1

popd

