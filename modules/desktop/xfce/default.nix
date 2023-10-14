{
  config,
  pkgs,
  lib,
  zenyte-lib,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.xfce;
in {
  options.zenyte.desktop.xfce = {
    enable = mkBoolOpt false "Whether to enable xfce.";
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
