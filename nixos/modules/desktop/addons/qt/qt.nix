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

  scheme = "Matugen";

  applyKde = pkgs.writeShellApplication {
    name = "apply-kde-colorscheme";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.kdePackages.kconfig
      pkgs.dbus
    ];
    text = ''
      scheme="${scheme}"
      file="$HOME/.local/share/color-schemes/$scheme.colors"

      group=""
      while IFS= read -r line; do
        case "$line" in
          "["*"]")
            group="''${line#\[}"
            group="''${group%\]}"
            ;;
          ""|"#"*)
            ;;
          *=*)
            case "$group" in
              Colors:*|WM|KDE)
                kwriteconfig6 --file kdeglobals --group "$group" \
                  --key "''${line%%=*}" "''${line#*=}"
                ;;
            esac
            ;;
        esac
      done < "$file"

      hash=$(sha1sum "$file" | cut -d' ' -f1)
      kwriteconfig6 --file kdeglobals --group General --key ColorScheme "$scheme"
      kwriteconfig6 --file kdeglobals --group General --key ColorSchemeHash "$hash"

      dbus-send --session --type=signal /KGlobalSettings \
        org.kde.KGlobalSettings.notifyChange int32:0 int32:0
    '';
  };
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

      # darkly
      # darkly-qt5

      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.breeze-gtk

      applyKde
    ];

    zenyte.home.configFile = {
      "qt5ct/qt5ct.conf" = "qt5ct/qt5ct.conf";
      "qt5ct/qt6ct.conf" = "qt5ct/qt6ct.conf";
      # "kdeglobals" = "kdeglobals";
    };

    zenyte.matugen.template = {
      qt5ct = {
        input = "matugen.conf";
        output = "~/.config/qt5ct/colors/matugen.conf";
      };
      qt6ct = {
        input = "matugen.conf";
        output = "~/.config/qt6ct/colors/matugen.conf";
      };
      kde = {
        input = "kde/Matugen.colors";
        output = "~/.local/share/color-schemes/Matugen.colors";
        post_hook = "${applyKde}/bin/apply-kde-colorscheme";
      };
    };
  };
}
