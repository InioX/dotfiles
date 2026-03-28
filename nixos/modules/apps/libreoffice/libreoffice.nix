{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.libreoffice;
in {
  options.zenyte.apps.libreoffice = {
    enable = mkBoolOpt false "Whether to enable libreoffice.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.cs_CZ
    ];
  };
}
