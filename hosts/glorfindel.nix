{ config, pkgs, ... }:

{
  imports = [ ./. ];

  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];

  networking.hostName = "oneiros";

  programs.gamemode.enable = true;

  services = {
    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };
  };

  security.tpm2.enable = true;
}