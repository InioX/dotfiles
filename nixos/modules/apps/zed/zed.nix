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
  cfg = config.zenyte.apps.zed;
in
{
  options.zenyte.apps.zed = {
    enable = mkBoolOpt false "Whether to enable zed.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # zed
      nixd
      nil
      qt5.qttools
      pkgs.kdePackages.qtdeclarative
      package-version-server
      zed-editor
    ];

    zenyte.matugen.template = {
      zed = {
        input = "zed-colors.json";
        output = "~/.config/zed/themes/matugen.json";
      };
    };
  };
}
