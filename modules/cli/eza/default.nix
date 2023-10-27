{
  config,
  pkgs,
  lib,
  zenyte-lib,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.cli.eza;
in {
  options.zenyte.cli.eza = {
    enable = mkBoolOpt false "Whether to enable eza as an alias for ls.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      eza
    ];

    environment.shellAliases = {
      ls = "eza --icons";
      la = "eza --all --icons";
    };
  };
}
