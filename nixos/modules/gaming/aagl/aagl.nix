{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.aagl;
in {
  options.zenyte.gaming.aagl = {
    enable = mkBoolOpt false "Whether to enable an anime game launcher.";
  };

  config = mkIf cfg.enable {
    # programs.anime-games-launcher.enable = true;
    programs.honkers-railway-launcher.enable = true;
    programs.anime-game-launcher.enable = true;
    # programs.honkers-launcher.enable = true;

    zenyte.home.dataFile = {
      "honkers-railway-launcher/config.json" = "share/honkers-railway-launcher/config.json";
      "anime-game-launcher/config.json" = "share/anime-game-launcher/config.json";
    };

    zenyte.home.desktopEntryFile = {
      "Genshin.desktop" = "Genshin.desktop";
    };
  };
}
