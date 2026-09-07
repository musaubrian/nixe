#!/usr/bin/env bash

usage() {

    echo "[ERROR]: $1
Usage:
    $0 [a/m] <title>"
    exit 1
}

if [ $# -eq 0 ]; then
    usage "Please provide an option"
fi

if [[ -z $2 ]]; then
    usage "Missing identifier(title)"
fi


TITLE="$2"
FILENAME="$(date +%Y%m%d_%H%M%S)_$TITLE.mkv"
OUT_FILE="$HOME/Videos/vids/$FILENAME"

if [ "$1" == "a" ]; then
    echo "
Recording with audio to
[ $OUT_FILE ]
"
wf-recorder -a -f "$OUT_FILE"
elif [ "$1" == "m" ]; then
    echo "
Recording without audio to
[ $OUT_FILE ]
"
wf-recorder -f "$OUT_FILE"
else
    usage "Unkown option"
fi
