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

    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          pkgs.winetricks
        ];
      })
    ];
  };
}
