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
  cfg = config.zenyte.desktop.addons.waybar;
in {
  options.zenyte.desktop.addons.waybar = {
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

    zenyte.home.configFile."waybar".source = dotfilesFolder + /waybar;
  };
}