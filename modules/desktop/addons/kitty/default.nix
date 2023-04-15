{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.test.desktop.addons.kitty;
in {
  options.test.desktop.addons.kitty = {
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

    test.home.configFile."kitty".source = dotfilesFolder + /kitty;
  };
}