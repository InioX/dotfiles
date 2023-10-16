{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "power"
      "networkmanager"
      "nix"
    ];
  };
}
