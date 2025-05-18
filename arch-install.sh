#!/usr/bin/env bash
set -e

AUR_HELPER=yay

install_packages() {
    echo "Installing packages..."
    sudo pacman -S --needed --noconfirm \
    base-devel networkmanager ansible acpi bluez bluez-utils pavucontrol brightnessctl \
    git wget gcc make sqlite unzip tree jq tmux ffmpeg fzf fastfetch yt-dlp \
    hugo neovim btop ripgrep git-delta glow \
    xorg-server xorg-xinit libx11 libxft libxinerama \
    firefox xclip xsel i3lock syncthing rofi feh flameshot zathura \
    libreoffice-fresh telegram-desktop mpv sshfs \
    nodejs npm go php composer \
    prettier stylua lua-language-server python-lsp-server typescript-language-server \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttc-iosevka
}

# Function to compile and install dwm and st from source
compile_dwm_st() {
    echo "Compiling dwm and st from custom repos..."
    mkdir -p ~/personal/suckless
    pushd ~/personal/suckless

    # Clone and compile dwm
    if [ ! -d "dwm" ]; then
        echo "Cloning dwm..."
        git clone https://github.com/musaubrian/dwm
    fi
    pushd dwm
    echo "Compiling dwm..."
    make clean
    make
    sudo make install
    popd

    # Clone and compile st
    if [ ! -d "st" ]; then
        echo "Cloning st..."
        git clone https://github.com/musaubrian/st
    fi
    pushd st
    echo "Compiling st..."
    make clean
    make
    sudo make install
    popd

    echo "dwm and st compiled and installed successfully!"
    popd
}

# Configure X session for dwm
configure_x() {
    echo "Configuring X session and dwm..."

    # Create dwm.desktop file
    sudo mkdir -p /usr/share/xsessions/
    cat << EOF | sudo tee /usr/share/xsessions/dwm.desktop
[Desktop Entry]
Name=dwm
Comment=Lightweight window manager
Exec=dwm
Type=Application
EOF

# Create .xinitrc if it doesn't exist
if [ ! -f ~/.xinitrc ]; then
    cat << EOF > ~/.xinitrc
#!/bin/sh

# Load X resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

~/scripts/dwm-startup.sh &

exec dwm
EOF
chmod +x ~/.xinitrc
fi

echo "X session configured successfully!"
}

# Configure SSH keys - KEEPING EXACTLY AS ORIGINAL
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

configure_bluetooth() {
    echo "Configuring Bluetooth..."
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth

    # Configure Bluetooth to enable media devices
    sudo mkdir -p /etc/bluetooth/
    cat << EOF | sudo tee /etc/bluetooth/main.conf
[General]
Enable=Source,Sink,Media,Socket
EOF
echo "Bluetooth configured!"
}

configure_system() {
    echo "Enabling services..."
    sudo systemctl enable NetworkManager
    sudo systemctl enable sshd
}

install_aur_packages() {
    echo "Installing AUR helper ($AUR_HELPER)..."

    # Check if is already installed
    if ! command -v $AUR_HELPER &> /dev/null; then
        pushd /tmp
        git clone https://aur.archlinux.org/$AUR_HELPER.git
        pushd $AUR_HELPER
        makepkg -si --noconfirm
        popd
        popd
    fi

    echo "Installing packages from AUR..."
    $AUR_HELPER -S --needed --noconfirm \
        nwg-look \
        pnpm \
        uv \
        tailwindcss-language-server \
        nil \
        marksman \
        gopls
    # httpie-desktop \

    echo "AUR packages installed successfully!"
}

setup_git_repo() {
    echo "Setting up git repo..."
    git remote remove origin
    git remote add origin git@github.com:musaubrian/nixe
    echo "Git repo setup complete!"
}

install_filemanager() {
    echo "Installing PCManFM and mounting support..."
    sudo pacman -S --needed --noconfirm \
        pcmanfm \
        gvfs \
        gvfs-smb \
        gvfs-afc \
        gvfs-mtp \
        gvfs-nfs \
        gvfs-goa \
        gvfs-gphoto2 \
        sshfs
    echo "PCManFM installed!"
}

# Main function
main() {
    echo "Starting Arch Linux setup..."

    install_packages
    install_aur_packages
    install_filemanager

    compile_dwm_st

    configure_system
    configure_x
    configure_bluetooth

    manage_keys
    manage_stash
    manage_syms

    setup_git_repo

    echo "Arch Linux setup completed successfully!"
    echo "You can now reboot and start your system with 'startx'"
}

main
