{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.addons.rofi;
in {
  options.zenyte.desktop.addons.rofi = {
    enable = mkEnableOption "Whether to enable rofi.";
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
