{
  config,
  pkgs,
  lib,
  default,
  hostName,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.system.networking;
in
{
  options.zenyte.system.networking = {
    bluetooth = mkBoolOpt false "Whether to enable bluetooth.";
  };

  config = {
    # This fixed my problem with crates.io giving bad hashes and rust packages failing to build.
    # sudo nmcli connection modify "<wifi-connection-name>" ipv4.ignore-auto-dns yes ipv4.dns "1.1.1.1,1.0.0.1,8.8.8.8,8.8.4.4"

    services.resolved = {
      enable = true;
      dnssec = false;
      fallbackDns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };

    networking = {
      hostName = hostName;
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
      ];
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi = {
          powersave = false;
          # backend = "iwd";
        };
      };

      # wireless.iwd.settings = {
      #   Network = {
      #     EnableIPv6 = false;
      #   };
      #   Settings = {
      #     AutoConnect = true;
      #   };
      # };
    };

    hardware.bluetooth.enable = cfg.bluetooth;
    services.blueman.enable = cfg.bluetooth;
  };
}
