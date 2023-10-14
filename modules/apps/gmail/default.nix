{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.apps.gmail;

  gmailIcon = let
    url = "https://logos-world.net/wp-content/uploads/2020/11/Gmail-Logo.png";
    sha256 = "05vnjx2wv4y0w08zq7y6aqqkla5115x7i8kak8ybzl4421ixnb9l";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "icon-${sha256}.${ext}";
      inherit url sha256;
    };

  gmailDesktopItem = pkgs.makeDesktopItem {
    name = "gmail";
    desktopName = "Gmail";
    genericName = "Email from Google.";
    exec = ''
      xdg-open "https://mail.google.com/mail"'';
    icon = gmailIcon;
    type = "Application";
    categories = ["Network" "Email"];
    terminal = false;
  };
in {
  options.zenyte.apps.gmail = {
    enable = mkBoolOpt false "Whether to enable gmail as a desktop entry.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      gmailDesktopItem
    ];
  };
}
