{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.kitty;
in {
  options.zenyte.desktop.addons.kitty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      kitty
    ];

    zenyte.home.configFile."kitty".source = dotfilesFolder + /kitty;
  };
}