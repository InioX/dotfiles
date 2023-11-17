{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.development;
in {
  options.zenyte.presets.development = {
    enable = mkBoolOpt false "Whether to enable the development suite.";
  };

  config = mkIf cfg.enable {
    zenyte.apps = {
      vscodium = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
        ];
      };
    };

    zenyte.cli = {
      git = enabled;
    };
  };
}
