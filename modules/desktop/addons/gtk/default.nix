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
in {
  options.zenyte.desktop.addons.gtk = {
    enable = mkEnableOption "Whether to enable gtk theme.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      lxappearance-gtk2
      libadwaita

      gsettings-desktop-schemas
    ];

    environment.sessionVariables = rec {
      XDG_DATA_DIRS = pkgs.lib.mkOverride 0
      "export XDG_DATA_DIRS=$(echo $(nix-build --no-out-link '<nixpkgs>' -A gsettings-desktop-schemas)/share/gsettings-schemas/gsettings-desktop-schemas-*):$XDG_DATA_DIRS";
    };

    zenyte.home.extraOptions.gtk = {
      enable = true;
      # font.name = "Victor Mono SemiBold 12";
      theme = with pkgs; {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    # TODO: Figure out why this doesnt work
    # zenyte.home.extraOptions = {
      # This fixes the `no schemas installed` error with gsettings
      # xdg.systemDirs.data = [
        # "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-/${pkgs.gsettings-desktop-schemas.version}"
      # ];
    # };

    zenyte.home.configFile."gtk-2.0".source = configFolder + /gtk-2.0;

    zenyte.home.configFile."gtk-3.0/bookmarks".source = configFolder + /gtk-3.0/bookmarks;
    zenyte.home.configFile."gtk-3.0/settings.ini".source = configFolder + /gtk-3.0/settings.ini;
    zenyte.home.configFile."gtk-3.0/gtk.css".source = configFolder + /gtk-3.0/gtk.css;

    zenyte.home.configFile."gtk-4.0/colors.css".source = configFolder + /gtk-3.0/colors.css;
    zenyte.home.configFile."gtk-4.0/settings.ini".source = configFolder + /gtk-3.0/settings.ini;
  };
}