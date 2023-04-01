{
  config,
  pkgs,
  inputs,
  ...
} : {
  # TODO: Make this modular
  imports = [
    ./hyprland
     inputs.hyprland.homeManagerModules.default
  ];
  
  # FIXME: Starting from here:
}