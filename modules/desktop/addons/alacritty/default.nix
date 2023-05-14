{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.addons.alacritty;
in {
  options.zenyte.desktop.addons.alacritty = {
    enable = mkEnableOption "Whether to enable alacritty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];
  };
}
