{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.rofi;
in {
  options.zenyte.desktop.addons.rofi = {
    enable = mkBoolOpt false "Whether to enable rofi.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi-wayland
    ];

    zenyte.home.configFile."rofi/config.rasi".source = default.configFolder + /rofi/config.rasi;
    zenyte.home.configFile."rofi/powermenu.rasi".source = default.configFolder + /rofi/powermenu.rasi;
    zenyte.home.configFile."rofi/menu.rasi".source = default.configFolder + /rofi/menu.rasi;

    # Matugen template
    zenyte.home.configFile."rofi/colors.rasi".source = "${config.programs.matugen.theme.files}/.config/rofi/colors.rasi";
  };
}
