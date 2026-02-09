{
  config,
  pkgs,
  lib,
  inputs,
  options,
  default,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.hyprland;

  wallpaper =
    if builtins.hasAttr "wallpaper" options.zenyte.system.hosts.${hostName}
    then config.zenyte.system.hosts.${hostName}.wallpaper
    else default.wallpaper;
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
      wl-clip-persist
      grim
      slurp
      playerctl
      inputs.nixpkgs-wayland.packages.${system}.wl-gammarelay-rs
      # inputs.nixpkgs-wayland.packages.${system}.swww
      wf-recorder
      swww

      # For theme management
      nwg-look

      # Cursor theme
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    zenyte.home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default.override {
        enableNvidiaPatches = cfg.nvidiaPatches;
      };
    };

    zenyte.desktop.addons = {
      waybar = enabled;
      kitty = enabled;
      alacritty = enabled;
      rofi = enabled;
      gtk = enabled;
      dunst = enabled;
      thunar = enabled;
      ags = enabled;
      qt = enabled;
      quickshell = enabled;
    };

    zenyte.cli = {
      neofetch = enabled;
      starship = enabled;
    };

    # zenyte.home.configFile."hypr".source = default.configFolder + /hypr;
    # zenyte.home.configFile."hypr/icons".source = default.configFolder + /hypr/icons;
    # zenyte.home.configFile."hypr/scripts".source = default.configFolder + /hypr/scripts;
    # zenyte.home.configFile."hypr/wallpapers".source = default.configFolder + /hypr/wallpapers;
    # zenyte.home.configFile."hypr/hyprland.conf".source = default.configFolder + /hypr/hyprland.conf;
    # zenyte.home.configFile."hypr/keybindings.conf".source = default.configFolder + /hypr/keybindings.conf;
  };
}
