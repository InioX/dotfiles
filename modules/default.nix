{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Desktop
    ./desktop/hyprland
    ./desktop/xfce
    ./desktop/awesome
    
    # Desktop addons
    ./desktop/addons/waybar
    ./desktop/addons/kitty
    ./desktop/addons/rofi
    ./desktop/addons/sddm
    ./desktop/addons/gtk

    # System
    ./system

    # Apps
    ./apps/firefox

    # CLI
    ./cli/git
    
    # Home
    ./home
  ];
}