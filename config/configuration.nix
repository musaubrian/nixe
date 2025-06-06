{
  config,
  pkgs,
  ...
}: {
  imports = [/etc/nixos/hardware-configuration.nix];
  nixpkgs.overlays = [
    (final: prev: {
      st = prev.stdenv.mkDerivation {
        name = "st";
        src = prev.fetchgit {
          url = "https://github.com/musaubrian/st";
          sha256 = "sha256-NTevI4NJFMbKZAZ6DEjg7k0fmGdFTsn5WPtksNf4tZg=";
        };
        nativeBuildInputs = [prev.pkg-config];
        buildInputs = with prev; [
          xorg.libX11
          xorg.libXft
          pkgs.harfbuzz
        ];
        buildPhase = "make";
        installPhase = ''
          mkdir -p $out/bin
          cp st $out/bin/
        '';
      };
      dwm = prev.stdenv.mkDerivation {
        name = "dwm";
        src = prev.fetchgit {
          url = "https://github.com/musaubrian/dwm";
          sha256 = "sha256-HVZ3CpsZpH1P35NJTGI2GsPABALy9uI9z/N/FnUQLeI=";
        };
        nativeBuildInputs = [prev.pkg-config];
        buildInputs = with prev; [
          xorg.libX11
          xorg.libXft
          xorg.libXinerama
        ];
        buildPhase = "make";
        installPhase = ''
          mkdir -p $out/bin
          cp dwm $out/bin/
        '';
      };
    })
  ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "sminx";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  virtualisation.docker.enable = false;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.ulong = {
    isNormalUser = true;
    description = "ulong";
    # add docker here
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [];
  };

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.pathsToLink = ["/libexec"];

  services.displayManager.defaultSession = "none+dwm";
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xterm.enable = false;
    windowManager.dwm.enable = true;
  };

  environment.etc."share/xsessions/dwm.desktop".text = ''
    [Desktop Entry]
    Name=dwm
    Comment=Lightweight window manager
    Exec=${pkgs.dwm}/bin/dwm
    Type=Application
  '';

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
    distrobox
    dwm
    st
    xorg.xset
    xss-lock
    i3lock
    sshfs
    xclip
    xsel
    pavucontrol
    brightnessctl
    networkmanagerapplet
    acpi
    home-manager
    chromium
    ansible
    spice-gtk # vm "passthrough"
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
    # Syncthing related
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
