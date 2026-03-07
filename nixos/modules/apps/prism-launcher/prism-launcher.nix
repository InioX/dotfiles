{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.prism-launcher;
in {
  options.zenyte.apps.prism-launcher = with types; {
    enable = mkBoolOpt false "Whether to enable Prism Launcher.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.prism-launcher.packages.${system}.default
    ];
    zenyte.home.dataFile."PrismLauncher/themes/dynamic".source = default.configFolder + /PrismLauncher/themes/dynamic;
  };
}
