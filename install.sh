#!/usr/bin/env bash

set -xe

AUR_HELPER="yay"

install_base_packages() {
    sudo pacman -S --needed --noconfirm \
    base-devel networkmanager ansible acpi bluez bluez-utils blueman pavucontrol brightnessctl \
    network-manager-applet fish \
    git wget gcc make sqlite unzip tree jq tmux ffmpeg fzf yt-dlp \
    hugo bottom ripgrep difftastic man-pages man-db less \
    firefox  syncthing fuzzel feh zathura zathura-pdf-poppler \
    telegram-desktop mpv sshfs \
    nodejs npm go php \
    stylua lua-language-server python-lsp-server typescript-language-server tinymist \
    marksman gopls tailwindcss-language-server \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-jetbrains-mono-nerd gnu-free-fonts
}

install_hyprland_packages() {
    sudo pacman -S --needed --noconfirm \
    hyprland hyprpaper hyprlock xdg-desktop-portal-hyprland hypridle hyprsunset mako \
    hyprpolkitagent \
    waybar wf-recorder wl-clipboard slurp grim python-pywal
}

manage_keys() {
    mkdir -p ~/.ssh
    ansible-vault decrypt ./keys/*
    cp -rv ./keys/* ~/.ssh/
    ansible-vault encrypt ./keys/*
}

manage_stash() {
    mkdir -p ~/.db
    git clone git@github.com:musaubrian/stash ~/personal/stash --depth=1
    pushd ~/persona/stash

    ansible-vault decrypt ./db/* ./wakatime/*
    cp -v ./db/* ~/.db
    cp -v ./wakatime/wakatime.cfg ~/.wakatime.cfg
    ansible-vault encrypt ./db/* ./wakatime/*

    popd
}

enable_services() {
    sudo systemctl enable NetworkManager
    sudo systemctl enable sshd
    sudo systemctl enable bluetooth.service
}

install_aur_packages() {
    if ! command -v $AUR_HELPER &> /dev/null;then
        pushd /tmp
        git clone https://aur.archlinux.org/$AUR_HELPER.git
        pushd $AUR_HELPER
        makepkg -si
        popd #out aur_helper
        popd #out tmp
    fi

    $AUR_HELPER -S --needed --noconfirm \
        nwg-look pnpm

}

setup_git_repo() {
    git remote remove origin
    git remote add origin git@github.com:musaubrian/nixe
}

install_filemanager() {
    sudo pacman -S --needed --noconfirm \
        thunar \
        gvfs \
        gvfs-smb \
        gvfs-afc \
        gvfs-mtp \
        gvfs-nfs \
        gvfs-goa \
        gvfs-gphoto2 \
        sshfs \
        thunar-archive-plugin \
        thunar-volman
}

setup_dots() {
    stow -t ~ caddy fuzzel git hypr jj kitty mako nvim scripts shell walls waybar fish -v 2
}

main() {
    install_base_packages
    install_filemanager
    install_aur_packages
    install_hyprland_packages
    enable_services

    setup_dots

    manage_keys
    manage_stash
    setup_git_repo

    sudo chsh -s $(which fish) #drink fish koolaid
}

main
