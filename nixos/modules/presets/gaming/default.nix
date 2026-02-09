{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.gaming;
in {
  options.zenyte.presets.gaming = {
    enable = mkBoolOpt false "Whether to enable the gaming preset.";
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    zenyte.gaming = {
      steam = enabled;
      lutris = enabled;
    };
  };
}
