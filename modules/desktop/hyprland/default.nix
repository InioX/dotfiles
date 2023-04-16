{
  config,
  pkgs,
  lib,
  inputs,
  options,
  configFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.hyprland;
in {
  options.zenyte.desktop.hyprland = {
    enable = mkEnableOption "Whether to enable Hyprland, with other desktop addons.";
  };

  imports = [
    inputs.hyprland.nixosModules.default
  ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      playerctl
      inputs.nixpkgs-wayland.packages.${system}.wl-gammarelay-rs
    ];

    programs.hyprland.enable = true;

    zenyte.desktop.addons = {
      waybar.enable = true;
      kitty.enable = true;
      rofi.enable = true;
      sddm.enable = true;
      gtk.enable = true;
      dunst.enable = true;
    };

    zenyte.cli = {
      neofetch.enable = true;
    };
    
    zenyte.home.configFile."hypr".source = configFolder + /hypr;
  };
}