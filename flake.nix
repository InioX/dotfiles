{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
let
            # system = "x86_64-linux"; #current system
            # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
            # lib = nixpkgs.lib;

            # This lets us reuse the code to "create" a system
            # Credits go to sioodmy on this one!
            # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
            addNewHost = { hostname, system ? "x86_64-linux", pkgs ? inputs.nixpkgs}:
                pkgs.lib.nixosSystem {
                    inherit system;
                    modules = [
                        { networking.hostName = hostname; }
                        (./. + "/hosts/${hostname}/configuration.nix")
                        
                        # home-manager.nixosModules.home-manager
                        # {
                        #     home-manager = {
                        #         useUserPackages = true;
                        #         useGlobalPkgs = true;
                        #         extraSpecialArgs = { inherit inputs; };
                        #         # Home manager config (configures programs like firefox, zsh, eww, etc)
                        #         users.notus = (./. + "/hosts/${hostname}/user.nix");
                        #     };
                        # }
                    ];
                    specialArgs = { inherit inputs; };
                };

        in {
            nixosConfigurations = {
                # Now, defining a new system is can be done in one line
                #                                Architecture   Hostname
                laptop = addNewHost { hostname = "laptop"; };
            };
    };
}
