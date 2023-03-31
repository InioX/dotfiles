{
  config,
  pkgs,
  ...
}: {
  config = {
    home = {
      packages = with pkgs; [
        firefox
        vscodium
      ];
      stateVersion = "22.11";
    };
  };
}