{
  config,
  pkgs,
  lib,
  zenyte-lib,
  inputs,
  options,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.hyprland;
in {
  options.zenyte.desktop.hyprland = {
    enable = mkBoolOpt false "Whether to enable Hyprland, with other desktop addons.";
    nvidiaPatches = mkBoolOpt false "Whether to enable nvidia patches for hyprland.";
  };

  imports = [
    inputs.hyprland.nixosModules.default
  ];

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
      playerctl
      inputs.nixpkgs-wayland.packages.${system}.wl-gammarelay-rs
      inputs.nixpkgs-wayland.packages.${system}.swww
      wf-recorder
    ];

    zenyte.home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default.override {
        enableNvidiaPatches = cfg.nvidiaPatches;
      };
    };

    zenyte.desktop.addons = {
      waybar.enable = true;
      kitty.enable = true;
      rofi.enable = true;
      sddm.enable = true;
      gtk.enable = true;
      dunst.enable = true;
      matugen.enable = true;
      ags.enable = true;
      thunar.enable = true;
    };

    zenyte.cli = {
      neofetch.enable = true;
      starship.enable = true;
    };

    # zenyte.home.configFile."hypr".source = configFolder + /hypr;
    zenyte.home.configFile."hypr/icons".source = configFolder + /hypr/icons;
    zenyte.home.configFile."hypr/scripts".source = configFolder + /hypr/scripts;
    zenyte.home.configFile."hypr/wallpapers".source = configFolder + /hypr/wallpapers;
    zenyte.home.configFile."hypr/hyprland.conf".source = configFolder + /hypr/hyprland.conf;
    zenyte.home.configFile."hypr/keybindings.conf".source = configFolder + /hypr/keybindings.conf;

    zenyte.home.configFile."hypr/colors.conf".source = "${config.programs.matugen.theme.files}/.config/hypr/colors.conf";
    zenyte.home.configFile."hypr/autostart.conf".source = "${config.programs.matugen.theme.files}/.config/hypr/autostart.conf";
  };
}
