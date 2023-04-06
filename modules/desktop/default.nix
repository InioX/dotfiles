{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./xfce
    ./hyprland
  ];
}