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
    environment.systemPackages = with pkgs; [
      kitty
      wl-clipboard
      grim
      slurp
      alacritty
      wofi
      playerctl
      pcmanfm
    ];
    test.home.extraOptions = {
       wayland.windowManager.hyprland = {
          enable = true;
          extraConfig = builtins.readFile ./hyprland.conf;
       };
    };
  };
}