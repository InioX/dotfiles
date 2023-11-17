{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.common;
in {
  options.zenyte.presets.common = {
    enable = mkBoolOpt false "Whether to enable the common suite.";
  };

  config = mkIf cfg.enable {
    zenyte.system = {
      diffScript = true;
      sound = enabled;

      networking = {
        bluetooth = true;
      };

      fonts = {
        nerd-fonts = true;
      };
    };

    zenyte.cli = {
      bash = enabled;
      eza = enabled;
    };
  };
}
