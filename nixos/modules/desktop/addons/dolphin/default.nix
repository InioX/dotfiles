{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.dolphin;
in {
  options.zenyte.desktop.addons.dolphin = {
    enable = mkBoolOpt false "Whether to enable dolphin.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
    ];
  };
}
