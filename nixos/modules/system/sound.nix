{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.sound;
in {
  options.zenyte.system.sound = {
    enable = mkBoolOpt false "Whether to enable sound.";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
