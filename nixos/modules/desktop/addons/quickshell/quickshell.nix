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
      sha256 = "sha256-51V8vJXWGooc3RAu9bCzKSTYaIEX1Bi8xygikSijD78=";
    };

    installPhase = ''
      mkdir -p $out/share/icons/Yet-Another-Monochrome
      # The fetchzip unpacks into a folder with a random name like 'dirn-typo-repo-hash'
      # We move everything inside that folder to our target
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
  };
}
