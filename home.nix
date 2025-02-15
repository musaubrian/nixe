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
    xorg.xcursorthemes

    delta
    ripgrep
    tmux
    ffmpeg
    wofi
    grim
    slurp
    pywal16

    fzf
    fastfetch
    yt-dlp
    alejandra
    hugo
    uv
    glow
    bun
    btop

    nil
    gopls
    lua-language-server
    marksman
    python312Packages.python-lsp-server
    typescript-language-server
    tailwindcss-language-server

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

    chromium
    mpv
    networkmanagerapplet
    ansible
    telegram-desktop
    android-studio
    zathura
    libreoffice
    httpie-desktop
    qemu
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
    ".config/foot".source = ./config/foot;
    ".config/hypr".source = ./config/hypr;
    ".config/waybar".source = ./config/waybar;
    ".config/nvim".source = ./config/nvim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  stylix = {
    enable = true;
    autoEnable = true;
    image = ./config/wall.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Mordern-Ice";
    };
    fonts = {
      monospace = {
        name = "Iosevka Medium";
        package = pkgs.iosevka;
      };
      sansSerif = {
        package = pkgs.freefont_ttf;
        name = "FreeSans";
      };
      serif = {
        package = pkgs.freefont_ttf;
        name = "FreeSerif";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
