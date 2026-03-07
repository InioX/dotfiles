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
  # https://github.com/FlameFlag/nixcord/issues/55#issuecomment-2480617637
  # krisp-patcher $(find ~/.config/discord/ -name "discord_krisp.node" -path "*/modules/discord_krisp/*")
  krisp-patcher =
    pkgs.writers.writePython3Bin "krisp-patcher"
    {
      libraries = with pkgs.python3Packages; [
        capstone
        pyelftools
      ];
      flakeIgnore = [
        "E501" # line too long (82 > 79 characters)
        "F403" # 'from module import *' used; unable to detect undefined names
        "F405" # name may be undefined, or defined from star imports: module
      ];
    }
    (
      builtins.readFile (
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/sersorrel/sys/afc85e6b249e5cd86a7bcf001b544019091b928c/hm/discord/krisp-patcher.py";
          sha256 = "sha256-h8Jjd9ZQBjtO3xbnYuxUsDctGEMFUB5hzR/QOQ71j/E=";
        }
      )
    );
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

      krisp-patcher
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
