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
  cfg = config.zenyte.system.networking;
in {
  options.zenyte.system.networking = {
    bluetooth = mkBoolOpt false "Whether to enable bluetooth.";
  };

  config = {
    networking = {
      hostName = hostName;
      networkmanager.enable = true;
    };

    hardware.bluetooth.enable = cfg.bluetooth;
    services.blueman.enable = cfg.bluetooth;
  };
}
