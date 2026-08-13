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
  cfg = config.zenyte.desktop.addons.ghostty;
in
{
  options.zenyte.desktop.addons.ghostty = {
    enable = mkBoolOpt false "Whether to enable ghostty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ghostty
      jq
    ];

    zenyte.home.configFile = {
      "ghostty/" = "ghostty/";
    };

    zenyte.matugen.template = {
      ghostty = {
        input = "ghostty";
        output = "~/.config/ghostty/themes/Matugen";
        post_hook = "pkill -SIGUSR2 ghostty";
      };
    };
  };
}
