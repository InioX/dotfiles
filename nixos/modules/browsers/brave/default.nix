{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.browsers.brave;
in {
  options.zenyte.browsers.brave = {
    enable = mkBoolOpt false "Whether to enable brave.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
