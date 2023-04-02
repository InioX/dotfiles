{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./main.nix
    ./sound.nix
  ];
}