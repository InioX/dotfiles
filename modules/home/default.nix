{
  inputs,
  config,
  lib,
  username,
  stateVersion,
  ...
}: with lib; let 
  cfg = config.test.home;
in {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.test.home = with types; {
    file = mkOption {
      type = attrs;
      description = ''
        A set of files to be managed by home-manager's <option>home.file</option>.
      '';
    };
    configFile = mkOption {
      type = attrs;
      description = ''
        A set of files to be managed by home-manager's <option>xdg.configFile</option>.
      '';
    };
    extraOptions = mkOption {
      type = attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
  };

  config = {
    # FIXME error: attribute 'test' missing
    test.home.extraOptions = {
      home.stateVersion = stateVersion;
      home.file = mkAliasDefinitions options.test.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.test.home.configFile;
    };

    home-manager = {
      useUserPackages = true;

      users.${username} = mkAliasDefinitions cfg.extraOptions;
    };
  };
}