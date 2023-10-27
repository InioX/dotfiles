{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.services.syncthing;

  syncthingIcon = let
    url = "https://lab.uberspace.de/_images/syncthing.png";
    sha256 = "1ziv5515yc5j8yhy9jix7ais65hb9nzvc7crvc52ic9snaycy6cy";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "icon-${sha256}.${ext}";
      inherit url sha256;
    };

  syncthingDesktopItem = pkgs.makeDesktopItem {
    name = "syncthing";
    desktopName = "Syncthing";
    genericName = "File synchronization program.";
    exec = ''
      xdg-open "http://127.0.0.1:8384/"'';
    icon = syncthingIcon;
    type = "Application";
    categories = ["Network"];
    terminal = false;
  };
in {
  options.zenyte.services.syncthing = {
    enable = mkBoolOpt false "Whether to enable syncthing.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      syncthingDesktopItem
    ];

    services = {
      syncthing = {
        enable = true;
        user = default.username;
        dataDir = "/home/${default.username}/docs";
        configDir = "/home/${default.username}/docs/.config/syncthing";
        overrideDevices = true; # overrides any devices added or deleted through the WebUI
        overrideFolders = true; # overrides any folders added or deleted through the WebUI
        settings = {
          devices = {
            "Android" = {id = "DANRJA7-MMDLUM3-IJAKI7R-SDCQJR3-IC6SSMF-BWHBYXT-MFOZOM6-365ZZAJ";};
          };
          folders = {
            "docs" = {
              # Name of folder in Syncthing, also the folder ID
              path = "/home/ini/docs"; # Which folder to add to Syncthing
              devices = ["Android"]; # Which devices to share the folder with
            };
          };
        };
      };
    };
  };
}
