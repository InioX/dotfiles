{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.users;
in {
  options.zenyte.system.users = {
  };

  config = {
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
  };
}
