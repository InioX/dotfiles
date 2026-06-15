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
  cfg = config.zenyte.cli.fish;
in
{
  options.zenyte.cli.fish = with types; {
    enable = mkBoolOpt false "Whether to enable fish.";
  };
  config = mkIf (cfg.enable || config.zenyte.system.defaultShell == pkgs.fish) {
    programs.fish = {
      enable = true;
    };
  };
}
