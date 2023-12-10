{ config, pkgs, ... }:

{
  imports = [
    ./audio
    ./boot
    ./desktop
    ./gaming
    ./hardware
    ./locale
    ./networking
    ./nix
    ./programs
    ./users
  ];

  boot.initrd.availableKernelModules = [ "nvme" ];

  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/31a61b6e-96bf-4738-baa9-d26348762d1a";
    "/boot".device = "/dev/disk/by-uuid/6801-B9C7";
  };

  networking.hostName = "glorfindel";
}
