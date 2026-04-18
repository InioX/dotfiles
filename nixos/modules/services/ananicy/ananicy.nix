{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.services.ananicy;
in {
  options.zenyte.services.ananicy = {
    enable = mkBoolOpt false "Whether to enable ananicy.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ananicy-cpp
      ananicy-rules-cachyos
    ];

    services = {
      ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
        extraRules = [
          # Prevent Discord/Vesktop audio crackling during gaming
          {
            name = "vesktop";
            type = "LowLatency_RT";
          }
          {
            name = "Discord";
            type = "LowLatency_RT";
          }
          # PipeWire audio server needs RT priority
          {
            name = "pipewire";
            type = "LowLatency_RT";
          }
          {
            name = "pipewire-pulse";
            type = "LowLatency_RT";
          }
        ];
      };
    };
  };
}
