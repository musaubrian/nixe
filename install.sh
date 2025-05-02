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

manage_syms() {
    IFS="="
    while read -r line; do
        if [[ -z "$line" || "$line" =~ ^# ]]; then
            continue
        fi
        # Extract destination and source
        dest=$(echo "$line" | awk '{print $1}' | tr -d ' ')
        src=$(echo "$line" | awk -F '=' '{print $2}' | tr -d ' ')

        eval "expanded_dest=$dest"

        ln -sv $(realpath $src) $expanded_dest
    done < ./syms
}

main() {
    sudo ln -sv "$(realpath ./config/configuration.nix)" /etc/nixos/configuration.nix

    echo "Building NixOS..."
    sudo nixos-rebuild switch &>/tmp/nixos-switch.log || \
        (cat /tmp/nixos-switch.log | grep error && false)

    manage_keys
    manage_stash

    home-manager switch --flake .#sminx
    manage_syms

    git remote remove origin
    git remote add origin git@github.com:musaubrian/nixe
}

# main
manage_syms
