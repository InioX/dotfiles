{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.services.thermald;
in {
  options.zenyte.services.thermald = {
    enable = mkBoolOpt false "Whether to enable thermald.";
  };

  config = mkIf cfg.enable {
    services.thermald.enable = true;
  };
}
