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
    gamemode = mkBoolOpt false "Whether to enable gamemode.";
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
      enable = cfg.gamemode;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };
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

    zenyte.services = {
      ananicy = enabled;
    };
  };
}
