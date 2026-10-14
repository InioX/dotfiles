{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.wine;
in {
  options.zenyte.gaming.wine = {
    enable = mkBoolOpt false "Whether to enable wine.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wine
    ];

    zenyte.matugen.template = {
      wine = {
        input = "wine/wine.reg";
        output = "/tmp/wine.reg";
        post_hook = "wine regedit /tmp/wine.reg";
      };
    };
  };
}
