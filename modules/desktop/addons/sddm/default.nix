{
  config,
  pkgs,
  lib,
  zenyte-lib,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.sddm;
in {
  options.zenyte.desktop.addons.sddm = {
    enable = mkBoolOpt false "Whether to enable sddm.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
  };
}
