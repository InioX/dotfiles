{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte; {
  imports = [
    ./laptop.nix
    ./hardware.nix
  ];
}
