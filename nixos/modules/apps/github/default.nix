{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.github;

  githubIcon = let
    url = "https://logos-world.net/wp-content/uploads/2020/11/GitHub-Symbol.png";
    sha256 = "1s5956c0ch66f445b8h2ckxbas3qaz7agi6f2ms5rnpgn4asbpkw";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "icon-${sha256}.${ext}";
      inherit url sha256;
    };

  githubDesktopItem = pkgs.makeDesktopItem {
    name = "github";
    desktopName = "GitHub";
    genericName = "Hosting service for software projects using Git.";
    exec = ''
      xdg-open "https://github.com/"'';
    icon = githubIcon;
    type = "Application";
    categories = ["Network"];
    terminal = false;
  };
in {
  options.zenyte.apps.github = {
    enable = mkBoolOpt false "Whether to enable github desktop entry and bookmark.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      githubDesktopItem
    ];

    zenyte.home.extraOptions.programs.firefox.profiles.ini.bookmarks = [
      {
        name = "GitHub";
        url = "https://github.com/";
      }
    ];
  };
}
