{ lib, pkgs, config, ... }:
let wallpaper = ../assets/wallpaper.jpg;
in {
  home.packages = [
    pkgs.swaybg
    pkgs.networkmanagerapplet
    pkgs.brightnessctl
    pkgs.glib
    pkgs.libsForQt5.polkit-kde-agent
    pkgs.autotiling-rs
    pkgs.xdg-utils
  ];

  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter";
    };
    gtk3.bookmarks = [ "file:///home/graukolos/Projects" ];
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

  qt = {
    enable = true;
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_FORCE_DPI = "physical";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.alacritty.enable = true;
  programs.wofi.enable = true;
  programs.wofi.settings = {
    show = "drun,run";
    allow_images = true;
    insensitive = true;
    no_actions = true;
    gtk_dark = true;
  };
  programs.swaylock.enable = true;
  services.swayosd.enable = true;
  services.mako.enable = true;

  wayland.windowManager.sway = {
    wrapperFeatures.gtk = true;
    enable = true;
    systemd.enable = true;
    systemd.xdgAutostart = true;
    config = {
      bars = [ { command = "waybar"; } ];
      input = {
        "type:touchpad" = {
          tap = "enabled";
          click_method = "clickfinger";
          natural_scroll = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
        "type:keyboard" = {
          xkb_layout = "gb,de";
          xkb_options = "grp:win_space_toggle";
        };
      };
      output = {
        "HDMI-A-1" = {
          mode = "2560x1440@60Hz";
        };
        "eDP-1" = {
          scale = "1.2";
        };
        "*" = {
          bg = "${wallpaper} fill";
        };
      };
      gaps.smartBorders = "on";
      window.titlebar = false;
      keybindings = {
        "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
        "Mod4+l" = "exec swaylock";

        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+0" = "workspace number 10";

        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Shift+0" = "move container to workspace number 10";

        "Mod4+Return" = "exec alacritty";
        "Mod4+q" = "kill";
        "Mod4+d" = "exec wofi";
      };
      startup = [
        { command = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"; }
        { command = "${pkgs.autotiling-rs}/bin/autotiling-rs"; }
      ];
    };
  };
}
