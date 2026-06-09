{
  config,
  pkgs,
  lib,
  inputs,
  options,
  default,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
in {
  imports = lib.zenyte.validFiles ./.;
}
