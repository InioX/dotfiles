{
  config,
  pkgs,
  inputs,
  ...
}: {

  imports = [
    inputs.hyprland.nixosModules.default
  ];

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };
    programs.hyprland.enable = true;
    home.packages = with pkgs; [
      kitty
      dunst
      neofetch
      grim
      slurp
      wl-clipboard
      wofi
      alacritty
      pcmanfm
    ];
  };
}