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
    command = "swww img --transition-type center {{ image }}"
    # arguments = ["img", "--transition-type", "center"]

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
    output_path = "~/.config/gtk-3.0/gtk.css"

    [templates.Hyprland-autostart]
    input_path = "${default.templateFolder}/autostart.conf"
    output_path = "~/.config/hypr/autostart.conf"

    [templates.Hyprland-colors]
    input_path = "${default.templateFolder}/colors.conf"
    output_path = "~/.config/hypr/colors.conf"

    [templates.starship]
    input_path = "${default.templateFolder}/starship.toml"
    output_path = "~/.config/starship.toml"

    [templates.pywalfox]
    input_path = '${default.templateFolder}/pywalfox-colors.json'
    output_path = '~/.cache/wal/colors.json'
    post_hook = 'pywalfox update'

    [templates.vscode]
    input_path = "${default.templateFolder}/hyprlunavsc.json"
    output_path = "~/.vscode/extensions/hyprluna.hyprluna-theme-1.0.2/themes/hyprluna.json"

    [templates.alacritty]
    input_path = "${default.templateFolder}/colors.toml"
    output_path = "~/.config/alacritty/colors.toml"

    [templates.discord]
    input_path = "${default.templateFolder}/discord.css"
    output_path = "~/.config/Vencord/themes/midnight-discord.css"

    [templates.qt5ct]
    input_path = "${default.templateFolder}/matugen.conf"
    output_path = "~/.config/qt5ct/colors/matugen.conf"

    [templates.qt6ct]
    input_path = "${default.templateFolder}/matugen.conf"
    output_path = "~/.config/qt6ct/colors/matugen.conf"

    [templates.quickshell]
    input_path = "${default.templateFolder}/quickshell.json"
    output_path = "~/.local/state/quickshell/generated/colors.json"

    [templates.firefox-website-colors]
    input_path = "${default.templateFolder}/firefox-colors.css"
    output_path = "~/.mozilla/firefox/ini/chrome/colors.css"

    [templates.steam]
    input_path = '${default.templateFolder}/steam.css'
    output_path = '~/.config/AdwSteamGtk/custom.css'
    post_hook =  'adwaita-steam-gtk -i'
  '';

  system.activationScripts.run-matugen-once = ''
    set -e

    if [ ! -f /home/${default.username}/.local/share/matugen-ran-once ]; then
      su -u ini ${pkgs.vscode}/bin/code --install-extension HyprLuna.hyprluna-theme
      su -u ini ${pkgs.matugen}/bin/matugen image ${wallpaper}

      touch /home/${default.username}/.local/share/matugen-ran-once
    fi
  '';

  programs.matugen = {
    enable = true;
    variant = config.zenyte.system.hosts.${hostName}.variant or "dark";
    jsonFormat = "hex";
    type = config.zenyte.system.hosts.${hostName}.type or "scheme-tonal-spot";

    inherit wallpaper;

    templates = matugenTemplates;
  };
}
