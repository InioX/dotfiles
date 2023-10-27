{
  config,
  pkgs,
  lib,
  inputs,
  zenyte-lib,
  configFolder,
  templateFolder,
  ...
}:
with lib;
with zenyte-lib; let
in {
  imports = validFiles ./.;

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    palette = "default";

    templates = {
      "waybar-colors.css" = {
        input_path = "${templateFolder}/waybar-colors.css";
        output_path = "~/.config/waybar/colors.css";
      };
      "rofi" = {
        input_path = "${templateFolder}/colors.rasi";
        output_path = "~/.config/rofi/colors.rasi";
      };
      "GTK4" = {
        input_path = "${templateFolder}/gtk.css";
        output_path = "~/.config/gtk-4.0/gtk.css";
      };
      "GTK3" = {
        input_path = "${templateFolder}/gtk.css";
        output_path = "~/.config/gtk-3.0/colors.css";
      };
      "Hyprland-autostart" = {
        input_path = "${templateFolder}/autostart.conf";
        output_path = "~/.config/hypr/autostart.conf";
      };
      "Hyprland-colors" = {
        input_path = "${templateFolder}/colors.conf";
        output_path = "~/.config/hypr/colors.conf";
      };
      "dunst" = {
        input_path = "${templateFolder}/dunstrc";
        output_path = "~/.config/dunst/dunstrc";
      };
      "firefox" = {
        input_path = "${templateFolder}/userChrome.css";
        output_path = "~/.mozilla/firefox/ini/chrome/userChrome.css";
      };
      "starship" = {
        input_path = "${templateFolder}/starship.toml";
        output_path = "~/.config/starship.toml";
      };
      "kitty" = {
        input_path = "${templateFolder}/kitty.conf";
        output_path = "~/.config/kitty/colors.conf";
      };
    };
  };
}
