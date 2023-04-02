{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
}
