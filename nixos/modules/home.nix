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
with lib;
let
  sysConfig = config;
  cfg = sysConfig.zenyte.home;
  wallpaper = config.zenyte.system.hosts.${hostName}.wallpaper or default.wallpaper;
in
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.zenyte.home = with types; {
    file = mkOption {
      type = attrsOf (either str attrs);
      default = { };
    };
    configFile = mkOption {
      type = attrsOf (either str attrs);
      default = { };
    };
    dataFile = mkOption {
      type = attrsOf (either str attrs);
      default = { };
    };
    extraOptions = mkOption {
      type = attrs;
      default = { };
    };
    programs = mkOption {
      type = attrs;
      default = { };
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

      users.${default.username} =
        { config, ... }:
        let
          processFiles =
            baseFolder: attrs:
            mapAttrs (
              name: value:
              if isString value then
                { source = config.lib.file.mkOutOfStoreSymlink "${baseFolder}/${value}"; }
              else
                value
            ) attrs;
        in
        mkMerge [
          (mkAliasDefinitions options.zenyte.home.extraOptions)

          {
            home.file = processFiles default.configFolder sysConfig.zenyte.home.file;
            xdg.configFile = processFiles default.configFolder sysConfig.zenyte.home.configFile;
            xdg.dataFile = processFiles default.localFolder sysConfig.zenyte.home.dataFile;
          }

          {
            # Most stuff is in their own modules, this is just for weird stuff
            xdg.configFile = {

              # Electron
              "electron-flags.conf".source =
                config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/electron-flags.conf";

              # TODO: Move this into a services/ module
              # Easy effects
              "easyeffects".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/easyeffects";
              "easyeffectsrc".source =
                config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/easyeffectsrc";

              "mimeapps.list".source =
                config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/mimeapps.list";

            };

            home.file = {
              # Zsh
              ".zshrc.local".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/zsh/.zshrc";

              # Firefox
              ".mozilla/firefox/ini/chrome/" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/firefox/chrome";
                recursive = true;
              };

              ".mozilla/firefox/ini/user.js" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/firefox/user.js";
                recursive = true;
              };

              # Icon
              "pics/icon.jpg".source = pkgs.fetchurl {
                url = "https://avatars.githubusercontent.com/u/81521595?v=4";
                sha256 = "sha256-N55B0KWROQ3nOqPk908yrCRy9B4FM3/OmxuHDVgtius=";
              };

              # Desktop entries
              ".local/share/applications/org.vinegarhq.Sober.desktop" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.desktopEntryFolder}/org.vinegarhq.Sober.desktop";
              };

              ".local/share/applications/Overwatch.desktop" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.desktopEntryFolder}/Overwatch.desktop";
              };

              ".local/share/applications/Genshin.desktop" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.desktopEntryFolder}/Genshin.desktop";
              };

              # TODO: Move this into a services/ module
              # Easy effects
              ".local/share/easyeffects" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/easyeffects";
                recursive = true;
              };

              # Lutris
              ".local/share/lutris/games" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/lutris/games";
                recursive = true;
              };

              ".local/share/lutris/system.yml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/lutris/system.yml";
              };

              ".local/share/lutris/lutris.conf" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/lutris/lutris.conf";
              };

              ".local/share/lutris/runners/wine.yml" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/lutris/runners/wine.yml";
              };

              # Honkai
              ".local/share/honkers-railway-launcher/config.json" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/honkers-railway-launcher/config.json";
              };

              # Genshin
              ".local/share/anime-game-launcher/config.json" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.localFolder}/share/anime-game-launcher/config.json";
              };

              # Fish shell
              ".config/fish/config.fish" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/fish/config.fish";
              };
            };

            # Setup basic directories
            home.activation.createDevFolder = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              mkdir -p $HOME/dev/
              mkdir -p $HOME/games/
            '';

            # Clone dotfiles repo inside ~/dev/dotfiles
            home.activation.cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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

            # home.activation.symlinkDotfiles = lib.hm.dag.entryAfter ["cloneDotfiles"] ''
            #   repoDir="${default.flakePath}/dots/config/floorp/websites"
            #   targetDir="/home/${default.username}/dev/matugen-themes/"

            #   if [ -d "$repoDir" ] && [ ! -L "$targetDir" ]; then
            #     ln -s "$repoDir" "$targetDir"
            #   fi
            # '';
          }
        ];
    };
  };
}
