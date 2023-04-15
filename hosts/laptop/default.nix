{ 
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  imports = [ ./hardware.nix ../../modules ];

  # Configure the bootloader
  boot.loader = {
    systemd-boot.enable = true;
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
  ];

  # TODO Maybe move this into system module
  programs.adb.enable = true;
  services.gnome.gnome-keyring.enable = true;

  test = {
    desktop = {
      xfce.enable = true;
      awesome.enable = true;
      hyprland.enable = true;
    };
    apps = {
      firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
      };
    };
    cli = {
      git = {
        enable = true;
        email = "justimnix@gmail.com";
        name = "InioX";
      };
    };
  };
}
