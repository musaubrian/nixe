#!/usr/bin/env bash

input_dir=""

if [ $# -eq 0 ]; then
    input_dir="$HOME/Music"
    echo "WARN: input dir not specified using default $input_dir"
else
    input_dir=$1
fi


# Verify input is a directory
if [ ! -d "$input_dir" ]; then
    echo "Error: '$input_dir' is not a valid directory"
    exit 1
fi
pushd "$input_dir"

for file in "$input_dir"/*; do
    if [[ $file != *.mp3 ]]; then
        output_file="${file%.*}.mp3"
        if ffmpeg -i "$file" "$output_file"; then
            echo "Transcoded $(basename "$file") to mp3"
            rm -v "$file"
        else
            echo "Error converting $(basename "$file")"
        fi
    fi
done

popd
