{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./system
    ./apps
    ./cli
    ./home
  ];
}