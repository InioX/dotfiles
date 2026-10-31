{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.vlc;
in {
  options.zenyte.apps.vlc = {
    enable = mkBoolOpt false "Whether to enable vlc.";
    enableChromecast = mkBoolOpt false "Whether to enable support for chromecasting.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vlc
    ];

    networking.firewall = mkIf cfg.enableChromecast {
      allowedUDPPorts = [5353];
      allowedTCPPortRanges = [
        {
          from = 8010;
          to = 8012;
        }
      ];
    };

    services.avahi = mkIf cfg.enableChromecast {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
