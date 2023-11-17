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
