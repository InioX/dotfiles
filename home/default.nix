{
  config,
  pkgs,
  inputs,
  ...
} : {
  imports = [
     inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      # extraConfig = builtins.readFile ./hyprland.conf;
  };
}