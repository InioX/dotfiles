{
  config,
  pkgs,
  lib,
  zenyte-lib,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.alacritty;
in {
  options.zenyte.desktop.addons.alacritty = {
    enable = mkBoolOpt false "Whether to enable alacritty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];
  };
}
