{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.services.kdeconnect;
in {
  options.zenyte.services.kdeconnect = {
    enable = mkBoolOpt false "Whether to enable kdeconnect.";
  };

  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
