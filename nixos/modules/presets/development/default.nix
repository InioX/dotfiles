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
  cfg = config.zenyte.presets.development;
in
{
  options.zenyte.presets.development = {
    enable = mkBoolOpt false "Whether to enable the development suite.";
  };

  config = mkIf cfg.enable {
    zenyte.apps = {
      vscodium = {
        enable = false;
        extensions = with pkgs.vscode-extensions; [
        ];
      };
      zed = {
        enable = true;
      };
      helix = {
        enable = true;
      };
    };

    zenyte.cli = {
      git = enabled;
    };
  };
}
