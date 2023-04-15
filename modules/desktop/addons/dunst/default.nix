{
  config,
  pkgs,
  lib,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.dunst;
in {
  options.zenyte.desktop.addons.dunst = {
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

    zenyte.home.configFile."dunst".source = configFolder + /dunst;
    
    zenyte.home.extraOptions.services.dunst = {
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