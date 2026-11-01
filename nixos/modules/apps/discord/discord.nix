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
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
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
