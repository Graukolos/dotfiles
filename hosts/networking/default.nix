{ ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  services.tailscale.enable = true;
}