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
      nameservers = ["1.1.1.1" "8.8.8.8"];
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          backend = "iwd";
        };
      };
    };

    hardware.bluetooth.enable = cfg.bluetooth;
    services.blueman.enable = cfg.bluetooth;
  };
}
