{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.tdesktop;
in {
  options.zenyte.apps.tdesktop = {
    enable = mkBoolOpt false "Whether to enable tdesktop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tdesktop
    ];
  };
}
