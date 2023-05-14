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
    ./desktop/addons/dunst
    ./desktop/addons/matugen
    ./desktop/addons/alacritty

    # Apps
    ./apps/firefox

    # CLI
    ./cli/zsh
    ./cli/git
    ./cli/neofetch

    # Home
    ./home
  ];
}
