{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs) stdenv fetchgit pkg-config xorg;
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "sminx";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.ulong = {
    isNormalUser = true;
    description = "ulong";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "docker"];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # environment.sessionVariables = {
  #   NIXOS_OZONE_WL = "1";
  #   MOZ_ENABLE_WAYLAND = "1";
  #   T_QPA_PLATFORM = "wayland";
  # };

  environment.pathsToLink = ["/libexec"];
  services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = true;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        rofi
        i3lock
        xclip
        xsel
      ];
    };
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    iosevka
  ];

  environment.systemPackages = with pkgs; [
    sshfs
    home-manager
    networkmanagerapplet
    feh
    pavucontrol
    brightnessctl
    chromium
    # st build
    (stdenv.mkDerivation {
      name = "st";
      src = fetchgit {
        url = "https://github.com/musaubrian/st";
        sha256 = "sha256-FxcEKd9b5XVI8ce4q/BsPJgb9ZXkLE2kp6UdSzljU/k=";
      };
      nativeBuildInputs = [pkg-config];
      buildInputs = [xorg.libX11 xorg.libXft];
      buildPhase = ''
        make
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp st $out/bin/
      '';
    })
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1000;
      to = 1500;
    }
    {
      from = 3000;
      to = 3500;
    }
    {
      from = 8000;
      to = 9000;
    }
    {
      from = 21000;
      to = 23000;
    }
  ];

  system.stateVersion = "24.11";
}
