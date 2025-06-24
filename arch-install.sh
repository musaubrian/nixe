#!/usr/bin/env bash
set -e

AUR_HELPER="yay"

install_packages() {
    echo "Installing packages..."
    sudo pacman -S --needed --noconfirm \
    base-devel networkmanager ansible acpi bluez bluez-utils blueman pavucontrol brightnessctl dunst \
    xorg-xsetroot network-manager-applet \
    git wget gcc make sqlite unzip tree jq tmux ffmpeg fzf fastfetch yt-dlp \
    hugo neovim btop ripgrep git-delta glow \
    xorg-server xorg-xinit libx11 libxft libxinerama \
    firefox xclip xsel i3lock syncthing rofi feh flameshot zathura \
    libreoffice-fresh telegram-desktop mpv sshfs \
    nodejs npm go php \
    prettier stylua lua-language-server python-lsp-server typescript-language-server \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttc-iosevka gnu-free-fonts
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

dunst &
blueman-applet &

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

~/scripts/dwm-startup.sh &

exec dwm
EOF
chmod +x ~/.xinitrc
fi

echo "X session configured successfully!"
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
        nwg-look pnpm tailwindcss-language-server \
        nil marksman gopls
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
    echo "Installing filemanager and mounting support..."
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
    echo "Filemanager installed!"
}

setup_touchpad() {
    cat << EOF | sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf > /dev/null
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "off"
    Option "ScrollMethod" "twofinger"
EndSection
EOF
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

    manage_keys
    manage_stash
    manage_syms

    setup_git_repo
    setup_touchpad

    echo "Arch Linux setup completed successfully!"
}

setup_touchpad
