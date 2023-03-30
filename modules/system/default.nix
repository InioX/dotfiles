{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./users.nix
    ./main.nix
  ];
}