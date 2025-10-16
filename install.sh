#!/usr/bin/env bash
set -e

AUR_HELPER="yay"

usage() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  x, x11,          Install X11/Xorg setup with dwm"
    echo "  w, wayland       Install Wayland setup with Hyprland"
    echo "  both             Install both X11 and Wayland (full setup)"
    echo ""
    echo "Examples:"
    echo "  $0 wayland       # Install Wayland setup only"
    echo "  $0 x11           # Install X11 setup only"
    echo "  $0 both          # Install both setups"
}

install_base_packages() {
    echo "Installing packages..."
    sudo pacman -S --needed --noconfirm \
    base-devel networkmanager ansible acpi bluez bluez-utils blueman pavucontrol brightnessctl \
    network-manager-applet\
    git wget gcc make sqlite unzip tree jq tmux ffmpeg fzf yt-dlp \
    hugo neovim btop ripgrep difftastic man-pages man-db less\
    firefox  syncthing fuzzel feh zathura zathura-pdf-poppler \
    libreoffice-fresh telegram-desktop mpv sshfs \
    nodejs npm go php \
    stylua lua-language-server python-lsp-server typescript-language-server tinymist \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttc-iosevka ttf-jetbrains-mono gnu-free-fonts
}

install_x_packages() {
    echo "Installing Xorg related packages..."
    sudo pacman -S --needed --noconfirm \
    xorg-xsetroot xorg-server xorg-xinit libx11 libxft libxinerama dunst \
    xclip xsel i3lock flameshot polkit-gnome
}

install_wayland_packages() {
    echo "Installing wayland related packages..."
    sudo pacman -S --needed --noconfirm \
    hyprland hyprpaper hyprlock xdg-desktop-portal-hyprland hypridle hyprsunset mako \
    hyprpolkitagent \
    waybar wf-recorder wl-clipboard slurp grim
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
    sudo systemctl enable bluetooth.service
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
        marksman gopls

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

setup_x11() {
    echo "== Installing X11 Setup =="
    install_x_packages
    compile_dwm_st
    configure_x
    setup_touchpad
}

setup_wayland() {
    echo "== Installing Wayland Setup =="
    install_wayland_packages
}

# Main function
main() {
    local setup_type="$1"

    if [ $# -eq 0 ]; then
        echo "Error: No setup type specified.\n"
        usage
        exit 1
    fi

    # Handle help flag
    case "$setup_type" in
        -h|--help)
            usage
            exit 0
            ;;
    esac

    echo "Starting setup for: $setup_type"
    echo "==============================="

    install_base_packages
    install_aur_packages
    install_filemanager
    configure_system

    case "$setup_type" in
        x|x11)
            setup_x
            ;;
        w|wayland)
		setup_wayland
            ;;
        both)
		setup_x
		setup_wayland
            ;;
        *)
            echo "Error: Unknown setup type '$setup_type'"
            echo ""
            show_usage
            exit 1
            ;;
    esac

    echo "== Running Common Setup Tasks =="
    manage_keys
    manage_stash
    manage_syms
    setup_git_repo

    echo "Setup for ($setup_type) completed successfully!"
}

# main "$@"
install_aur_packages
