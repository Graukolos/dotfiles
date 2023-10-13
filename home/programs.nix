{ pkgs, config, ... }:

{
  home.packages = [
    pkgs.vscode-fhs
    pkgs.gnome.eog
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
    pkgs.vlc
    pkgs.gh
  ];
}
