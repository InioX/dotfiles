{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.addons.kitty;
in {
  options.zenyte.desktop.addons.kitty = {
    enable = mkBoolOpt false "Whether to enable kitty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    zenyte.home.configFile."kitty/kitty.conf".source = default.configFolder + /kitty/kitty.conf;
    zenyte.home.configFile."kitty/colors.conf".source = "${config.programs.matugen.theme.files}/.config/kitty/colors.conf";
  };
}
