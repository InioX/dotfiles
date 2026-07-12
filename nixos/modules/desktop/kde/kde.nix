{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.kde;
in
{
  options.zenyte.desktop.kde = {
    enable = mkBoolOpt false "Whether to enable kde.";
  };

  config = mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    zenyte.matugen.template = {
      kde = {
        input = "matugen.conf";
        output = "~/.local/share/color-schemes/matugen.colors";
        post_hook = "plasma-apply-colorscheme BreezeDark && plasma-apply-colorscheme matugen";
      };
    };
  };
}
