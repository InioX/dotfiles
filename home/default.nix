{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    vscodium
    discord
  ];
}