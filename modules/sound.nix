{ config, pkgs, ... }:

{
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;
}
