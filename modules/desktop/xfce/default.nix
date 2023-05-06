{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.xfce;
in {
  options.zenyte.desktop.xfce = {
    enable = mkEnableOption "Whether to enable xfce.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;

    # Enable the XFCE Desktop Environment.
    services.xserver.desktopManager.xfce.enable = true;

    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };
  };
}
