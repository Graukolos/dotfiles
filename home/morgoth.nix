{ lib, pkgs, config, ... }:

{
  home = {
    username = "graukolos";
    homeDirectory = "/home/graukolos";
    stateVersion = "23.11";
  };

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };
    gtk3.bookmarks = [ "file:///home/graukolos/Projects" ];
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

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
      picture-uri = "${../assets/wallpaper_morgoth.jpg}";
      picture-uri-dark = "${../assets/wallpaper_morgoth.jpg}";
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
      picture-uri = "${../assets/wallpaper.jpg}";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 60;
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
        "pomodoro@arun.codito.in"
        "dash-to-dock@micxgx.gmail.com"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      volume-step = 2;
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "${lib.getExe pkgs.eza}";
        ll = "${lib.getExe pkgs.eza} -l";
      };
    };
    starship.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    htop = {
      enable = true;
      settings = {
        hide_userland_threads = 1;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    eza.enable = true;
    bottom.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnome.pomodoro
  ];

  services.syncthing.enable = true;
}
