{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.wayland;
in
{
  options.zenyte.desktop.wayland = {
    enable = mkBoolOpt false "Whether to enable common wayland stuff.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      USE_WAYLAND = "1";
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-wlr
      ];
      config = {
        hyprland.default = [
          "hyprland"
          "gtk"
        ];
        common.default = [ "gnome" ];
        # niri = {
        # "org.freedesktop.impl.portal.ScreenCast" = lib.mkForce "wlr";
        # "org.freedesktop.impl.portal.Screenshot" = lib.mkForce "wlr";
        # };
      };
    };

    environment.systemPackages = with pkgs; [
      bibata-cursors

      nwg-look

      # wl-clipboard
      wl-clip-persist
      cliphist
      wf-recorder
      awww

      adwaita-icon-theme
      hicolor-icon-theme

      imagemagick

      playerctl
      brightnessctl
    ];

    zenyte.desktop.addons = {
      waybar = disabled;
      kitty = enabled;
      alacritty = disabled;
      rofi = enabled;
      gtk = enabled;
      dunst = enabled;
      # dolphin = enabled;
      nautilus = enabled;
      ags = disabled;
      qt = enabled;
      quickshell = enabled;
      sddm = enabled;
    };

    zenyte.cli = {
      neofetch = enabled;
      starship = enabled;
    };
  };
}
