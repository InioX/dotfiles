{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.vscodium;

  # Modified code from https://github.com/nix-community/home-manager/issues/3507#issuecomment-1616803481
  fix-vscode-extensions = pkgs.writeShellScriptBin "fix-vscode-extensions" ''
    # Quit VSCodium
    echo "Moving $HOME/.vscode-oss/extensions into /tmp"
    mv ~/.vscode-oss/extensions /tmp
    echo "Restarting Home Manager for $USER"
    sudo systemctl restart home-manager-$USER.service
  '';
in {
  options.zenyte.apps.vscodium = with types; {
    enable = mkBoolOpt false "Whether to enable vscodium.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        List of packages from `https://open-vsx.org/`
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fix-vscode-extensions
    ];

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
          fontFamily = "Iosevka, 'Terminus (TTF)'";
          fontSize = 16;
          lineHeight = 18;

          guides = {
            bracketPairs = true;
            bracketPairsHorizontal = true;
          };
        };

        terminal.integrated = {
          fontFamily = "'Iosevka'";
        };

        vscord.app.name = "VSCodium";
        vscord.status = {
          details.text = {
            editing = "In {workspace} - at {git_branch}";
            viewing = "In {workspace} - at {git_branch}";
          };

          state.text = {
            viewing = "{folder_and_file} - {current_line}:{current_column}";
            editing = "{folder_and_file} - {current_line}:{current_column}";
          };

          buttons.button1.active.enabled = true;
        };

        conventionalCommits.gitmoji = false;
      };
      extensions = with pkgs.vscode-extensions;
        [
          streetsidesoftware.code-spell-checker
          eamodio.gitlens
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
          {
            name = "vscord";
            publisher = "LeonardSSH";
            version = "5.1.18";
            sha256 = "sha256-pJ9loVW1uhlITXSNBsCEgW+o3ABn0cxcZxg6S7cKWHI=";
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
              "    default,"
              "    ..."
              "  }:"
              "  with lib;"
              "  with lib.zenyte; let"
              "    cfg = config.zenyte.$1.$2;"
              "  in {"
              "    options.zenyte.$1.$2 = {"
              "      enable = mkBoolOpt false  \"Whether to enable $2.\";"
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
