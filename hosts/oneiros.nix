{ config, pkgs, ... }:

{
  imports = [ ./. ];

  networking.hostName = "oneiros";

  programs.gamemode.enable = true;

  security.tpm2.enable = true;
}
