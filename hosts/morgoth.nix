{ config, pkgs, lib, nixpkgs, ... }:

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
    initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" ];
  };

  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c721d484-8f5e-455f-9770-07b15ca6e0d8";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" "compress=zstd" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D9E7-F826";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };

  zramSwap.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    hostName = "morgoth";
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
      alsa.support32Bit = true;
    };
    tailscale.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
      layout = "gb,de";
      xkbVariant = "";
    };
    pcscd.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    auto-cpufreq.enable = true;
  };

  systemd.services.battery-charge-threshold = {
    wantedBy = [ "local-fs.target" "suspend.target" ];
    after = [ "local-fs.target" "suspend.target" ];
    description = "Set the battery charge threshold to 80%";
    startLimitBurst = 5;
    startLimitIntervalSec = 1;
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      ExecStart = "${pkgs.runtimeShell} -c 'echo 80 > /sys/class/power_supply/BAT?/charge_control_end_threshold'";
    };
  };

  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = nixpkgs;
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
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  console.keyMap = "uk";

  sound.enable = true;
}
