{
  inputs,
  config,
  lib,
  options,
  default,
  ...
}:
with lib; let
  cfg = config.zenyte.home;
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
      useUserPackages = true;

      users.${default.username} = {config, ...}:
        mkMerge [
          (mkAliasDefinitions options.zenyte.home.extraOptions)
          {
            # * For easier editing, use `mkOutOfStoreSymlink` instead. This is only for files
            # * that I will be editing often. You cannot use `config.lib.file` in normal NixOS
            # * modules so I have to use it this way instead.
            xdg.configFile = {
              # Waybar
              "waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/waybar/config";
              "waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/waybar/style.css";

              # Rofi
              "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/rofi/config.rasi";
              "rofi/powermenu.rasi".source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/rofi/powermenu.rasi";
              "rofi/menu.rasi".source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/rofi/menu.rasi";

              # Ags
              "ags" = {
                source = config.lib.file.mkOutOfStoreSymlink "${default.configFlakeFolder}/ags";
                recursive = true;
              };
            };

            # Setup basic directories
            home.activation.createDevFolder = lib.hm.dag.entryAfter ["writeBoundary"] ''
              baseDir="/home/${default.username}/dev/"
              if [ ! -d "$baseDir" ]; then
                mkdir $baseDir
              fi
            '';

            # Clone dotfiles repo inside ~/dev/dotfiles
            home.activation.cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
              baseDir="/home/${default.username}/dev/dotfiles"
              if [ ! -d "$baseDir" ]; then
                git clone https://github.com/InioX/dotfiles $baseDir
              fi
            '';
          }
        ];
    };
  };
}
