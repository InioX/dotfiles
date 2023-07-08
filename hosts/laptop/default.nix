{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
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

  # Enable networking
  networking.networkmanager.enable = true;

  # Additional packages to install
  environment.systemPackages = with pkgs; [
    discord
    gh
    tdesktop
    pavucontrol
    brave
    vscode

    redshift

    vhs
    chromium

    mpv

    virt-manager

    rare
  ];

  zenyte.desktop = {
    xfce.enable = true;
    awesome.enable = true;
    hyprland.enable = true;
  };

  zenyte.apps = {
    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  users.users.ini.extraGroups = ["libvirtd"];

  zenyte.cli = {
    git = {
      enable = true;
      email = "justimnix@gmail.com";
      name = "InioX";
    };
    bash.enable = true;
  };
}
