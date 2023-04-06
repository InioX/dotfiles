{
  description = "Your new nix config";

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

  outputs = { nixpkgs, home-manager, hyprland, self, ... } @inputs: 
  with self.lib; let
    cfg = self.config.test.home;
    stateVersion = "22.11";
    system = "x86_64-linux";
    username = "ini";

    addNewHost = hostName:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # The main system configuration
          ./modules/system
          # The host specific configuration
          ( ./. + "/hosts/${hostName}/")

          {
            # Use the hostname for networking
            networking = { inherit hostName; };

            users.users.${username} = {
                isNormalUser = true;
                extraGroups = [
                  "wheel"
                  "power"
                  "networkmanager"
                  "nix"
                ];
            };
          }
        ];
        specialArgs = { inherit inputs stateVersion username; };
      };
  in {
    nixosConfigurations = {
        # USAGE: addNewHost <hostname>
        laptop = addNewHost  "laptop";
    };
  };
}
