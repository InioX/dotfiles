{
  config,
  pkgs,
  lib,
  default,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.hosts.${hostName};
in {
  options.zenyte.system.hosts.${hostName} = {
    wallpaper = mkOpt types.package default.wallpaper "The wallpaper to use for current host.";
  };

  config = {
  };
}
