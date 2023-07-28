{
  config,
  pkgs,
  lib,
  configFolder,
  templateFolder,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.addons.matugen;
in {
  options.zenyte.desktop.addons.matugen = {
    enable = mkEnableOption "Whether to enable matugen.";
  };

  config = mkIf cfg.enable {
    zenyte.home.configFile."matugen/config.toml".text = ''
      [config]
      reload_apps = true
      reload_gtk_theme = false
      set_wallpaper = true
      wallpaper_tool = 'Swww'
      prefix = '@'
      swww_options = [
          "--transition-type",
          "center",
      ]
      run_after = [
        [ "reload-theme" ],
        [ "pkill", "dunst" ]
      ]

      [templates.waybar]
      input_path = "${templateFolder}/waybar-colors.css"
      output_path = "~/.config/waybar/colors.css"

      [templates.rofi]
      input_path = "${templateFolder}/colors.rasi"
      output_path = "~/.config/rofi/colors.rasi"

      [templates.GTK4]
      input_path = "${templateFolder}/gtk.css"
      output_path = "~/.config/gtk-4.0/gtk.css"

      [templates.GTK3]
      input_path = "${templateFolder}/gtk.css"
      output_path = "~/.config/gtk-3.0/colors.css"

      [templates.Hyprland-autostart]
      input_path = "${templateFolder}/autostart.conf"
      output_path = "~/.config/hypr/autostart.conf"

      [templates.Hyprland-colors]
      input_path = "${templateFolder}/colors.conf"
      output_path = "~/.config/hypr/colors.conf"

      [templates.dunst]
      input_path = "${templateFolder}/dunstrc"
      output_path = "~/.config/dunst/dunstrc"

      # [templates.starship]
      # input_path = "${templateFolder}/starship.toml"
      # output_path = "~/.config/starship.toml"

      [templates.kitty]
      input_path = "${templateFolder}/kitty.conf"
      output_path = "~/.config/kitty/colors.conf"

      # [templates.neovim]
      # input_path = "${templateFolder}/init.lua"
      # output_path = "~/.config/nvim/lua/user/plugins/init.lua"
    '';
  };
}
