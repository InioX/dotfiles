{
  config,
  pkgs,
  lib,
  inputs,
  nixpkgs,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.waybar;
in {
  options.zenyte.desktop.addons.waybar = {
    enable = mkEnableOption "Whether to enable waybar with experimental patches.";
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

    zenyte.home.configFile."waybar".source = configFolder + /waybar;
  };
}