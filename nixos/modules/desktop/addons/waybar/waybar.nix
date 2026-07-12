{
  config,
  pkgs,
  lib,
  inputs,
  nixpkgs,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.addons.waybar;
  mediaplayer-waybar = pkgs.writeShellScriptBin "mediaplayer-waybar" ''
    while true; do
      sleep 0.5

      playerctlstatus=$(playerctl status 2> /dev/null)

      if [[ $playerctlstatus ==  "" ]]; then
        echo '{ "text": "󰐍", "class": "none" }'
      elif [[ $playerctlstatus =~ "Playing" ]]; then
        echo '{ "text": "󰏦", "class": "playing" }'
      else
        echo '{ "text": "󰐍", "class": "paused" }'
      fi

      wait
    done
  '';
in
{
  options.zenyte.desktop.addons.waybar = {
    enable = mkBoolOpt false "Whether to enable waybar with experimental patches.";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      mediaplayer-waybar
      waybar
      playerctl
    ];

    # ! Moved to <flake-root>/modules/home.nix,
    # ! changed to `mkOutOfStoreSymlink` instead for easier editing
    # zenyte.home.configFile."waybar/config".source = default.configFolder + /waybar/config;
    # zenyte.home.configFile."waybar/style.css".source = default.configFolder + /waybar/style.css;

    zenyte.home.configFile = {
      "waybar/config" = "waybar/config";
      "waybar/style.css" = "waybar/style.css";
    };

    zenyte.matugen.template = {
      waybar = {
        input = "waybar-colors.css";
        output = "~/.config/waybar/colors.css";
        post_hook = "pkill -SIGUSR2 waybar";
      };
    };

    # "waybar/config".source =
    #   config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/waybar/config";
    # "waybar/style.css".source =
    #   config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/waybar/style.css";
  };
}
