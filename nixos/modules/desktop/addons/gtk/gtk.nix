{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.addons.gtk;

  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";

  reload-theme = pkgs.writeShellScriptBin "reload-theme" ''
    export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS

    gsettings set org.gnome.desktop.interface gtk-theme ""
    sleep 0.1
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
  '';
in
{
  options.zenyte.desktop.addons.gtk = {
    enable = mkBoolOpt false "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lxappearance-gtk2
      libadwaita

      # gnome.adwaita-icon-theme
      # adw-gtk3

      gsettings-desktop-schemas

      reload-theme
    ];

    zenyte.home.extraOptions.gtk.enable = true;

    zenyte.home.configFile = {
      "gtk-4.0/settings.ini" = "gtk-4.0/settings.ini";
      "gtk-3.0/settings.ini" = "gtk-3.0/settings.ini";
      "gtk-3.0/bookmarks" = "gtk-3.0/bookmarks";
    };

    zenyte.matugen.template = {
      GTK4 = {
        input = "gtk.css";
        output = "~/.config/gtk-4.0/gtk.css";
      };
      GTK3 = {
        input = "gtk.css";
        output = "~/.config/gtk-3.0/gtk.css";
      };
    };
  };
}
