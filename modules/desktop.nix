{ config, pkgs, ... }:

{
  hardware.opengl.enable = true;

  programs.dconf.enable = true;

  services = {
    pcscd.enable = true;
    flatpak.enable = true;
  };
}
