{
  lib,
  zenyte-lib,
  ...
}:
with lib;
with zenyte-lib; let
in {
  imports = validFiles ./.;
}
