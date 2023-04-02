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

  outputs = { nixpkgs, home-manager, hyprland, ... } @inputs: let

    stateVersion = "22.11";
    system = "x86_64-linux";
    username = "ini";

    addNewHost = hostName: hmModules: nixModules:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        # Combine home manager modules from args with the default ones
        modules = nixModules ++ [
  
          # The main system configuration
          ./modules/system
          # The host configuration containing hardware.nix
          ( ./. + "/hosts/${hostName}/" )

          {
            # Use the hostname for networking
            networking = { inherit hostName; };

            users.users.${username} = {
                isNormalUser = true;
                extraGroups = [
                  "wheel" # Have access to sudo
                  "power" # Use power commands without sudo
                  "networkmanager" # Use network commands without sudo
                  "nix"
                ];
              };
          }

          home-manager.nixosModules.home-manager {
            home-manager = {
              users.${username} = {...}: {
                imports = [ ./home ] ++ hmModules;
                home = { inherit stateVersion; };
              };
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs system; };
            };
          }
        ];
        specialArgs = { inherit inputs stateVersion; };
      };
  in {
    nixosConfigurations = {
        # USAGE: addNewHost <hostname>  <nixModules>    <hmModules> 
        laptop = addNewHost  "laptop"        []         [ ./home/desktop/xfce ./home/desktop/hyprland ];
    };
  };
      
}
