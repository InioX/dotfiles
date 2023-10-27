{
  config,
  pkgs,
  lib,
  zenyte-lib,
  inputs,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.cli.neofetch;
in {
  options.zenyte.cli.neofetch = with types; {
    enable = mkBoolOpt false "Whether to enable neofetch.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
    ];
    zenyte.home.configFile."neofetch".source = default.configFolder + /neofetch;
  };
}
