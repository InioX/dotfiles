{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: with lib; let
  cfg = config.zenyte.cli.git;
in {
  options.zenyte.cli.git = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        Whether to enable git or not.
      '';
    };
    email = mkOption {
      type = str;
      default = "";
      description = ''
        The email adress that will be used.
      '';
    };
    name = mkOption {
      type = str;
      default = "";
      description = ''
        The name that will be used.
      '';
    };
  };

  config = mkIf cfg.enable {
    zenyte.home.extraOptions = {
      programs.git = {
        enable = true;
        userEmail = config.zenyte.cli.git.email;
        userName = config.zenyte.cli.git.name;
        aliases = {
          s = "status";
          a = "add";
          c = "commit";
        };
      };
    };
  };
}