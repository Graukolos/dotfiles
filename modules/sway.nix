{ pkgs, config, ... }

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment.systemPackages = [
    pkgs.swayosd;
  ];
  services.gnome.at-spi2-core.enable = true;
}
