{ lib, pkgs, config, ... }:
let
     oldpkgs = import (builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "e1ee359d16a1886f0771cc433a00827da98d861c";
     }) { inherit (pkgs) system; };

     gnome-pomodoro = oldpkgs.gnome.pomodoro;
in {
  home = {
    username = "graukolos";
    homeDirectory = "/home/graukolos";
    stateVersion = "23.05";
  };

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 14;
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
      document-font-name = "Inter 14";
      monospace-font-name = "JetBrainsMono Nerd Font 14";
      clock-show-weekday = true;
      clock-show-seconds = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "${../assets/wallpaper.jpg}";
      picture-uri-dark = "${../assets/wallpaper.jpg}";
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      titlebar-font = "Inter Bold 14";
      button-layout = "appmenu:minimize,maximize,close";
      focus-mode = "sloppy";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "${../assets/wallpaper.jpg}";
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
        "pop-shell@system76.com"
        "pomodoro@arun.codito.in"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      volume-step = 2;
    };
  };

  programs = {
    home-manager.enable = true;
    topgrade.enable = true;
    gh.enable = true;
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "ls" = "${lib.getExe pkgs.eza} -al";
        "cat" = "${lib.getExe pkgs.bat}";
      };
    };
    starship.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
    htop = {
      enable = true;
      settings = {
        hide_userland_threads = 1;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
      };
    };
    vscode.enable = true;
    eza.enable = true;
    bottom.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = [
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.pop-shell
    gnome-pomodoro

    pkgs.rustup

    pkgs.vlc
    pkgs.trayscale
    pkgs.yubioath-flutter
    pkgs.gnome.gnome-tweaks
    pkgs.prismlauncher
    pkgs.discord
    pkgs.blender
    pkgs.thunderbird
    pkgs.joplin-desktop
    pkgs.libreoffice-fresh
    pkgs.vorta
    pkgs.protonvpn-gui
    pkgs.bitwarden
    pkgs.mattermost-desktop
    pkgs.amberol
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM="wayland;xcb";
  };

  services.syncthing.enable = true;
}
