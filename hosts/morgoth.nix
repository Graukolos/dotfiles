{ pkgs, ... }:

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

  boot.initrd.availableKernelModules = [ "xhci_pci" "vmd" "nvme" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c721d484-8f5e-455f-9770-07b15ca6e0d8";
      options = [ "subvol=@" ];
    };
    "/boot".device = "/dev/disk/by-uuid/D9E7-F826";
  };

  networking.hostName = "morgoth";

  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];

  services = {
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
}
