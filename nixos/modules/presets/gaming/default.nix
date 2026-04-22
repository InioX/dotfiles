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
  game-performance = pkgs.writeShellScriptBin "game-performance" ''
    # Helper script to enable the performance gov with proton or others
    if ! command -v powerprofilesctl &>/dev/null; then
      echo "Error: powerprofilesctl not found" >&2
      exit 1
    fi

    # Don't fail if the CPU driver doesn't support performance power profile
    if ! powerprofilesctl list | grep -q 'performance:'; then
      exec "$@"
    fi

    # Set performance governors, as long the game is launched
    if [ -n "$GAME_PERFORMANCE_SCREENSAVER_ON" ]; then
      exec powerprofilesctl launch -p performance \
        -r "Launched with CachyOS game-performance utility" -- "$@"
    else
      exec systemd-inhibit --why "CachyOS game-performance is running" powerprofilesctl launch \
        -p performance -r "Launched with CachyOS game-performance utility" -- "$@"
    fi
  '';
in {
  options.zenyte.presets.gaming = {
    enable = mkBoolOpt false "Whether to enable the gaming preset.";
    gamemode = mkBoolOpt false "Whether to enable gamemode.";
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl."vm.max_map_count" = 2147483642;
    services.power-profiles-daemon.enable = true;

    environment.systemPackages = with pkgs; [
      game-performance

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
