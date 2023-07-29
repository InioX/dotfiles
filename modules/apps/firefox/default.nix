{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.zenyte.apps.firefox;
in {
  options.zenyte.apps.firefox = with types; {
    enable = mkEnableOption "Whether to enable firefox.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    zenyte.home.extraOptions.programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          CaptivePortal = false;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
        };
      };
      profiles = {
        ini = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons;
            [
              ublock-origin
            ]
            ++ cfg.extensions;
          id = 0;
          name = "ini";
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@np"];
              };
              "NixOS Wiki" = {
                urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nw"];
              };
              "YouTube" = {
                urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
                definedAliases = ["@yt"];
              };
              "Wikipedia (en)".metaData.alias = "@wiki";
              "Google".metaData.hidden = true;
            };
          };
          settings = {
            "general.smoothScroll" = true;
            "browser.startPage" = 3;
            "browser.sessionstore.resume_session" = true;
          };
          # userChrome = ''
          #  a css
          # ";
          # userContent = ''
          #  Here too
          # '';
        };
      };
    };
  };
}
