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

    # zenyte.home.extraOptions.home.file = {
    #   ".floorp/ini/chrome/utils/chrome.manifest".text = ''
    #     content  userchromejs  content/
    #     resource userchromejs  scripts/
    #   '';

    #   # This is the actual reload script that listens for F9
    #   ".floorp/ini/chrome/reloader.uc.js".text = ''
    #     (function() {
    #       const sss = Cc["@mozilla.org/content/style-sheet-service;1"].getService(Ci.nsIStyleSheetService);

    #       function reloadCSS() {
    #         ["userContent.css", "userChrome.css"].forEach(name => {
    #           let file = Services.dirsvc.get("UChrm", Ci.nsIFile);
    #           file.append(name);
    #           if (file.exists()) {
    #             let uri = Services.io.newFileURI(file);
    #             if (sss.sheetRegistered(uri, sss.USER_SHEET)) sss.unregisterSheet(uri, sss.USER_SHEET);
    #             sss.loadAndRegisterSheet(uri, sss.USER_SHEET);
    #           }
    #         });
    #         console.log("Styles reloaded!");
    #       }

    #       window.addEventListener("keydown", e => {
    #         if (e.key === "F9") reloadCSS();
    #       });
    #     })();
    #   '';
    # };

    environment.variables.LIBVA_DRIVER_NAME = "nvidia";
    environment.variables.MOZ_DISABLE_RDD_SANDBOX = "1";

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
          Preferences = {
            # "general.config.sandbox_enabled" = false;
            # "xpinstall.signatures.required" = false;
          };
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
          bookmarks = {
            force = true;
            settings = [
              {
                name = "Stuff";
                toolbar = true;
                bookmarks = [
                  {
                    name = "P-Stream";
                    url = "https://pstream.mov/";
                  }
                  {
                    name = "YouTube";
                    url = "https://www.youtube.com/";
                  }
                  {
                    name = "Gmail";
                    url = "https://mail.google.com/mail/u/3/";
                  }
                  {
                    name = "Google Translate";
                    url = "https://translate.google.com/?sl=auto&tl=en&op=translate";
                  }
                  {
                    name = "FitGirl Repacks";
                    url = "https://fitgirl-repacks.site/";
                  }
                  {
                    name = "CS.RIN.RU";
                    url = "https://cs.rin.ru/forum/";
                  }
                  {
                    name = "FMHY";
                    url = "https://fmhy.net/video";
                  }
                  {
                    name = "YarrList";
                    url = "https://yarrlist.net/";
                  }
                  {
                    name = "Bitwarden Vault";
                    url = "https://vault.bitwarden.com/#/vault";
                  }
                  {
                    name = "GitHub";
                    url = "https://github.com/";
                  }
                  {
                    name = "Discord";
                    url = "https://discord.com/channels/1304762650651000883/1304762650651000886";
                  }
                  {
                    name = "Twitch";
                    url = "https://www.twitch.tv/";
                  }
                ];
              }
            ];
          };

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
              "youtube" = {
                urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
                definedAliases = ["@yt"];
              };
              "wikipedia".metaData.alias = "@wiki";
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
