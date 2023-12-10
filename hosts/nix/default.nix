{ nixpkgs, ... }:

{
  system = {
    stateVersion = "23.11";
    autoUpgrade = {
      enable = true;
      operation = "boot";
      flake = "github:graukolos/dotfiles";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    registry.nixpkgs.flake = nixpkgs;
    channel.enable = false;
    gc = {
      automatic = true;
      options = "--delete-older-than=30d";
      dates = "weekly";
    };
  };
}