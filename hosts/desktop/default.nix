{ pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
      layout = "gb,de";
      xkbVariant = "";
    };
    pcscd.enable = true;
  };

  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
}