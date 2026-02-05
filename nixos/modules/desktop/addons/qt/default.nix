{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.qt;
in {
  options.zenyte.desktop.addons.qt = {
    enable = mkBoolOpt false "Whether to enable qt.";
  };

  config = mkIf cfg.enable {
    environment.variables.QT_QPA_PLATFORMTHEME = "qt6ct";

    environment.systemPackages = with pkgs; [
      darkly
      darkly-qt5

      kdePackages.breeze-icons
      kdePackages.breeze-gtk
    ];
  };
}
