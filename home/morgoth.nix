{ lib, pkgs, config, ... }:

{
  imports = [
    ./home-manager
    ./shell
    ./gtk
    ./vscodium
    ./gnome
  ];

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = lib.mkForce "${../assets/wallpaper_morgoth.jpg}";
      picture-uri-dark = lib.mkForce "${../assets/wallpaper_morgoth.jpg}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = lib.mkForce "${../assets/wallpaper_morgoth.jpg}";
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.mkForce (lib.hm.gvariant.mkUint32 60);
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
      ];
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
  ];
}
