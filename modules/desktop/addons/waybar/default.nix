{
  config,
  pkgs,
  lib,
  inputs,
  nixpkgs,
  dotfilesFolder,
  ...
}:
with lib;
let
  cfg = config.test.desktop.addons.waybar;
in {
  options.test.desktop.addons.waybar = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      waybar
    ];

    test.home.configFile."waybar".source = dotfilesFolder + /waybar;
  };
}