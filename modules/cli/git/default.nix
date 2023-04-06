{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.test.cli.git;
in {
  options.test.cli.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;
  };
}