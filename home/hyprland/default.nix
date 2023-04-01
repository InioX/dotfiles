{
  config,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    kitty
    dunst
  ];

  wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      extraConfig = builtins.readFile ./hyprland.conf;
  };
}