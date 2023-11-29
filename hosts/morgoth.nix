{ config, pkgs, ... }:

{
  imports = [ ./. ];
  
  boot.initrd.kernelModules = [ "i915" "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/3bc1ba85-9526-456b-a1dc-c1544b23a7c8";
    "/boot".device = "/dev/disk/by-uuid/9CFC-1154";
  };

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };
}