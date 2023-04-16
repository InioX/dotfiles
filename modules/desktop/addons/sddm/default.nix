{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.sddm;
in {
  options.zenyte.desktop.addons.sddm = {
    enable = mkEnableOption "Whether to enable sddm.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
  };
}