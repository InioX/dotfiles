{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.kitty;
in {
  options.zenyte.desktop.addons.kitty = {
    enable = mkEnableOption "Whether to enable kitty.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      kitty
    ];

    zenyte.home.configFile."kitty/kitty.conf".source = configFolder + /kitty/kitty.conf;
  };
}