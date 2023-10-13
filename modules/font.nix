{ config, pkgs, ... }:

{
  fonts = {
    packages = [ pkgs.inter (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) pkgs.noto-fonts pkgs.noto-fonts-emoji ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
	      serif = [ "Inter" ];
	      sansSerif = [ "Inter" ];
      };
    };
  };
}
