{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.browsers.chromium;
in {
  options.zenyte.browsers.chromium = {
    enable = mkBoolOpt false "Whether to enable chromium.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      chromium
    ];
  };
}
