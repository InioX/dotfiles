{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add Hyprland and protocol
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let
      # addNewHost = hostname: system:
      addNewHost = { hostname ? "nixos", system ? "x86_64-linux" }: {
        
        inherit hostname system;

        inputs.nixpkgs.lib.nixosSystem = {
          modules = [
            { networking.hostName = hostname; }
            "./hosts/${hostname}/configuration.nix" inputs
          ];

        };

          # ${hostname} = nixpkgs.lib.nixosSystem {
          # specialArgs = { inherit inputs; };
          # modules = [ ./nixos/configuration.nix ];
          # };

        # homeConfigurations = {
        #   "ini@${hostname}" = home-manager.lib.homeManagerConfiguration {
        #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #     extraSpecialArgs = { inherit inputs; };
        #     modules = [ ./home-manager/home.nix ];
        #   };
        # };
      };
    in {
      nixosConfigurations = {
        laptop = addNewHost "laptop" "x86_64-linux";
      };
    };
}
