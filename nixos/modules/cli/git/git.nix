{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.cli.git;
in
{
  options.zenyte.cli.git = with types; {
    enable = mkBoolOpt false "Whether to enable git.";
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
        settings = {
          user.email = config.zenyte.cli.git.email;
          user.name = config.zenyte.cli.git.name;
          alias = {
            s = "status";
            a = "add";
            c = "commit";
          };
        };
      };
      programs.gh = {
        enable = true;
        gitCredentialHelper = {
          enable = true;
        };
      };
    };
  };
}
