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
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      alsa-utils
      easyeffects
      # helvum
      # pavucontrol
      pwvucontrol
    ];

    boot.extraModprobeConfig = ''
      options snd_hda_intel power_save=0
      options snd_acp3x_pdm_dma power_save=0
    '';

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # extraConfig.pipewire."context.properties" = {
      #   default.clock.rate = 48000;
      #   default.clock.allowed-rates = [44100 48000 96000];
      #   default.clock.quantum = 1024;
      #   default.clock.min-quantum = 512;
      #   default.clock.max-quantum = 2048;
      # };
    };
  };
}
