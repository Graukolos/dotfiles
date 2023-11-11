{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "nvme" ];
  };

  hardware.enableRedistributableFirmware = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9e41d8f2-509e-40ee-8b55-870977baa491";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EFDC-5A8D";
      fsType = "vfat";
      options = [ "noatime" ];
    };
    "/HDD" = {
      device = "/dev/disk/by-uuid/92340fae-c446-4e7f-a515-1fc6939110ee";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };
  };

  zramSwap.enable = true;

  networking = {
    hostName = "ares";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "uk";

  services = {
    fstrim.enable = true;
    tailscale.enable = true;
    thermald.enable = true;
    openssh.enable = true;
    syncthing = {
      enable = true;
      user = "graukolos";
      guiAddress = "0.0.0.0:8384";
      dataDir = "/HDD/graukolos";
    };
  };

  virtualisation.docker.enable = true;

  security = {
    tpm2.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
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
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$ROJage0pMcQStG49fyFfn0$X16PdxG8S7eosQLXVS17XGY.ONyEn2USbiHoxDrV7e2";
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      options = "-d";
    };
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade = {
      flake = "/home/graukolos/Projects/dotfiles";
      flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
      enable = true;
      allowReboot = true;
    };
  };
}
