{
  config,
  pkgs,
  inputs,
  default,
  ...
}: {
  users.users.${default.username} = {
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
