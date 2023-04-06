{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.test.apps.firefox;
in {
  options.test.apps.firefox = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}