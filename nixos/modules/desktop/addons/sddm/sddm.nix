{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.sddm;
in {
  options.zenyte.desktop.addons.sddm = {
    enable = mkBoolOpt false "Whether to enable sddm.";
  };

  config = mkIf cfg.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
      # autoLogin = {
      # enable = true;
      # user = "${default.username}";
      # };
    };
  };
}
