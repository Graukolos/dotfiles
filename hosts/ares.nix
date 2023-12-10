{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot
    ./hardware
    ./locale
    ./networking
    ./nix
    ./programs
    ./users
  ];

  boot = {
    plymouth.enable = lib.mkForce false;
    initrd.kernelModules = [ "nvme" ];
  };

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/9e41d8f2-509e-40ee-8b55-870977baa491";
    "/boot".device = "/dev/disk/by-uuid/EFDC-5A8D";
    "/HDD" = {
      device = "/dev/disk/by-uuid/92340fae-c446-4e7f-a515-1fc6939110ee";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };
  };

  networking = {
    hostName = "ares";
    networkmanager.enable = lib.mkForce false;
    dhcpcd.extraConfig = "slaac hwaddr";
  };

  services = {
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

  system = {
    autoUpgrade = {
      operation = lib.mkForce "switch";
      allowReboot = true;
    };
  };
}
