{ config, pkgs, ... }:

{
  imports = [ ./. ];

  hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];

  networking.hostName = "oneiros";

  programs.gamemode.enable = true;

  security.tpm2.enable = true;
}
