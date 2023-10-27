{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.discord;
in {
  options.zenyte.apps.discord = {
    enable = mkBoolOpt false "Whether to enable discord.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Most Electron Applications
      USE_WAYLAND = "1"; # ArmCord
    };

    environment.systemPackages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = false;
      })
    ];

    zenyte.home.configFile."discord/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true,
        "openasar": {
          "setup": false,
          "noTyping": true,
        },
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "WINDOW_BOUNDS": {
          "x": 92,
          "y": 14,
          "width": 1814,
          "height": 1052
        },
        "trayBalloonShown": true,
        "MINIMIZE_TO_TRAY": false
      }
    '';
  };
}
