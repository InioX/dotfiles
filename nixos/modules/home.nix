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
  cfg = config.zenyte.home;
  wallpaper = config.zenyte.system.hosts.${hostName}.wallpaper or default.wallpaper;
in {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.zenyte.home = with types; {
    file = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>home.file</option>.
      '';
    };
    configFile = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>xdg.configFile</option>.
      '';
    };
    dataFile = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>xdg.dataFile</option>.
      '';
    };
    extraOptions = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
    programs = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
  };

  config = {
    zenyte.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.zenyte.home.file;
      programs = mkAliasDefinitions options.zenyte.home.programs;
      xdg.enable = true;
      xdg.dataFile = mkAliasDefinitions options.zenyte.home.dataFile;
      xdg.configFile = mkAliasDefinitions options.zenyte.home.configFile;
    };

    home-manager = {
      # useUserPackages = true;
      useGlobalPkgs = true;

      users.${default.username} = {config, ...}:
        mkMerge [
          (mkAliasDefinitions options.zenyte.home.extraOptions)

          {
            # * For easier editing, use `mkOutOfStoreSymlink` instead. This is only for files
            # * that I will be editing often. (Or matugen themed files) You cannot use `config.lib.file` in normal NixOS
            # * modules so I have to use it this way instead.
            xdg.configFile = {
              # Waybar
              "waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/waybar/config";
              "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/waybar/style.css";

              # Rofi
              "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/rofi/config.rasi";
              "rofi/menu.rasi".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/rofi/menu.rasi";

              # Hyprland
              "hypr/windowrules.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/hypr/windowrules.conf";
              "hypr/scripts".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/hypr/scripts";
              "hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/hypr/hyprland.conf";
              "hypr/keybindings.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/hypr/keybindings.conf";

              # Discord
              "discord/settings.json" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/discord/settings.json";
                force = true;
              };

              # Vencord
              "Vencord".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/Vencord";

              # Neofetch
              # "neofetch".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/neofetch";

              # Alacritty
              "alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/alacritty/alacritty.toml";

              # GTK
              # "gtk-2.0".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-2.0";
              # "gtk-3.0/gtk.css" = {
              #   source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-3.0/gtk.css";
              #   force = true;
              # };
              # "gtk-4.0/gtk.css" = {
              #   source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-4.0/gtk.css";
              #   force = true;
              # };
              "gtk-4.0/settings.ini" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-4.0/settings.ini";
                force = true;
              };
              "gtk-3.0/settings.ini" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-3.0/settings.ini";
                force = true;
              };
              "gtk-3.0/bookmarks" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/gtk-3.0/bookmarks";
              };

              # Kitty
              "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/kitty/kitty.conf";

              # Vscode
              "Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/Code/User/settings.json";

              # Qt
              "qt5ct/qt5ct.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/qt5ct/qt5ct.conf";
              "qt6ct/qt6ct.conf".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/qt6ct/qt6ct.conf";
              "kdeglobals".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/kdeglobals";

              # Quickshell
              "quickshell".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/quickshell";

              # Easy effects
              "easyeffects".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/easyeffects";
              "easyeffectsrc".source = config.lib.file.mkOutOfStoreSymlink "${default.configFolder}/easyeffectsrc";
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
                recursive = true;
              };

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
            };

            # Setup basic directories
            home.activation.createDevFolder = lib.hm.dag.entryAfter ["writeBoundary"] ''
              mkdir -p $HOME/dev/
              mkdir -p $HOME/games/
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
