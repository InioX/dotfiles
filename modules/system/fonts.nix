{
  config,
  pkgs,
  inputs,
  ...
}: {
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Iosevka"];})
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    material-design-icons
  ];
}
