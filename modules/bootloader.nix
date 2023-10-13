{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "loglevel=3" ];
    tmp.cleanOnBoot = true;
    tmp.useTmpfs = true;
  };
}