#!/usr/bin/env bash


cd ~/Videos/yt || exit

yt-dlp -f "bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm]" "$1"
