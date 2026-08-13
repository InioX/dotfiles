
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

    # zenyte.home.configFile = {
    #   "kitty/kitty.conf" = "kitty/kitty.conf";
    # };

    # zenyte.matugen.template = {
    #   kitty = {
    #     input = "kitty.conf";
    #     output = "~/.config/kitty/themes/matugen.conf";
    #     post_hook = "kitty +kitten themes --dump-theme=yes --reload-in=all matugen &> /dev/null";
    #   };
    # };
  };
}
