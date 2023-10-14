{
  config,
  pkgs,
  lib,
  zenyte-lib,
  inputs,
  nixpkgs,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
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
in {
  options.zenyte.desktop.addons.waybar = {
    enable = mkBoolOpt false "Whether to enable waybar with experimental patches.";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      mediaplayer-waybar
      waybar
      playerctl
    ];

    zenyte.home.configFile."waybar/config".source = configFolder + /waybar/config;
    zenyte.home.configFile."waybar/style.css".source = configFolder + /waybar/style.css;
  };
}
