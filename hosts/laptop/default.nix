{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ../../modules/desktop/xorg ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda/";
    useOSProber = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
}
