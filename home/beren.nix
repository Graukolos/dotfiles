{ lib, pkgs, config, ... }:

{
  home = {
    username = "graukolos";
    homeDirectory = "/home/graukolos";
    stateVersion = "23.05";
    packages = [
      pkgs.neofetch
      pkgs.vlc
      pkgs.vorta
      pkgs.protonvpn-gui
      pkgs.bitwarden
      pkgs.mattermost-desktop
      pkgs.yubioath-flutter
      pkgs.trayscale
      pkgs.gnome.eog
      pkgs.gnome.nautilus
      pkgs.gnome.sushi
      pkgs.gnome.adwaita-icon-theme
      pkgs.evince
      pkgs.rhythmbox
      pkgs.stress
      pkgs.swaybg
      pkgs.libsForQt5.polkit-kde-agent
      pkgs.joplin-desktop
      pkgs.libreoffice-fresh
      pkgs.thunderbird
      pkgs.blender
      pkgs.udisks
      pkgs.armcord
      pkgs.grimblast
    ];
  };

  programs = {
    topgrade.enable = true;
    gh.enable = true;
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "ls" = "${lib.getExe pkgs.eza} -al";
        "cat" = "${lib.getExe pkgs.bat}";
	"develop" = "nix develop /nix/var/nix/profiles/per-user/graukolos/$(basename $(pwd))";
      };
    };
    starship.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    yt-dlp.enable = true;
    bat.enable = true;
    bottom.enable = true;
    eza.enable = true;
    htop.enable = true;
    firefox.enable = true;
    vscode.enable = true;
    alacritty.enable = true;
    wofi.enable = true;
    wofi.settings = {
      show = "drun";
      allow_images = true;
      insensitive = true;
      no_actions = true;
      gtk_dark = true;
    };
    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [ "hyprland/workspaces" ];
          modules-right = [
            "tray"
            "bluetooth"
            "hyprland/language"
            "network"
            "battery"
            "clock"
          ];
        };
      };
      style = ''
        window.eDP-1 * {
          font-size: 22px;
        }

        #clock, #battery, #network, #language, #bluetooth, #tray {
          background-color: @borders;
          padding: 0px 10px;
          margin: 5px 0px;
        }

        #clock {
          border-radius: 0px 20px 20px 0px;
        }

        #bluetooth {
          border-radius: 20px 0px 0px 20px;
        }

        #tray {
          border-radius: 20px 20px 20px 20px;
          margin: 5px 20px 5px 30px;
        }
      '';
    };
  };

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
    swayosd.enable = true;
    mako.enable = true;
    network-manager-applet.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 14;
    };
    gtk3.bookmarks = [ "file:///home/graukolos/Projects" ];
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "gnome";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        resize_on_border = true;
      };
      input = {
        kb_layout = "gb,de";
        kb_options = "grp:win_space_toggle";
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_numbered = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
      };
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,2560x1440@60,1920x0,1"
      ];
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, ${lib.getExe pkgs.alacritty}"
        "$mod, D, exec, ${lib.getExe pkgs.wofi}"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus"
        "$mod, F, exec, ${lib.getExe pkgs.firefox}"
        "$mod, V, togglefloating,"
	      "$mod, K, exec, ${lib.getExe pkgs.grimblast} copy output"
        ", XF86MonBrightnessDown, exec, ${pkgs.swayosd}/bin/swayosd --brightness lower"
        ", XF86MonBrightnessUp, exec, ${pkgs.swayosd}/bin/swayosd --brightness raise"
        ", XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd --output-volume +2"
        ", XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd --output-volume -2"
        ", XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd --output-volume mute-toggle"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod_SHIFT, 1, movetoworkspacesilent, 1"
        "$mod_SHIFT, 2, movetoworkspacesilent, 2"
        "$mod_SHIFT, 3, movetoworkspacesilent, 3"
        "$mod_SHIFT, 4, movetoworkspacesilent, 4"
        "$mod_SHIFT, 5, movetoworkspacesilent, 5"
        "$mod_SHIFT, 6, movetoworkspacesilent, 6"
        "$mod_SHIFT, 7, movetoworkspacesilent, 7"
        "$mod_SHIFT, 8, movetoworkspacesilent, 8"
        "$mod_SHIFT, 9, movetoworkspacesilent, 9"
        "$mod_SHIFT, 0, movetoworkspacesilent, 10"
      ];
      bindm = [
        "$mod, mouse:272, moveWindow"
        "$mod, mouse:273, resizeWindow"
      ];
      exec-once = [
        "${lib.getExe pkgs.swaybg} -i ${../assets/wallpaper.jpg} -m fill"
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "${pkgs.vorta}/bin/vorta --daemonize"
      ];
    };
  };

  systemd.user.targets = {
    hyprland-session.Unit = {
      Wants = [ "xdg-desktop-autostart.target" ];
      Before = "xdg-desktop-autostart.target";
    };
    tray.Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
