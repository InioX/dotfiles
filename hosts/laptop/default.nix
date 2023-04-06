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
  ];

  test = {
    desktop = {
      xfce.enable = true;
    };
    apps = {
      firefox.enable = true;
    };
    cli = {
      git.enable = true;
    };
  };
}
