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

  # Enable networking and bluetooth
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Additional packages to install
  environment.systemPackages = with pkgs; [
    discord
    gh
    tdesktop
    pavucontrol
    brave
    vscode

    redshift

    chromium

    mpv

    virt-manager

    rare
  ];

  programs.go.enable = true;

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
    prism-launcher = {
      enable = true;
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
