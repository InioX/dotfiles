{
  config,
  pkgs,
  lib,
  inputs,
  dotfilesFolder,
  ...
}: with lib; let
  cfg = config.zenyte.cli.neofetch;
in {
  options.zenyte.cli.neofetch = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
        Whether to enable neofetch or not.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neofetch
    ];
    zenyte.home.configFile."neofetch".source = dotfilesFolder + /neofetch;
  };
}