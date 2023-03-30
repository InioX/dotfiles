{
  config,
  pkgs,
  ...
}: {
  users.users.ini = {
      isNormalUser = true;
      description = "ini";
      extraGroups = [
        "wheel"
        "power"
        "networkmanager"
        "nix"
      ];
      packages = with pkgs; [
        firefox
        vscodium
      ];
  };
}