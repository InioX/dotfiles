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
    # ...
  ];
in {
  options.zenyte.browsers.zen = {
    enable = mkBoolOpt false "Whether to enable zen.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (
        pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
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

            Bookmarks = [
              {
                Title = "Z-Stream";
                URL = "https://zstream.mov/";
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

            SearchEngines = {
              Default = "ddg";
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
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
            };
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
