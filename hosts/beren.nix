{ config, pkgs, ... }:

{
  imports = [
    ./beren/hardware-configuration.nix
    ../modules
    ../modules/desktop.nix
    ../modules/greetd.nix
    ../modules/font.nix
    ../modules/sound.nix
  ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.opengl.extraPackages = [ pkgs.intel-media-driver pkgs.vaapiIntel pkgs.libvdpau-va-gl];
  hardware.bluetooth.enable = true;
  networking.hostName = "beren";
  services.thermald.enable = true;
  services.tlp.enable = true;

  fileSystems."/".options = [ "compress=zstd" "noatime" ];
  fileSystems."/boot".options = [ "noatime" ];
  security.tpm2.enable = true;
}
