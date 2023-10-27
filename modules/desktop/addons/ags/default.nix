{
  config,
  pkgs,
  lib,
  default,
  inputs,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.ags;
in {
  options.zenyte.desktop.addons.ags = {
    enable = mkBoolOpt false "Whether to enable ags.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.ags.packages.${default.system}.default
    ];
  };
}
