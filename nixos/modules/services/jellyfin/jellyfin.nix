{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.services.jellyfin;
in {
  options.zenyte.services.jellyfin = {
    enable = mkBoolOpt false "Whether to enable jellyfin.";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
