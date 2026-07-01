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
  cfg = config.zenyte.apps.discord;
in
{
  options.zenyte.apps.discord = {
    enable = mkBoolOpt false "Whether to enable discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      # ((pkgs.callPackage "${
      #           pkgs.fetchFromGitHub {
      #             owner = "LuckShiba";
      #             repo = "nixpkgs";
      #             rev = "discord-vk";
      #             sha256 = "sha256-ZsqGzg2hD8e40wwc1kgJGt2qgI8dsp7uDR9OiTGGPbc=";
      #           }
      #         }/pkgs/applications/networking/instant-messengers/discord" {}).discord.override {
      #   withOpenASAR = true;
      #   withVencord = true;
      # })

      # (pkgs.discord.overrideAttrs (oldAttrs: {
      #     version = "0.0.124";
      #     src = pkgs.fetchurl {
      #       url = "https://dl.discordapp.net/apps/linux/0.0.124/discord-0.0.124.tar.gz";
      #       hash = "sha256-21ddAZveT1EXYr5cUoiIzD7uAbtF94EXW04VKGS5izM=";
      #     };
      # }))

      # vesktop

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
