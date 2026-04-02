{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.nautilus;
in {
  options.zenyte.desktop.addons.nautilus = {
    enable = mkBoolOpt false "Whether to enable nautilus.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nautilus

      # For thumbnails
      libheif
      libheif.out

      # For images
      loupe
    ];

    environment.pathsToLink = ["share/thumbnailers"];

    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
