{ config, pkgs, ... }:

{
  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    tmp.useTmpfs = true;
  };

  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "oneiros";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  services = {
    flatpak.enable = true;
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
    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };
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

  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
    };
    rtkit.enable = true;
    tpm2.enable = true;
  };
}