{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.git ];
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}