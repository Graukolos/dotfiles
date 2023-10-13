{ pkgs, config, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    useDHCP = false;
  };
  services.tailscale.enable = true;
}