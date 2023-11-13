{ config, pkgs, ... }:

{
  imports = [ ./. ];

  boot = {
    initrd.kernelModules = [ "i915" "nvme" ];
    kernelParams = [ "i915.enable_guc=2" ];
  };

  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/c42bfd85-d7df-467e-9f53-f0a85ba56145";
    "/boot".device = "/dev/disk/by-uuid/DBB2-57D4";
  };

  networking.hostName = "beren";

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };

  security.tpm2.enable = true;
}
