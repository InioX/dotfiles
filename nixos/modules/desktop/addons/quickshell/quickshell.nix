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

  yet-another-monochrome-icons = pkgs.stdenv.mkDerivation {
    pname = "yet-another-monochrome-icon-set";
    version = "latest";

    src = pkgs.fetchzip {
      url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set/get/main.zip";
      sha256 = "sha256-7CN5G8nYZM9qxFMRyWDIlJC0SjN7SnLQ5RUVaP1y0hc=";
    };

    installPhase = ''
      mkdir -p $out/share/icons/Yet-Another-Monochrome
      cp -r * $out/share/icons/Yet-Another-Monochrome/
    '';
  };
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
      yet-another-monochrome-icons
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
