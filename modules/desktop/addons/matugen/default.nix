{
  config,
  pkgs,
  lib,
  inputs,
  zenyte-lib,
  configFolder,
  templateFolder,
  username,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.matugen;
in {
  options.zenyte.desktop.addons.matugen = {
    enable = mkBoolOpt true "Whether to enable matugen.";
  };

  imports = [
    inputs.matugen.nixosModules.default
  ];

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jq
    ];

    programs.matugen = {
      enable = true;

      # mode, default is "dark"
      variant = "dark";

      # output format of the generated JSON. default is "strip", e.g "0abcde"
      jsonFormat = "strip";

      # palette chooser. default is "default"
      palette = "default";

      templates = {
        "waybar-colors.css" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/waybar-colors.css";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/waybar/colors.css";
        };
        "rofi" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/colors.rasi";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/rofi/colors.rasi";
        };
        "GTK4" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/gtk.css";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/gtk-4.0/gtk.css";
        };
        "GTK3" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/gtk.css";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/gtk-3.0/colors.css";
        };
        "Hyprland-autostart" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/autostart.conf";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/hypr/autostart.conf";
        };
        "Hyprland-colors" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/colors.conf";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/hypr/colors.conf";
        };
        "dunst" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/dunstrc";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/dunst/dunstrc";
        };
        "firefox" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/userChrome.css";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.mozilla/firefox/ini/chrome/userChrome.css";
        };
        "starship" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/starship.toml";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/starship.toml";
        };
        "kitty" = {
          # input path, here given as a file written by nix
          input_path = "${templateFolder}/kitty.conf";

          # path will be generated in `${config.programs.matugen.theme.files}/.config/something.css`
          output_path = "~/.config/kitty/colors.conf";
        };
      };
    };
  };
}
