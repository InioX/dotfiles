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
      (nerdfonts.override {fonts = ["Iosevka"];})

      terminus_font_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      material-design-icons
    ];
  };
}
