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

  environment.systemPackages = with pkgs; [
    discord
    vscodium
    gh
    tdesktop
    pavucontrol
  ];

  programs.adb.enable = true;

  test = {
    desktop = {
      xfce.enable = true;
      hyprland.enable = true;
    };
    apps = {
      firefox.enable = true;
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
