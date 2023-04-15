{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.test.desktop.addons.rofi;
in {
  options.test.desktop.addons.rofi = {
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
      rofi-wayland
    ];

    test.home.configFile."rofi".source = dotfilesFolder + /rofi;
  };
}