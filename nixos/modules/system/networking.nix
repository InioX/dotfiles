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
    # This fixed my problem with crates.io giving bad hashes and rust packages failing to build.
    # sudo nmcli connection modify "<wifi-connection-name>" ipv4.ignore-auto-dns yes ipv4.dns "1.1.1.1,1.0.0.1,8.8.8.8,8.8.4.4"

    # services.resolved = {
    #   enable = true;
    #   settings = {
    #     Resolve = {
    #       DNSSEC = false;
    #       FallbackDNS = [
    #         "1.1.1.1"
    #         "8.8.8.8"
    #       ];
    #     };
    #   };
    # };

    boot.kernelParams = [
      "rtw89_pci.disable_aspm_l1=Y"
      "rtw89_pci.disable_aspm_l1ss=Y"
      "rtw89_core.disable_ps_mode=Y"
    ];

    networking = {
      hostName = hostName;
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
      ];
      networkmanager = {
        enable = true;
        wifi = {
          powersave = false;
          backend = "wpa_supplicant";
        };
        settings = {
          ipv4.ignore-auto-dns = true;
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
