{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users.graukolos = {
      isNormalUser = true;
      description = "Max Erdelmeier";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$ROJage0pMcQStG49fyFfn0$X16PdxG8S7eosQLXVS17XGY.ONyEn2USbiHoxDrV7e2";
    };
  };
}