{ config, pkgs, ... }:

{
  imports = [ ./. ];

  networking = {
    hostName = "oneiros";
  };

  services.fwupd = {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  programs.gamemode.enable = true;

  security.tpm2.enable = true;
}