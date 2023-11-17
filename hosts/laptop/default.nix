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

  zenyte.system = {
    diffScript = true;
    sound = enabled;
    defaultShell = pkgs.zsh;

    networking = {
      bluetooth = true;
    };

    fonts = {
      nerd-fonts = true;
    };

    locale = {
      timeZone = "Europe/Prague";
    };
  };

  zenyte.services = {
    syncthing.enable = true;
    tlp = {
      enable = true;
      radeonDPM = true;
    };
  };

  zenyte.desktop = {
    # xfce.enable = true;
    # awesome.enable = true;
    hyprland = {
      enable = true;
      nvidiaPatches = false;
    };
  };

  zenyte.browsers = {
    brave.enable = false;
    chromium.enable = false;

    firefox = {
      enable = true;
      # Default extensions: `ublock-origin`, `plasma-integration`
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };
  };

  zenyte.apps = {
    tdesktop.enable = true;
    discord.enable = true;

    prism-launcher = {
      enable = false;
    };

    vscodium = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
      ];
    };

    gmail = {
      enable = true;
    };

    github.enable = true;
  };

  zenyte.cli = {
    git = {
      enable = true;
      email = "justimnix@gmail.com";
      name = "InioX";
    };

    bash = {
      enable = true;
    };

    eza = enabled;
  };
}
