{
  config,
  pkgs,
  hostName,
  stateVersion,
  default,
  inputs,
  ...
}: {
  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  # Enable networking and bluetooth

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
