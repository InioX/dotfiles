{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.nix;
in {
  options.zenyte.system.nix = {
  };

  config = {
    nix = {
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      settings = {
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org"
          "https://hyprland.cachix.org"
        ];
      };
      optimise.automatic = true;
      settings.auto-optimise-store = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
