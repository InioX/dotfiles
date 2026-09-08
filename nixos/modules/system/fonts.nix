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

  # Until https://github.com/NixOS/nixpkgs/pull/471699/ gets merged

  google-sans-flex = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "google-sans-flex";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "he1zu";
      repo = "google-sans-flex";
      rev = "v${finalAttrs.version}";
      hash = "sha256-r0OpOnxuYnC0ttYuzuFDobfpnkSb0dlFqvFrqKXdHTM=";
    };

    installPhase = ''
      runHook preInstall

      install -Dm644 *.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';

    # meta = {
    # description = "Google Sans Flex variable font";
    # homepage = "https://fonts.google.com/specimen/Google+Sans+Flex";
    # license = lib.licenses.ofl;
    # maintainers = with lib.maintainers; [ heizu ];
    # platforms = lib.platforms.all;
    # };
  });
in {
  options.zenyte.system.fonts = {
    nerd-fonts = mkBoolOpt false "Whether to enable nerd-fonts.";
  };

  config = {
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.iosevka
        terminus_font_ttf
        material-design-icons
        material-symbols
        cozette

        google-sans-flex

        dejavu_fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
    };
  };
}
