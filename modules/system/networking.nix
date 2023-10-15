{
  config,
  pkgs,
  hostName,
  stateVersion,
  username,
  system,
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
