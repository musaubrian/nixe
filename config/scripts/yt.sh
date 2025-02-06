#!/usr/bin/env bash


cd ~/Videos/yt || exit

yt-dlp -f "bestvideo[ext=mp4][vcodec^=avc]+bestaudio[ext=m4a]/best[ext=mp4]/best" $1
