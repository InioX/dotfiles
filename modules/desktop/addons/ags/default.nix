{
  config,
  pkgs,
  lib,
  configFolder,
  system,
  inputs,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.addons.ags;
in {
  options.zenyte.desktop.addons.ags = {
    enable = mkEnableOption "Whether to enable ags.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.ags.packages.${system}.default
    ];
  };
}
