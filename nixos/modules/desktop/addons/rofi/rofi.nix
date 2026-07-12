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
  cfg = config.zenyte.desktop.addons.rofi;
in
{
  options.zenyte.desktop.addons.rofi = {
    enable = mkBoolOpt false "Whether to enable rofi.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi
    ];

    zenyte.matugen.template = {
      rofi = {
        input = "colors.rasi";
        output = "~/.config/rofi/colors.rasi";
      };
    };
  };
}
