{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.zenyte.apps.vscodium;
in {
  options.zenyte.apps.vscodium = with types; {
    enable = mkEnableOption "Whether to enable vscodium.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions;
          [
            jnoortheen.nix-ide
            kamadorueda.alejandra
            naumovs.color-highlight
            usernamehw.errorlens
            arrterian.nix-env-selector
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-git-extension-pack";
              publisher = "sugatoray";
              version = "1.1.1";
              sha256 = "sha256-0b1H5mzhBkf4By67rF3xZXRkfzoNYlvoYCGG+F7Kans=";
            }
            {
              name = "vscode-conventional-commits";
              publisher = "vivaxy";
              version = "1.25.0";
              sha256 = "sha256-KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
            }
          ]
          ++ cfg.extensions;
      })
    ];
  };
}
