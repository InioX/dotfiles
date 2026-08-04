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
  cfg = config.zenyte.apps.helix;
in
{
  options.zenyte.apps.helix = {
    enable = mkBoolOpt false "Whether to enable helix.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];

    zenyte.home.configFile = {
      "helix/" = "helix/";
    };

    zenyte.matugen.template = {
      helix = {
        input = "helix/helix.toml";
        output = "~/.config/helix/themes/matugen.toml";
      };
    };
  };
}
