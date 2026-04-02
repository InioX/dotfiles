{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.gaming;
in {
  options.zenyte.presets.gaming = {
    enable = mkBoolOpt false "Whether to enable the gaming preset.";
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    environment.systemPackages = with pkgs; [
      mangohud
      goverlay
      protonup-qt
    ];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "~/.config/hypr/scripts/performance_mode.sh";
          end = "~/.config/hypr/scripts/balanced_mode.sh";
        };
      };
    };

    zenyte.gaming = {
      steam = enabled;
      lutris = enabled;
    };

    zenyte.apps = {
      prism-launcher = enabled;
    };
  };
}
