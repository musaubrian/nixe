#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Error: Please provide an input directory"
    echo "Usage: $0 /path/to/input/directory"
    exit 1
fi

input_dir=$1

# Verify input is a directory
if [ ! -d "$input_dir" ]; then
    echo "Error: '$input_dir' is not a valid directory"
    exit 1
fi
pushd "$input_dir"

for file in "$input_dir"/*; do
    # Check if the file is a video file
    if [[ $file != *.mp3 ]]; then
        output_file="${file%.*}.mp3"
        echo "$file $output_file"
        if ffmpeg -i "$file" "$output_file"; then
            echo "Transcoded $(basename "$file") to mp3"
        else
            echo "Error converting $(basename "$file")"
        fi
    fi
done

popd
