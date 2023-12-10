{ lib, pkgs, config, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
      font-antialiasing = "rgba";
      document-font-name = "Inter 11";
      monospace-font-name = "JetBrainsMono Nerd Font 11";
      clock-show-weekday = true;
      clock-show-seconds = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "${../../assets/wallpaper.jpg}";
      picture-uri-dark = "${../../assets/wallpaper.jpg}";
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      titlebar-font = "Inter Bold 11";
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
      audible-bell = false;
      visual-bell = false;
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "${../../assets/wallpaper.jpg}";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = false;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
      power-button-action = "interactive";
      idle-dim = false;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "pomodoro@arun.codito.in"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      volume-step = 2;
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnome.pomodoro
  ];

  services.syncthing.enable = true;
}
