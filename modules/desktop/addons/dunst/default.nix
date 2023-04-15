{
  config,
  pkgs,
  lib,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.test.desktop.addons.dunst;
in {
  options.test.desktop.addons.dunst = {
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
      libnotify
    ];

    test.home.configFile."dunst".source = dotfilesFolder + /dunst;
    
    test.home.extraOptions.services.dunst = {
      enable = true;
      package = pkgs.dunst.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "k-vernooy";
          repo = "dunst";
          rev = "c7358148edef23e883586cca37c0c7ee4b363ce8";
          sha256 = "eZoIeLERDbXIBBm/j9jgqvvul2h0YNjzedbnQGMxsiU=";
        };
      });
    };
  };
}