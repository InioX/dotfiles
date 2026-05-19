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
  cfg = config.zenyte.apps.obsidian;
in
{
  options.zenyte.apps.obsidian = with types; {
    enable = mkBoolOpt false "Whether to enable Obsidian.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
