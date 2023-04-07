{
  description = "My nix dotfiles flake";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = { nixpkgs, hyprland, ... } @inputs: 
  let
    stateVersion = "22.11";
    system = "x86_64-linux";
    username = "ini";

    addNewHost = hostName: with inputs;
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # The main system configuration
          ./modules/system
          # The host specific configuration
          ( ./. + "/hosts/${hostName}/")
        ];
        # Pass the variables to other modules
        specialArgs = { inherit inputs stateVersion username hostName; };
      };
  in {
    nixosConfigurations = {
        # USAGE: addNewHost <hostname>
        laptop = addNewHost  "laptop";
    };
  };
}
