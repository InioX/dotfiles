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
    programs.anime-game-launcher.enable = true;
    programs.anime-games-launcher.enable = true;
    programs.honkers-railway-launcher.enable = true;
    programs.honkers-launcher.enable = true;
  };
}
