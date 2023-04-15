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
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      lxappearance-gtk2
      libadwaita
    ];

    zenyte.home.extraOptions.gtk = {
      enable = true;
      # font.name = "Victor Mono SemiBold 12";
      theme = with pkgs; {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    zenyte.home.configFile."gtk-2.0".source = configFolder + /gtk-2.0;
    zenyte.home.configFile."gtk-3.0".source = configFolder + /gtk-3.0;
    zenyte.home.configFile."gtk-4.0".source = configFolder + /gtk-4.0;
  };
}