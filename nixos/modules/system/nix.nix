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
        # automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      settings = {
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org"
          "https://hyprland.cachix.org"
          "https://cache.garnix.io"
          "https://attic.xuyh0120.win/lantian"
          "https://ezkea.cachix.org"
        ];
      };
      optimise.automatic = true;
      settings = {
        auto-optimise-store = true;
        max-jobs = 8;
        cores = 8;
        eval-cache = true;
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
