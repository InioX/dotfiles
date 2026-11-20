{
  lib,
  stdenv,
  fetchzip,
}:
stdenv.mkDerivation {
  pname = "yet-another-monochrome-icon-set";
  version = "latest";

  src = fetchzip {
    url = "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set/get/main.zip";
    sha256 = "sha256-pRXAFcMTXxQLqlsV5b+9HHgit5c6AmruyN+MY21CeWA=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/Yet-Another-Monochrome
    cp -r * $out/share/icons/Yet-Another-Monochrome/
    runHook postInstall
  '';

  meta = {
    description = "Yet Another Monochrome icon set";
    platforms = lib.platforms.all;
  };
}
