{ ... }:

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

  fileSystems = {
    "/".device = "/dev/disk/by-uuid/c82579d3-8895-420e-b37f-c83267f8df8c";
    "/boot".device = "/dev/disk/by-uuid/268B-89D8";
  };

  networking.hostName = "oneiros";
}
