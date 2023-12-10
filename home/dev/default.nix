{ pkgs, nixpkgs, ... }:
{
  home.packages = with pkgs; [
    vscodium
    gcc
    cargo
    radare2
  ];
}
