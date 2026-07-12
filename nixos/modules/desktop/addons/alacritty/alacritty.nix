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
  cfg = config.zenyte.desktop.addons.alacritty;
in
{
  options.zenyte.desktop.addons.alacritty = {
    enable = mkBoolOpt false "Whether to enable alacritty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];

    zenyte.matugen.template = {
      discord = {
        input = "discord.css";
        output = "~/.config/Vencord/themes/midnight-discord.css";
      };
      vesktop = {
        input = "discord.css";
        output = "~/.config/vesktop/themes/midnight-discord.css";
      };
    };
  };
}
