{
  config,
  pkgs,
  lib,
  inputs,
  dotfilesFolder,
  ...
}: with lib; let
  cfg = config.test.cli.neofetch;
in {
  options.test.cli.neofetch = with types; {
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
    test.home.configFile."neofetch".source = dotfilesFolder + /neofetch;
  };
}