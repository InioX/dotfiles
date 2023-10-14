{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  system,
  inputs,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.ags;
in {
  options.zenyte.desktop.addons.ags = {
    enable = mkBoolOpt false "Whether to enable ags.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.ags.packages.${system}.default
    ];
  };
}
