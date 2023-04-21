{
  config,
  pkgs,
  lib,
  configFolder,
  templateFolder,
  ...
}:
with lib;
let
  cfg = config.zenyte.desktop.addons.matugen;
in {
  options.zenyte.desktop.addons.matugen = {
    enable = mkEnableOption "Whether to enable matugen.";
  };

  config = mkIf cfg.enable {
    zenyte.home.configFile."matugen/config.ini".text = ''
    [waybar]
    template_path = ${templateFolder}/waybar-colors.css
    output_path = ~/.config/waybar/colors.css

    [rofi]
    template_path = ${templateFolder}/colors.rasi
    output_path = ~/.config/rofi/colors.rasi

    [GTK4]
    template_path = ${templateFolder}/gtk.css
    output_path = ~/.config/gtk-4.0/gtk.css

    [GTK3]
    template_path = ${templateFolder}/gtk.css
    output_path = ~/.config/gtk-3.0/colors.css

    [Hyprland - autostart]
    template_path = ${templateFolder}/autostart.conf
    output_path = ~/.config/hypr/autostart.conf

    [Hyprland - colors]
    template_path = ${templateFolder}/colors.conf
    output_path = ~/.config/hypr/colors.conf

    # [starship]
    # template_path = ${templateFolder}/starship.toml
    # output_path = ~/.config/starship.toml

    [kitty]
    template_path = ${templateFolder}/kitty.conf
    output_path = ~/.config/kitty/colors.conf

    # [neovim]
    # template_path = ${templateFolder}/init.lua
    # output_path = ~/.config/nvim/lua/user/plugins/init.lua
    '';
  };
}