{ pkgs, ... }:

{
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
}