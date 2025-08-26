{
  inputs,
  config,
  lib,
  options,
  default,
  hostName,
  impurity,
  pkgs,
  ...
}:
with lib; let
  cfg = config.zenyte.home;
  wallpaper = config.zenyte.system.hosts.${hostName}.wallpaper or default.wallpaper;

  matugenTemplates = {
    "waybar-colors.css" = {
      input_path = "${default.templateFolder}/waybar-colors.css";
      output_path = "~/.config/waybar/colors.css";
    };
    "ags" = {
      input_path = "${default.templateFolder}/colors.scss";
      output_path = "~/.config/ags/scss/colors.scss";
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

  # function to turn one template into TOML string
  templateToml = name: tpl: ''
    [templates.'${name}']
    input_path = "${tpl.input_path}"
    output_path = "${tpl.output_path}"
  '';

  # concatenate all into one TOML block
  templatesToml =
    lib.concatStringsSep "\n"
    (lib.mapAttrsToList templateToml matugenTemplates);

  themeFiles = config.programs.matugen.theme.files;
in {
  zenyte.home.configFile."matugen/config.toml".text = ''
    [config]

    [config.wallpaper]
    command = "hyprctl"
    arguments = ["hyprpaper", "reload"]

    ${templatesToml}
  '';

  systemd.services.run-matugen-once = {
    description = "Run matugen only once after install";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '
          if [ ! -f /var/lib/matugen-ran-once ]; then
            ${pkgs.matugen} image ${wallpaper}
            touch matugen-ran-once
          fi
        '
      '';
    };
  };

  programs.matugen = {
    enable = true;
    variant = config.zenyte.system.hosts.${hostName}.variant or "dark";
    jsonFormat = "hex";
    type = config.zenyte.system.hosts.${hostName}.type or "scheme-tonal-spot";

    inherit wallpaper;

    templates = matugenTemplates;
  };
}
