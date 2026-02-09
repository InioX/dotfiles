{
  config,
  pkgs,
  lib,
  inputs,
  nixpkgs,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.quickshell;
in {
  options.zenyte.desktop.addons.quickshell = {
    enable = mkBoolOpt false "Whether to enable quickshell.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
  };
}
