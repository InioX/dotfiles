{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  users.users.${username} = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "power"
      "networkmanager"
      "nix"
    ];
  };
}
