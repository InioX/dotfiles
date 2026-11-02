{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.vesktop;
in {
  options.zenyte.apps.vesktop = {
    enable = mkBoolOpt false "Whether to enable vesktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vesktop
    ];

    zenyte.home.configFile = {
      "vesktop" = "vesktop";
      "vesktop-flags.conf" = "vesktop-flags.conf";
    };

    zenyte.matugen.template = {
      vesktop = {
        input = "discord.css";
        output = "~/.config/vesktop/themes/midnight-discord.css";
      };
    };
  };
}
