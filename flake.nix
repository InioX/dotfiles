{
  description = "My nixos dotfiles flake";

  outputs = { nixpkgs, ... } @inputs: 
  let
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "22.11";

    # Use a config folder for compatibility with arch
    dotfilesFolder = ./config;

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
          # Nur overlay
          { nixpkgs.overlays = [ nur.overlay ]; }
        ];
        # Pass the variables to other modules
        specialArgs = {
          inherit inputs stateVersion username hostName dotfilesFolder;
        };
      };
  in {
    nixosConfigurations = {
        # USAGE: addNewHost <hostname>
        laptop = addNewHost  "laptop";
    };
  };

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

    # Nur
    nur = {
      url = "github:nix-community/nur";
    };

    # Nixpkgs wayland
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };
  };
}
