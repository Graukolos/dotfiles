{ pkgs, ... }:
let
  aarch64-pkgs = import nixpkgs { system = "x86_64-linux"; crossSystem = "aarch64-unknown-elf"; };
in
{
  home.packages = with pkgs; [
    vscodium
    gcc
    cargo
    radare2
    aarch64-pkgs.buildPackages.gcc
  ];
}