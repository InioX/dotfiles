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
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.quickshell;
in {
  options.zenyte.desktop.addons.quickshell = {
    enable = mkBoolOpt false "Whether to enable quickshell.";
  };

  config = mkIf cfg.enable {
    services.upower.enable = true;

    environment.systemPackages = with pkgs; [
      quickshell
      # For camera privacy shutter
      v4l-utils
      # Icon theme
      zenyte.yet-another-monochrome-icon-set
      # System monitor
      inputs.hermes.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    zenyte.home.configFile = {
      "quickshell" = "quickshell";
    };

    zenyte.matugen.template = {
      quickshell = {
        input = "quickshell.json";
        output = "~/.local/state/quickshell/generated/colors.json";
      };
    };
  };
}
