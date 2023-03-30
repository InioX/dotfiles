{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... } @inputs:
  let
    addNewHost = { hostname, system ? "x86_64-linux", pkgs ? inputs.nixpkgs}:
      pkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { networking.hostName = hostname; }
          ./modules/system/default.nix
          ( ./. + "/hosts/${hostname}/" )

          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs; }; # TODO: Add nix-colors???
              users.ini = (./. + "/hosts/${hostname}/user.nix");
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };
      in {
        nixosConfigurations = {
            laptop = addNewHost { hostname = "laptop"; };
        };
      };
}
