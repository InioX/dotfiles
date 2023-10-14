{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.kitty;
in {
  options.zenyte.desktop.addons.kitty = {
    enable = mkBoolOpt false "Whether to enable kitty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    zenyte.home.configFile."kitty/kitty.conf".source = configFolder + /kitty/kitty.conf;
  };
}
