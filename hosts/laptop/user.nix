{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "ini";
    home-directory = "home/ini";
    packages = with pkgs; [
      firefox
      vscodium
    ];
  };

  config.home.stateVersion = "22.11";
}