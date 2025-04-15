#!/usr/bin/env bash

manage_keys() {
    mkdir -p ~/.ssh
    ansible-vault decrypt ./keys/*
    cp -rv ./keys/* ~/.ssh/
    ansible-vault encrypt ./keys/*
}

manage_stash() {
    mkdir -p ~/.db

    git clone git@github.com:musaubrian/stash ~/personal/stash --depth=1
    pushd ~/personal/stash

    ansible-vault decrypt ./db/* ./wakatime/*
    cp ./db/* ~/.db/ -v
    cp ./wakatime/wakatime.cfg ~/.wakatime.cfg -v
    ansible-vault encrypt ./db/* ./wakatime/*

    popd
}

main() {
    sudo ln -sv "$(realpath ./config/configuration.nix)" /etc/nixos/configuration.nix

    echo "Building NixOS..."
    sudo nixos-rebuild switch &>/tmp/nixos-switch.log || \
        (cat /tmp/nixos-switch.log | grep error && false)

    manage_keys
    manage_stash

    home-manager switch --flake .#sminx

    git remote remove origin
    git remote add origin git@github.com:musaubrian/nixe
}

main
