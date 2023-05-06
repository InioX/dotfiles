{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib;
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
in {
  options.zenyte.desktop.addons.gtk = {
    enable = mkEnableOption "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      lxappearance-gtk2
      libadwaita

      gsettings-desktop-schemas

      reload-theme
    ];

    zenyte.home.extraOptions.gtk = {
      enable = true;
      # font.name = "Victor Mono SemiBold 12";
      theme = with pkgs; {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    # This fixes the `no schemas installed` error with gsettings

    zenyte.home.configFile."gtk-2.0".source = configFolder + /gtk-2.0;

    zenyte.home.configFile."gtk-3.0/bookmarks".source = configFolder + /gtk-3.0/bookmarks;
    zenyte.home.configFile."gtk-3.0/settings.ini".source = configFolder + /gtk-3.0/settings.ini;
    zenyte.home.configFile."gtk-3.0/gtk.css".source = configFolder + /gtk-3.0/gtk.css;

    zenyte.home.configFile."gtk-4.0/colors.css".source = configFolder + /gtk-3.0/colors.css;
    zenyte.home.configFile."gtk-4.0/settings.ini".source = configFolder + /gtk-3.0/settings.ini;
  };
}