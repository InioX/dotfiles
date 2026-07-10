{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.niri;
in
{
  options.zenyte.desktop.niri = {
    enable = mkBoolOpt false "Whether to enable niri.";
  };

  config = mkIf cfg.enable {
    zenyte.desktop.wayland = enabled;

    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
