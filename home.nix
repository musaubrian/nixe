{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ulong";
  home.homeDirectory = "/home/ulong";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    dejavu_fonts
    nwg-look

    wget
    git
    gcc
    gnumake
    sqlite
    unzip
    tree
    jq

    delta
    ripgrep
    tmux
    ffmpeg
    smartmontools

    fzf
    fastfetch
    yt-dlp
    alejandra
    hugo
    uv
    glow
    pnpm
    btop
    neovim
    flameshot
    feh
    rofi

    nil
    gopls
    lua-language-server
    marksman
    python312Packages.python-lsp-server
    typescript-language-server
    tailwindcss-language-server
    blade-formatter

    prettierd
    stylua
    phpactor
    ruff

    python312
    go
    rustup
    php83
    php83Packages.composer
    nodejs_22

    mpv
    telegram-desktop
    android-studio
    zathura
    libreoffice
    httpie-desktop
    qemu
    arduino-ide
    kdePackages.kdenlive
    obs-studio
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "android-studio-stable"
      "httpie-desktop"
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".aliases".source = ./config/.aliases;
    ".gitconfig".source = ./config/.gitconfig;
    ".tmux.conf".source = ./config/.tmux.conf;
    ".profile".source = ./config/.profile;
    ".bashrc".source = ./config/.bashrc;
    ".bash_completions".source = ./config/.bash_completions;
    "scripts".source = ./config/scripts;
    ".config/nvim".source = ./config/nvim;
    ".config/i3".source = ./config/i3;
    ".config/rofi".source = ./config/rofi;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
