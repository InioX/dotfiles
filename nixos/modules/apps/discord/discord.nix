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
    environment.systemPackages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })

      vesktop

      qtscrcpy
    ];

    # zenyte.home.configFile."discord/settings.json".text = ''
    #   {
    #     "SKIP_HOST_UPDATE": true,
    #     "openasar": {
    #       "setup": true,
    #       "noTyping": true,
    #       "quickstart": true,
    #     },
    #     "IS_MAXIMIZED": true,
    #     "IS_MINIMIZED": false,
    #     "trayBalloonShown": true,
    #     "MINIMIZE_TO_TRAY": false,
    #     "OPEN_ON_STARTUP": false,
    #   }
    # '';
  };
}
