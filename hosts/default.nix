{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth.enable = true;
    kernelParams = [ "quiet" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
  };

  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      options = [ "compress=zstd" "noatime" ];
      fsType = "btrfs";
    };
    "/boot" = {
      options = [ "noatime" ];
      fsType = "vfat";
    };
  };


  zramSwap.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  services = {
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    fstrim.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    tailscale.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      desktopManager.gnome.enable = true;
      xkb.layout = "gb,de";
      excludePackages = [ pkgs.xterm ];
    };
    pcscd.enable = true;
  };

  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs = {
    zsh.enable = true;
    git.enable = true;
  };

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

  time.timeZone = "Europe/Berlin";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
    };
    rtkit.enable = true;
  };
}