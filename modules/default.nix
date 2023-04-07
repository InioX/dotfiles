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