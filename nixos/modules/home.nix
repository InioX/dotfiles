{
  inputs,
  config,
  lib,
  pkgs,
  options,
  default,
  hostName,
  ...
}:
with lib; let
  sysConfig = config;
  cfg = sysConfig.zenyte.home;
  wallpaper = config.zenyte.system.hosts.${hostName}.wallpaper or default.wallpaper;
in {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.zenyte.home = with types; {
    file = mkOption {
      type = attrsOf (either str attrs);
      default = {};
    };
    configFile = mkOption {
      type = attrsOf (either str attrs);
      default = {};
    };
    dataFile = mkOption {
      type = attrsOf (either str attrs);
      default = {};
    };
    desktopEntryFile = mkOption {
      type = attrsOf (either str attrs);
      default = {};
    };
    extraOptions = mkOption {
      type = attrs;
      default = {};
    };
    programs = mkOption {
      type = attrs;
      default = {};
    };
  };

  config = {
    zenyte.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      programs = mkAliasDefinitions options.zenyte.home.programs;
      xdg.enable = true;
    };

    home-manager = {
      # useUserPackages = true;
      useGlobalPkgs = true;

      sharedModules = [
        inputs.zen-browser.homeModules.beta
      ];

      users.${default.username} = {config, ...}: let
        processFiles = baseFolder: attrs:
          mapAttrs (
            name: value:
              if isString value
              then {source = config.lib.file.mkOutOfStoreSymlink "${baseFolder}/${value}";}
              else value
          )
          attrs;

        processDesktopFiles = baseFolder: attrs:
          mapAttrs' (
            name: value:
              nameValuePair (".local/share/applications/" + name) (
                if isString value
                then {source = config.lib.file.mkOutOfStoreSymlink "${baseFolder}/${value}";}
                else value
              )
          )
          attrs;
      in
        mkMerge [
          (mkAliasDefinitions options.zenyte.home.extraOptions)

          {
            home.file = (processFiles default.configFolder sysConfig.zenyte.home.file)
              // (processDesktopFiles default.desktopEntryFolder sysConfig.zenyte.home.desktopEntryFile);
            xdg.configFile = processFiles default.configFolder sysConfig.zenyte.home.configFile;
            xdg.dataFile = processFiles default.localFolder sysConfig.zenyte.home.dataFile;
          }

          {
            # Most stuff is in their own modules, this is just for weird stuff
            xdg.configFile = {
              # Electron
              "electron-flags.conf".source =
                config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/electron-flags.conf";

              "mimeapps.list".source =
                config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/mimeapps.list";
            };

            home.file."pics/icon.jpg".source = pkgs.fetchurl {
                url = "https://avatars.githubusercontent.com/u/81521595?v=4";
                sha256 = "sha256-N55B0KWROQ3nOqPk908yrCRy9B4FM3/OmxuHDVgtius=";
            };

            # Setup basic directories
            home.activation.createDevFolder = lib.hm.dag.entryAfter ["writeBoundary"] ''
              mkdir -p $HOME/dev/
              mkdir -p $HOME/games/
              mkdir -p $HOME/games/prefixes/
              mkdir -p $HOME/docs/notes
            '';

            # Clone dotfiles repo inside ~/dev/dotfiles
            home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
              baseDir="/home/${default.username}/dev/dotfiles"
              if [ ! -d "$baseDir" ]; then
                ${pkgs.git}/bin/git clone https://github.com/InioX/dotfiles "$baseDir"
              fi

              # Clone matugen-themes
              themesDir="/home/${default.username}/dev/matugen-themes"
              if [ ! -d "$themesDir" ]; then
                ${pkgs.git}/bin/git clone https://github.com/InioX/matugen-themes "$themesDir"
              fi
            '';
          }
        ];
    };
  };
}
