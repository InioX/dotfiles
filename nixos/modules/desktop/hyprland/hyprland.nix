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

    programs.gpu-screen-recorder.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      USE_WAYLAND = "1";
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wl-clip-persist
      # grim
      # slurp
      playerctl
      inputs.nixpkgs-wayland.packages.${system}.wl-gammarelay-rs
      # inputs.nixpkgs-wayland.packages.${system}.swww
      wf-recorder
      swww

      hyprshot
      hyprpicker

      adwaita-icon-theme
      hicolor-icon-theme

      imagemagick

      # For theme management
      nwg-look

      # Cursor theme
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default

      gpu-screen-recorder-gtk
      (pkgs.runCommand "gpu-screen-recorder" {
          nativeBuildInputs = [pkgs.makeWrapper];
        } ''
          mkdir -p $out/bin
          makeWrapper ${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder $out/bin/gpu-screen-recorder \
            --prefix LD_LIBRARY_PATH : ${pkgs.libglvnd}/lib \
            --prefix LD_LIBRARY_PATH : ${config.boot.kernelPackages.nvidia_x11}/lib
        '')
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
      alacritty = disabled;
      rofi = enabled;
      gtk = enabled;
      dunst = enabled;
      dolphin = enabled;
      ags = enabled;
      qt = enabled;
      quickshell = enabled;
      sddm = enabled;
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
