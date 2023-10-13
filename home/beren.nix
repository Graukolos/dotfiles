{ pkgs, config, ... }:

{
  imports = [
    ./.
    ./waybar.nix
    ./programs.nix
    ./sway.nix
    ./desktop.nix
  ];
}
