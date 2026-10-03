#!/usr/bin/env bash

set -xe

manage_keys() {
    ansible-vault decrypt ./keys/*
    cp -rv ./keys/* ~/.ssh/
    ansible-vault encrypt ./keys/*
}

manage_stash() {
    pushd ~/personal/stash

    ansible-vault decrypt ./db/*
    cp -rv ./db/* ~/.db/
    ansible-vault encrypt ./db/*

    popd
}

main() {
    manage_keys
    manage_stash
}

main
