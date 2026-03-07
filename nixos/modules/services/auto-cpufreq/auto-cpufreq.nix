{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.services.auto-cpufreq;
in {
  options.zenyte.services.auto-cpufreq = {
    enable = mkBoolOpt false "Whether to enable auto-cpufreq.";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq.enable = true;
  };
}
