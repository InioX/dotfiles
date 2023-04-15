{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.sddm;
in {
  options.zenyte.desktop.addons.sddm = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
  };
}