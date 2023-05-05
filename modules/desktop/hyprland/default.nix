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
      inputs.nixpkgs-wayland.packages.${system}.swww
      wf-recorder
    ];

    programs.hyprland.enable = true;

    zenyte.desktop.addons = {
      waybar.enable = true;
      kitty.enable = true;
      rofi.enable = true;
      sddm.enable = true;
      gtk.enable = true;
      dunst.enable = true;
      matugen.enable = true;
    };

    zenyte.cli = {
      neofetch.enable = true;
    };
    
    # zenyte.home.configFile."hypr".source = configFolder + /hypr;
    zenyte.home.configFile."hypr/icons".source = configFolder + /hypr/icons;
    zenyte.home.configFile."hypr/scripts".source = configFolder + /hypr/scripts;
    zenyte.home.configFile."hypr/wallpapers".source = configFolder + /hypr/wallpapers;
    zenyte.home.configFile."hypr/hyprland.conf".source = configFolder + /hypr/hyprland.conf;
    zenyte.home.configFile."hypr/keybindings.conf".source = configFolder + /hypr/keybindings.conf;
  };
}