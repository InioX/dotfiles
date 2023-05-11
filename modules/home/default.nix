{
  inputs,
  config,
  lib,
  options,
  username,
  stateVersion,
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
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.zenyte.home.configFile;
      programs = mkAliasDefinitions options.zenyte.home.programs;
    };

    home-manager = {
      useUserPackages = true;

      users.${username} =
        mkAliasDefinitions options.zenyte.home.extraOptions;
    };
  };
}
