{
  config,
  pkgs,
  lib,
  default,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.hosts.${hostName};
in {
  options.zenyte.system.hosts.${hostName} = {
    wallpaper = mkOpt types.package default.wallpaper "The wallpaper to use for current host.";
    variant = mkOpt (lib.types.enum ["light" "dark" "amoled"]) "dark" "Colorscheme variant.";
    type = mkOpt' (lib.types.enum [
      "scheme-content"
      "scheme-expressive"
      "scheme-fidelity"
      "scheme-fruit-salad"
      "scheme-monochrome"
      "scheme-neutral"
      "scheme-rainbow"
      "scheme-tonal-spot"
    ]) "dark";
  };

  config = {
  };
}
