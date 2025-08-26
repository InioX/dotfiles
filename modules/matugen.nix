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
  themeFiles = config.programs.matugen.theme.files;
in {
  zenyte.home.configFile."matugen/config.toml".text = ''
    [config]

    [config.wallpaper]
    command = "swww"
    arguments = ["img", "--transition-type", "center"]

    [templates.waybar]
    input_path = "${default.templateFolder}/waybar-colors.css"
    output_path = "~/.config/waybar/colors.css"
    post_hook = 'pkill -SIGUSR2 waybar'

    [templates.kitty]
    input_path = "${default.templateFolder}/kitty.conf"
    output_path = "~/.config/kitty/themes/matugen.conf"
    post_hook = "kitty +kitten themes --dump-theme=yes --reload-in=all matugen &> /dev/null"

    [templates.dunst]
    input_path = "${default.templateFolder}/dunstrc"
    output_path = "~/.config/dunst/dunstrc"
    post_hook = 'pkill -SIGUSR2 dunst'

    [templates.ags]
    input_path = "${default.templateFolder}/colors.scss"
    output_path = "~/.config/ags/scss/colors.scss"

    [templates.rofi]
    input_path = "${default.templateFolder}/colors.rasi"
    output_path = "~/.config/rofi/colors.rasi"

    [templates.GTK4]
    input_path = "${default.templateFolder}/gtk.css"
    output_path = "~/.config/gtk-4.0/gtk.css"

    [templates.GTK3]
    input_path = "${default.templateFolder}/gtk.css"
    output_path = "~/.config/gtk-3.0/colors.css"

    [templates.Hyprland-autostart]
    input_path = "${default.templateFolder}/autostart.conf"
    output_path = "~/.config/hypr/autostart.conf"

    [templates.Hyprland-colors]
    input_path = "${default.templateFolder}/colors.conf"
    output_path = "~/.config/hypr/colors.conf"

    [templates.firefox]
    input_path = "${default.templateFolder}/userChrome.css"
    output_path = "~/.mozilla/firefox/ini/chrome/userChrome.css"

    [templates.starship]
    input_path = "${default.templateFolder}/starship.toml"
    output_path = "~/.config/starship.toml"
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
            touch /var/lib/matugen-ran-once
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
