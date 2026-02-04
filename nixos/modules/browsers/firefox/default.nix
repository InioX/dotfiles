{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.browsers.firefox;
in {
  options.zenyte.browsers.firefox = with types; {
    enable = mkBoolOpt false "Whether to enable firefox.";
    extensions = mkOption {
      type = nullOr (listOf package);
      description = ''
        make a description later
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pywalfox-native
    ];

    # The lines below fix playerctl not being able to detect firefox as a player.
    # https://github.com/nix-community/home-manager/issues/1586#issuecomment-1140424730
    nixpkgs.config.firefox-unwrapped.enablePlasmaBrowserIntegration = true;
    # zenyte.home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";

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
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons;
            [
              ublock-origin
              plasma-integration
              darkreader
              pywalfox
            ]
            ++ cfg.extensions;
          id = 0;
          name = "ini";
          search = {
            force = true;
            default = "google";
            order = ["google" "ddg"];
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
                icon = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nw"];
              };
              "YouTube" = {
                urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
                definedAliases = ["@yt"];
              };
              "Wikipedia (en)".metaData.alias = "@wiki";
            };
          };
          settings = {
            "general.smoothScroll" = true;
            "browser.sessionstore.resume_session" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "layout.css.has-selector.enabled" = true;
            "userChrome.TabSeparatorsLowSaturation-Enabled" = true;
            "userChrome.Tabs.Option4.Enabled" = true;
            "userChrome.FilledMenuIcons-Enabled" = true;
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
