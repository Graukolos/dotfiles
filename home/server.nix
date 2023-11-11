{ lib, pkgs, config, ... }:

{
  home = {
    username = "graukolos";
    homeDirectory = "/home/graukolos";
    stateVersion = "23.05";
  };

  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      shellAliases = {
        "ls" = "${lib.getExe pkgs.exa} -al";
        "cat" = "${lib.getExe pkgs.bat}";
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
    exa.enable = true;
    bottom.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
