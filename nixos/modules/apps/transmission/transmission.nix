{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.transmission;
in {
  options.zenyte.apps.transmission = {
    enable = mkBoolOpt false "Whether to enable transmission;.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      transmission_4-gtk
    ];
  };
}
