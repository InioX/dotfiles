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
        List of packages from `https://open-vsx.org/`
      '';
    };
  };

  config = mkIf cfg.enable {
    zenyte.home.extraOptions.programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {
        window.zoomLevel = 2;
        workbench = {
          colorTheme = "Default Dark Modern";
          iconTheme = "material-icon-theme";
        };

        editor = {
          formatOnSave = true;
          formatOnPaste = true;
          minimap.enabled = false;

          guides = {
            bracketPairs = true;
            bracketPairsHorizontal = true;
          };
        };
      };
      extensions = with pkgs.vscode-extensions;
        [
          jnoortheen.nix-ide
          kamadorueda.alejandra
          naumovs.color-highlight
          usernamehw.errorlens
          arrterian.nix-env-selector
          pkief.material-icon-theme
          vscodevim.vim
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
      languageSnippets = {
        nix = {
          nixos-module = {
            body = [
              "{"
              "    config,"
              "    pkgs,"
              "    lib,"
              "    configFolder,"
              "    ..."
              "  }:"
              "  with lib; let"
              "    cfg = config.zenyte.$1.$2;"
              "  in {"
              "    options.zenyte.$1.$2 = {"
              "      enable = mkEnableOption \"Whether to enable $2.\";"
              "    };"
              ""
              "    config = mkIf cfg.enable {"
              "      $0"
              "    };"
              "}"
            ];
            description = "Insert a nixos module from my dotfiles";
            prefix = [
              "nixos-module"
            ];
          };
        };
      };
      globalSnippets = {
        fixme = {
          body = [
            "$LINE_COMMENT FIXME: $0"
          ];
          description = "Insert a FIXME remark";
          prefix = [
            "fixme"
          ];
        };
        todo = {
          body = [
            "$LINE_COMMENT TODO: $0"
          ];
          description = "Insert a TODO remark";
          prefix = [
            "todo"
          ];
        };
      };
    };

    # environment.systemPackages = with pkgs; [
    #   (vscode-with-extensions.override {
    #     vscode = vscodium;
    #     vscodeExtensions = with vscode-extensions;
    #       [
    #         jnoortheen.nix-ide
    #         kamadorueda.alejandra
    #         naumovs.color-highlight
    #         usernamehw.errorlens
    #         arrterian.nix-env-selector
    #         pkief.material-icon-theme
    #       ]
    #       ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #         {
    #           name = "vscode-git-extension-pack";
    #           publisher = "sugatoray";
    #           version = "1.1.1";
    #           sha256 = "sha256-0b1H5mzhBkf4By67rF3xZXRkfzoNYlvoYCGG+F7Kans=";
    #         }
    #         {
    #           name = "vscode-conventional-commits";
    #           publisher = "vivaxy";
    #           version = "1.25.0";
    #           sha256 = "sha256-KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
    #         }
    #       ]
    #       ++ cfg.extensions;
    #   })
    # ];
  };
}
