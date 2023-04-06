{
  config,
  pkgs,
  lib,
  inputs,
  git-email,
  git-username,
  ...
}: with lib; let
  cfg = config.test.cli.git;
in {
  options.test.cli.git = with types; {
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
    test.home.extraOptions = {
      programs.git = {
        enable = true;
        userEmail = config.test.cli.git.email;
        userName = config.test.cli.git.name;
        aliases = {
          s = "status";
        };
      };
    };
  };
}