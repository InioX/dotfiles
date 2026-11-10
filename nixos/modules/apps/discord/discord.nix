{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.discord;
in {
  options.zenyte.apps.discord = {
    enable = mkBoolOpt false "Whether to enable discord.";
    withOpenASAR = mkBoolOpt true "Whether to enable OpenASAR, a replacement for Discord desktop's app.asar file.";
    withVencord = mkBoolOpt true "Whether to enable Vencord, a client mod for Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = cfg.withOpenASAR;
        withVencord = cfg.withVencord;
      })
    ];

    zenyte.home.configFile = {
      "Vesktop" = "Vesktop";
      "vesktop-flags.conf" = "vesktop-flags.conf";
    };

    zenyte.matugen.template = {
      discord = {
        input = "discord.css";
        output = "~/.config/Vencord/themes/midnight-discord.css";
      };
    };
  };
}
