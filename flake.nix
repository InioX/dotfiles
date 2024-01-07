{
  description = "My nixos dotfiles flake";

  outputs = {nixpkgs, ...} @ inputs: let
    default = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "22.11";

      # Use a config folder for compatibility with arch
      configFolder = ./dotfiles/config;
      templateFolder = ./dotfiles/templates;
      configFlakeFolder = "/home/${default.username}/dev/dotfiles/dotfiles/config";

      system = "x86_64-linux";
      username = "ini";

      # The default wallpaper to use when `zenyte.system.hosts.<hostName>.wallpaper` is not set
      wallpaper = let
        url = "https://w.wallha.com/ws/14/CgX5kJtd.png";
        sha256 = "01157ryi41if7jy3hbx2fxc6llkaaqsl2c3ds3jbkjcf18lk1lkh";
        ext = nixpkgs.lib.last (nixpkgs.lib.splitString "." url);
      in
        builtins.fetchurl {
          name = "wallpaper-${sha256}.${ext}";
          inherit url sha256;
        };
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
              ];
            }
            inputs.matugen.nixosModules.default
          ];
          # Pass the variables to other modules
          specialArgs = {
            lib = mkLib inputs.nixpkgs;
            inherit inputs hostName default;
          };
        };
  in {
    nixosConfigurations = {
      # USAGE: addNewHost <hostname>
      laptop = addNewHost "laptop";
    };
    devShell.x86_64-linux = with import nixpkgs {system = "x86_64-linux";};
      mkShell {
        buildInputs = [
          inputs.alejandra.defaultPackage.${system}
          shellcheck
          shfmt
          nil
          (
            pkgs.writeShellScriptBin "rebuild" ''
              [ "$UID" -eq 0 ] || { echo "Error: This script must be run as root."; exit 1;}

              if [ "$1" = "fast" ]; then
                sudo nixos-rebuild switch --flake .# --fast --show-trace --log-format internal-json |& nom --json
              else
                sudo nixos-rebuild switch --flake .# --log-format internal-json |& nom --json
              fi;
            ''
          )
          (
            pkgs.writeShellScriptBin "wallfetch" ''
              if [ ! -f flake.nix ]; then echo "This script is supposed to be ran from flake root." && exit 1; fi;

              path="hosts/$(hostname)/wallpaper.nix"

              sha256=$(curl $1 | sha256sum | cut -d ' ' -f 1 )

              if [ ! -f $path ]; then
                  touch $path
              fi

              echo $sha256

              echo "{
                url = \"$1\";
                sha256 = \"$sha256\";
              }" > $path
            ''
          )
        ];
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
      url = "github:/InioX/matugen";
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
