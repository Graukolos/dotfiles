{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
  ];

  home.username = "graukolos";
  home.homeDirectory = "/home/graukolos";

  home.stateVersion = "23.05";
}
