{ ... }:

{
  hardware.enableRedistributableFirmware = true;

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

  services.fstrim.enable = true;
}