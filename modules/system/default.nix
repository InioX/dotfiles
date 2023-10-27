{
  config,
  pkgs,
  lib,
  ...
}:
with lib.zenyte; {
  imports = validFiles ./.;
}
