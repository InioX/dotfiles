{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.test.desktop.hyprland;
in {
  options.test.desktop.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        make a description later
      '';
    };
  };

  imports = [
      inputs.hyprland.nixosModules.default
  ];

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}