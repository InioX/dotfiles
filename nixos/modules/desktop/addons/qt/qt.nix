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

    qt.enable = true;

    environment.systemPackages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct

      kdePackages.qt6ct

      darkly
      darkly-qt5

      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.breeze-gtk
    ];
  };
}
