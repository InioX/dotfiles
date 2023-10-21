{
  config,
  pkgs,
  lib,
  zenyte-lib,
  ...
}:
with lib;
with zenyte-lib; {
  imports = [./hardware.nix ../../modules];

  # Configure the bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  # To prevent freezing when compiling
  nix.settings.cores = 1;

  # Additional packages to install
  environment.systemPackages = with pkgs; [
    discord
    gh
    tdesktop
    pavucontrol
    brave
    redshift
    chromium
    mpv
    virt-manager
    ffmpeg
    ttyd
    rare
  ];

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  users.users.ini.extraGroups = ["libvirtd"];

  zenyte.services = {
    syncthing.enable = true;
  };

  zenyte.desktop = {
    xfce.enable = true;
    # awesome.enable = true;
    hyprland = {
      enable = true;
      nvidiaPatches = false;
    };
  };

  zenyte.apps = {
    firefox = {
      enable = true;
      # Default extensions: `ublock-origin`, `plasma-integration`
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };

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
