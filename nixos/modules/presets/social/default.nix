{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.social;
in {
  options.zenyte.presets.social = {
    enable = mkBoolOpt false "Whether to enable the social preset.";
  };

  config = mkIf cfg.enable {
    zenyte.apps = {
      tdesktop = enabled;
      discord = enabled;
      gmail = enabled;
      github = enabled;
    };
  };
}
