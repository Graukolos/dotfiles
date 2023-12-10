{ lib, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "${lib.getExe pkgs.eza}";
        ll = "${lib.getExe pkgs.eza} -al";
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
    eza.enable = true;
    bottom.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}