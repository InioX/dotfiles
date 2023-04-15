{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.test.desktop.xfce;
in {
  options.test.desktop.xfce = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
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