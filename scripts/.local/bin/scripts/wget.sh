#!/usr/bin/env bash

downloads="$1"
url="$2"


if [ "$downloads" == "-d" ]; then
    pushd ~/Downloads/
    wget "$url"
    popd
else
    wget "$1"
fi
