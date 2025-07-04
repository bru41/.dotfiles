# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  unstable,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      wget
      firefox
      lynx
      kitty
      thunderbird
      discord
      mangohud
      vscode
      brave
      caligula
      kitty
      gcc
      gnumake
      ncurses
      gparted
      smartmontools
      rustup
      alejandra
      obsidian
      neovim
      cargo
      rustup
      cargo-ui
      nerdfetch
      zip
      unzip
      vimPlugins.rustaceanvim
      nixos-grub2-theme
      minicom
      htop
      heroic
      ollama
      swaynotificationcenter
      rofi-wayland
      fastfetch
      btop
      swappy
      wlogout
      wallust
      cava
      papers
      vlc
      nerd-fonts.noto
      nerd-fonts.space-mono
      xfce.thunar
      procps
      terminus-nerdfont
      swww
      hyprcursor
      rose-pine-cursor
      playerctl
      openssl
      mpv
      libnotify
      pavucontrol
      pwgen
      qgroundcontrol
      grim
      eduvpn-client

      flameshot
      qbittorrent
      swappy
      micromamba
      cudaPackages.cudatoolkit
      python312
      python312Packages.pip
      python312Packages.pycuda
      python312Packages.torch
      python312Packages.torchvision
      python312Packages.torchaudio
      python312Packages.ipykernel
      pkgs.python312Packages.stdlibs
    ])
    ++ (with unstable; [
      ags
      waybar
    ]);
  #################
  #SYSTEM PACKAGES#
  #################
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    alsa-lib
  ];
  fonts.packages =
    (with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      font-awesome
    ])
    ++ (with unstable; [
      ]);
  nixpkgs.config.allowUnfree = true;
  nix.settings.substituters = ["https://cuda-maintainers.cachix.org"];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nickv = {
    isNormalUser = true;
    description = "Nick Valkenburg";
    extraGroups = ["networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.gnupg.agent.settings = {
    default-cache-ttl = 1;
    max-cache-ttl = 1;
  };

  #  hardware.pulseaudio.enable = lib.mkOverride 1 true;
  #  hardware.pulseaudio.support32Bit = true;
  #  nixpkgs.config.pulseaudio = true;
  #  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  # services.displayManager.ly.autoNumlock = true;
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # Did you read the comment?
  boot.kernelPackages = pkgs.linuxPackages;
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
