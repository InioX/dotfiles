{
  config,
  pkgs,
  zenyte-lib,
  ...
}:
with zenyte-lib; {
  imports = validFiles ./.;
}
