{ config, pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./locale.nix
    ./nix.nix
    ./networking.nix
  ];

  system = {
    stateVersion = "23.05";
  };

  users.users.graukolos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  services.fstrim.enable = true;
  hardware.enableAllFirmware = true;

  zramSwap.enable = true;
  systemd.oomd.enable = false;
}
