{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.test.desktop.addons.gtk;
in {
  options.test.desktop.addons.gtk = {
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

    test.home.extraOptions.gtk = {
      enable = true;
      # font.name = "Victor Mono SemiBold 12";
      theme = with pkgs; {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    test.home.configFile."gtk-2.0".source = dotfilesFolder + /gtk-2.0;
    test.home.configFile."gtk-3.0".source = dotfilesFolder + /gtk-3.0;
    test.home.configFile."gtk-4.0".source = dotfilesFolder + /gtk-4.0;
  };
}