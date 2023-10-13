{ pkgs, config, ... }:

{
  home.packages = [
    pkgs.bat
    pkgs.eza
    pkgs.htop
    pkgs.topgrade
    pkgs.bottom
    pkgs.neofetch
  ];

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ls = "eza -al";
        cat = "bat";
      };
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
    };
    starship.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}