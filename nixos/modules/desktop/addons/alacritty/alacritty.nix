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

    zenyte.home.configFile = {
      "alacritty/alacritty.toml" = "alacritty/alacritty.toml";
    };

    zenyte.matugen.template = {
      alacritty = {
        input = "colors.toml";
        output = "~/.config/alacritty/colors.toml";
      };
    };
  };
}
