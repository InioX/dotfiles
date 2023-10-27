{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte; let
in {
  imports = lib.zenyte.validFiles ./.;

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";
    palette = "default";

    templates = {
      "waybar-colors.css" = {
        input_path = "${default.templateFolder}/waybar-colors.css";
        output_path = "~/.config/waybar/colors.css";
      };
      "rofi" = {
        input_path = "${default.templateFolder}/colors.rasi";
        output_path = "~/.config/rofi/colors.rasi";
      };
      "GTK4" = {
        input_path = "${default.templateFolder}/gtk.css";
        output_path = "~/.config/gtk-4.0/gtk.css";
      };
      "GTK3" = {
        input_path = "${default.templateFolder}/gtk.css";
        output_path = "~/.config/gtk-3.0/colors.css";
      };
      "Hyprland-autostart" = {
        input_path = "${default.templateFolder}/autostart.conf";
        output_path = "~/.config/hypr/autostart.conf";
      };
      "Hyprland-colors" = {
        input_path = "${default.templateFolder}/colors.conf";
        output_path = "~/.config/hypr/colors.conf";
      };
      "dunst" = {
        input_path = "${default.templateFolder}/dunstrc";
        output_path = "~/.config/dunst/dunstrc";
      };
      "firefox" = {
        input_path = "${default.templateFolder}/userChrome.css";
        output_path = "~/.mozilla/firefox/ini/chrome/userChrome.css";
      };
      "starship" = {
        input_path = "${default.templateFolder}/starship.toml";
        output_path = "~/.config/starship.toml";
      };
      "kitty" = {
        input_path = "${default.templateFolder}/kitty.conf";
        output_path = "~/.config/kitty/colors.conf";
      };
    };
  };
}
