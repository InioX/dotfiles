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
  cfg = config.zenyte.apps.zed;
in
{
  options.zenyte.apps.zed = {
    enable = mkBoolOpt false "Whether to enable zed.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # zed
      nixd
      package-version-server
      zed-editor
    ];
  };
}
