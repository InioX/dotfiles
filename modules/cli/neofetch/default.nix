{
  config,
  pkgs,
  lib,
  inputs,
  configFolder,
  ...
}:
with lib; let
  cfg = config.zenyte.cli.neofetch;
in {
  options.zenyte.cli.neofetch = with types; {
    enable = mkEnableOption "Whether to enable neofetch.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
    ];
    zenyte.home.configFile."neofetch".source = configFolder + /neofetch;
  };
}
