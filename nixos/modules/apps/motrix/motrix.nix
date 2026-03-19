{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.motrix;
in {
  options.zenyte.apps.motrix = {
    enable = mkBoolOpt false "Whether to enable motrix.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      motrix
    ];
  };
}
