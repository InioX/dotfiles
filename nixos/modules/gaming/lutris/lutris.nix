{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.lutris;
in {
  options.zenyte.gaming.lutris = {
    enable = mkBoolOpt false "Whether to enable lutris.";
  };

  config = mkIf cfg.enable {
    # To link Satisfactory save files
    # ln -s /mnt/windows/Users/ini/AppData/Local/FactoryGame/Saved/SaveGames /home/ini/prefixes/satisfactory//drive_c/users/ini/AppData/Local/FactoryGame/Saved/SaveGames/
    zenyte.home.programs.lutris.enable = true;

    nixpkgs.overlays = [
      (_: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];

    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          pkgs.winetricks
        ];
      })
    ];

    zenyte.home.dataFile = {
      "lutris/games" = "share/lutris/games/";
      "lutris/system.yml" = "share/lutris/system.yml";
      "lutris/lutris.conf" = "share/lutris/lutris.conf";
      "lutris/runners/wine.yml" = "share/lutris/runners/wine.yml";
    };
  };
}
