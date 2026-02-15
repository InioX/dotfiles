{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.fonts;
in {
  options.zenyte.system.fonts = {
    nerd-fonts = mkBoolOpt false "Whether to enable nerd-fonts.";
  };

  config = {
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
      noto-fonts
      terminus_font_ttf
      material-design-icons
      material-symbols
      cozette
    ];
  };
}
