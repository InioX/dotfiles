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

    # for now
    ./home
  ];
}