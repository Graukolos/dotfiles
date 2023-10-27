{ config, pkgs, ... }:

{
  boot = {
    plymouth.enable = true;
    initrd.kernelModules = [ "i915" "nvme" "xhci_pci" ];
    kernelParams = [ "quiet" "i915.enable_guc=2" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    tmp.useTmpfs = true;
  };

  hardware = {
    opengl.extraPackages = [ pkgs.intel-media-driver ];
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      options = [ "compress=zstd" "noatime" ];
      device = "/dev/disk/by-uuid/c42bfd85-d7df-467e-9f53-f0a85ba56145";
      fsType = "btrfs";
    };
    "/boot" = {
      options = [ "noatime" ];
      device = "/dev/disk/by-uuid/DBB2-57D4";
      fsType = "vfat";
    };
  };

  zramSwap.enable = true;

  networking = {
    hostName = "beren";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  services = {
    printing.enable = true;
    fstrim.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    tailscale.enable = true;
    thermald.enable = true;
    auto-cpufreq.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      desktopManager.gnome.enable = true;
      xkb.layout = "gb,de";
      excludePackages = [
        pkgs.xorg.xorgserver.out
        pkgs.xorg.xrandr
        pkgs.xorg.xrdb
        pkgs.xorg.setxkbmap
        pkgs.xorg.iceauth
        pkgs.xorg.xlsclients
        pkgs.xorg.xset
        pkgs.xorg.xsetroot
        pkgs.xorg.xinput
        pkgs.xorg.xprop
        pkgs.xorg.xauth
        pkgs.xterm
        pkgs.xorg.xf86inputevdev.out
      ];
    };
    pcscd.enable = true;
    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };
  };
  systemd.oomd.enable = false;

  # nix configuration
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # installed programs
  programs = {
    zsh.enable = true;
    git.enable = true;
  };

  environment.gnome.excludePackages = [
    pkgs.gnome.gnome-shell-extensions
    pkgs.gnome.gnome-backgrounds
    pkgs.gnome.gnome-color-manager
    pkgs.gnome.gnome-themes-extra
    pkgs.gnome-tour
    pkgs.gnome-user-docs
    pkgs.orca
    pkgs.gnome.baobab
    pkgs.gnome.cheese
    pkgs.gnome.epiphany
    pkgs.gnome.gnome-characters
    pkgs.gnome.gnome-contacts
    pkgs.gnome.gnome-font-viewer
    pkgs.gnome.gnome-logs
    pkgs.gnome.gnome-maps
    pkgs.gnome-photos
    pkgs.gnome.gnome-weather
    pkgs.gnome-connections
    pkgs.gnome.totem
    pkgs.gnome.yelp
    pkgs.gnome.geary
    pkgs.gnome.gnome-music
  ];

  # user config
  users = {
    mutableUsers = false;
    users.graukolos = {
      isNormalUser = true;
      description = "Max Erdelmeier";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$ROJage0pMcQStG49fyFfn0$X16PdxG8S7eosQLXVS17XGY.ONyEn2USbiHoxDrV7e2";
    };
  };

  # localization
  time.timeZone = "Europe/Berlin";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  # theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
    };
    rtkit.enable = true;
    tpm2.enable = true;
  };
}
