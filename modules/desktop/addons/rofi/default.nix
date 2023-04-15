{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.rofi;
in {
  options.zenyte.desktop.addons.rofi = {
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

    zenyte.home.configFile."rofi".source = configFolder + /rofi;
  };
}