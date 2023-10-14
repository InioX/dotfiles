{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.rofi;
in {
  options.zenyte.desktop.addons.rofi = {
    enable = mkBoolOpt false "Whether to enable rofi.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi-wayland
    ];

    zenyte.home.configFile."rofi/config.rasi".source = configFolder + /rofi/config.rasi;
    zenyte.home.configFile."rofi/powermenu.rasi".source = configFolder + /rofi/powermenu.rasi;
    zenyte.home.configFile."rofi/menu.rasi".source = configFolder + /rofi/menu.rasi;
  };
}
