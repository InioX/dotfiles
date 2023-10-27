{
  description = "My nixos dotfiles flake";

  outputs = {nixpkgs, ...} @ inputs: let
    # Some functions
    zenyte-lib = import ./lib {lib = nixpkgs.lib;};

    default = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "22.11";

      # Use a config folder for compatibility with arch
      configFolder = ./dotfiles/config;
      templateFolder = ./dotfiles/templates;

      system = "x86_64-linux";
      username = "ini";
    };

    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (self: super: {zenyte = import ./lib {lib = self;};} // inputs.home-manager.lib);

    addNewHost = hostName:
      with inputs;
        nixpkgs.lib.nixosSystem {
          system = default.system;
          modules = [
            ./modules
            # The host specific configuration
            (./. + "/hosts/${hostName}/")
            {
              # Nur overlay
              nixpkgs.overlays = [
                nur.overlay
                nixpkgs-f2k.overlays.window-managers
              ];

              environment.systemPackages = [
                matugen.packages.${default.system}.default
                alejandra.defaultPackage.${default.system}
              ];
            }
            inputs.matugen.nixosModules.default
          ];
          # Pass the variables to other modules
          specialArgs = {
            lib = mkLib inputs.nixpkgs;
            inherit (lib.zenyte);
            inherit inputs hostName zenyte-lib default;
          };
        };
  in {
    nixosConfigurations = {
      # USAGE: addNewHost <hostname>
      laptop = addNewHost "laptop";
    };
  };

  inputs = {
    # Alejandra
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Matugen
    matugen = {
      url = "github:/InioX/matugen/module";
    };

    # Prism Launcher
    prism-launcher = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
    };

    # Nixpkgs
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
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

    # For awesomewm-git version
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
    };
  };
}
