{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte; {
  imports = [./hardware.nix];

  # To prevent freezing when compiling
  nix.settings.cores = 1;

  # Additional packages to install
  environment.systemPackages = with pkgs; [
    gh
    pavucontrol
    mpv
    ffmpeg
  ];

  zenyte.system.hosts.laptop.wallpaper = let
    url = "https://media.discordapp.net/attachments/635625973764849684/1170373576713568286/SolarizedAngel.png";
    sha256 = "0xzj28911hyba0rfgrnbqj7sbv33rl3nikh5vm910brp4wyxb0lg";
    ext = lib.last (lib.splitString "." url);
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };

  zenyte.presets = {
    common = enabled;
    development = enabled;
    social = enabled;
  };

  zenyte.system.locale.timeZone = "Europe/Prague";
  zenyte.system.defaultShell = pkgs.zsh;

  zenyte.cli.git = {
    email = "justimnix@gmail.com";
    name = "InioX";
  };

  zenyte.services = {
    syncthing = enabled;
    tlp = {
      enable = true;
      radeonDPM = true;
    };
  };

  zenyte.desktop = {
    # xfce.enable = true;
    # awesome.enable = true;
    hyprland = enabled;
  };

  zenyte.browsers = {
    brave = disabled;
    chromium = disabled;

    firefox = {
      enable = true;
      # Default extensions: `ublock-origin`, `plasma-integration`
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };
  };
}
