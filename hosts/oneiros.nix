{ config, pkgs, ... }:

{
  imports = [ ./. ];

  boot.initrd.availableKernelModules = [ "nvme" ];

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/c82579d3-8895-420e-b37f-c83267f8df8c";
    "/boot".device = "/dev/disk/by-uuid/268B-89D8";
  };

  networking.hostName = "oneiros";

  programs.gamemode.enable = true;

  security.tpm2.enable = true;
}
