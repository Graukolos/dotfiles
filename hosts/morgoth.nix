{ config, pkgs, ... }:

{
  imports = [ ./. ];
  
  boot.initrd.kernelModules = [ "i915" "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/17e7c5ec-3d6b-40bc-93cc-1cb99f90ca8d";
    "/boot".device = "/dev/disk/by-uuid/99E2-AE73";
  };

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };
}