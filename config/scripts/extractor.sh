#!/usr/bin/env bash

file="$1"

if [ -z "$file" ]; then
    echo "Usage:
    $(basename "$0") <archive>"
    exit 1
fi

if [ ! -f "$file" ]; then
    echo "Error: '$file' not found"
    exit 1
fi

echo "Extracting: $file"

# Remove extension to create directory name
# Handle double extensions like .tar.gz, .tar.bz2
case "$file" in
    *.tar.gz)   dirname="${file%.tar.gz}" ;;
    *.tar.bz2)  dirname="${file%.tar.bz2}" ;;
    *.tar.xz)   dirname="${file%.tar.xz}" ;;
    *.tbz2)     dirname="${file%.tbz2}" ;;
    *.tgz)      dirname="${file%.tgz}" ;;
    *)          dirname="${file%.*}" ;;
esac

mkdir -p "$dirname"

# Extract based on file type
case "$file" in
    *.tar.bz2)   tar xjf "$file" -C "$dirname" --strip-components=1 ;;
    *.tar.gz)    tar xzf "$file" -C "$dirname" --strip-components=1 ;;
    *.tar.xz)    tar xJf "$file" -C "$dirname" --strip-components=1 ;;
    *.tar)       tar xf  "$file" -C "$dirname" --strip-components=1 ;;
    *.tbz2)      tar xjf "$file" -C "$dirname" --strip-components=1 ;;
    *.tgz)       tar xzf "$file" -C "$dirname" --strip-components=1 ;;
    *.bz2)       bunzip2 -c "$file" > "$dirname/$(basename "$file" .bz2)" ;;
    *.gz)        gunzip -c "$file" > "$dirname/$(basename "$file" .gz)" ;;
    *.zip)       unzip -q "$file" -d "$dirname" ;;
    *.rar)       unrar x "$file" "$dirname/" ;;
    *.7z)        7z x "$file" -o"$dirname" ;;
    *.Z)         uncompress -c "$file" > "$dirname/$(basename "$file" .Z)" ;;
    *)           echo "Error: Unsupported archive format"
                 rmdir "$dirname" 2>/dev/null
                 exit 1 ;;
esac

echo "Extracted to: $dirname/"
