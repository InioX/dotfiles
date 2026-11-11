{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.faugus;
in {
  options.zenyte.gaming.faugus = {
    enable = mkBoolOpt false "Whether to enable faugus.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      faugus-launcher
    ];

    zenyte.home.configFile = {
      "faugus-launcher/" = "faugus-launcher/";
    };

    zenyte.home.dataFile = {
      "faugus-launcher/games.json" = "share/faugus-launcher/games.json";
      "faugus-launcher/presets.json" = "share/faugus-launcher/presets.json";
    };
  };
}
