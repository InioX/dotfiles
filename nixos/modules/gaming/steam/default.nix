{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.steam;
in {
  options.zenyte.gaming.steam = {
    enable = mkBoolOpt false "Whether to enable steam.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
    };
  };
}
