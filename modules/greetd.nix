{
  lib,
  pkgs,
  config,
  default,
  ...
}:
let greetd_sway_config = pkgs.writeText "greetd-sway-config" ''
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP"

    input "type:touchpad" {
        tap enabled
    }

    xwayland disable

    exec "GTK_USE_PORTAL=0 ${lib.getExe config.programs.regreet.package}; swaymsg exit"
'';
in {
  services.greetd.enable = true;
  programs.sway.enable = true;
  services.greetd.settings.default_session.command = "${config.programs.sway.package}/bin/sway --config ${greetd_sway_config}";

  environment.systemPackages = [
    pkgs.adw-gtk3
    pkgs.inter
  ];

  programs.regreet = {
    enable = true;

    settings = {
      background = {
        path = ../assets/wallpaper.jpg;
      };
      GTK = {
        font_name = "Inter";
        theme_name = "adw-gtk3-dark";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
