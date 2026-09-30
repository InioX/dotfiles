{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.browsers.zen;

  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "betterttv" "firefox@betterttv.net")
    (extension "p-stream-extension-v1" "be961bb7-0f52-4600-a46a-3de5e8829f68")
    # ...
  ];
in {
  options.zenyte.browsers.zen = {
    enable = mkBoolOpt false "Whether to enable zen.";
  };

  config = mkIf cfg.enable {
    zenyte.home.extraOptions.programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.ini = {
        id = 0;
        name = "ini";
        isDefault = true;

        search = {
          force = true;
          default = "google";

          engines = {
            nix-packages = {
              name = "Nix Packages";
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
            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              icon = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@nw"];
            };
            youtube = {
              name = "YouTube";
              urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
              definedAliases = ["@yt"];
            };

            github = {
              name = "GitHub Search";
              urls = [
                {
                  template = "https://github.com/search?q={searchTerms}";
                }
              ];
              definedAliases = ["@gh"];
            };
          };
        };
      };
    };

    environment.systemPackages = [
      (
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default.override
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
            )
            prefs
          );

          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs extensions;
            NoDefaultBookmarks = true;

            SearchEngines = {
              PreventInstalls = true;

              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "YouTube";
                  URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                  IconURL = "https://www.youtube.com/favicon.ico";
                  Alias = "@yt";
                }
                {
                  Name = "YouTube Music";
                  URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
                  IconURL = "https://music.youtube.com/favicon.ico";
                  Alias = "@ytm";
                }
                {
                  Name = "GitHub";
                  URLTemplate = "https://github.com/search?q={searchTerms}";
                  IconURL = "https://github.githubassets.com/favicons/favicon.png";
                  Alias = "@gh";
                }
              ];
            };

            Bookmarks = [
              {
                Title = "Cinejoy";
                URL = "https://cinejoy.to/";
                Placement = "toolbar";
              }
              {
                Title = "YouTube";
                URL = "https://www.youtube.com/";
                Placement = "toolbar";
              }
              {
                Title = "YouTube Music";
                URL = "https://music.youtube.com/";
                Placement = "toolbar";
              }
              {
                Title = "Gmail";
                URL = "https://mail.google.com/mail/u/3/";
                Placement = "toolbar";
              }
              {
                Title = "Google Translate";
                URL = "https://translate.google.com/?sl=auto&tl=en&op=translate";
                Placement = "toolbar";
              }
              {
                Title = "FitGirl Repacks";
                URL = "https://fitgirl-repacks.site/";
                Placement = "toolbar";
              }
              {
                Title = "CS.RIN.RU";
                URL = "https://cs.rin.ru/forum/";
                Placement = "toolbar";
              }
              {
                Title = "FMHY";
                URL = "https://fmhy.net/video";
                Placement = "toolbar";
              }
              {
                Title = "YarrList";
                URL = "https://yarrlist.net/";
                Placement = "toolbar";
              }
              {
                Title = "Bitwarden Vault";
                URL = "https://vault.bitwarden.com/#/vault";
                Placement = "toolbar";
              }
              {
                Title = "GitHub";
                URL = "https://github.com/";
                Placement = "toolbar";
              }
              {
                Title = "Discord";
                URL = "https://discord.com/channels/1304762650651000883/1304762650651000886";
                Placement = "toolbar";
              }
              {
                Title = "Twitch";
                URL = "https://www.twitch.tv/";
                Placement = "toolbar";
              }
              {
                Title = "Genshin Map";
                URL = "https://genshin-impact-map.appsample.com/";
                Placement = "toolbar";
              }
            ];
          };
        }
      )
    ];

    zenyte.home.configFile = {
      "zen/ini/chrome/" = "zen/chrome/";
      "zen/ini/user.js" = "zen/user.js";
    };

    zenyte.matugen.template = {
      zen = {
        input = "zen/browser-theme.css";
        output = "~/.config/zen/ini/chrome/browser-theme.css";
      };
      zen-website-colors = {
        input = "firefox-colors.css";
        output = "~/.config/zen/ini/chrome/colors.css";
      };
    };
  };
}
