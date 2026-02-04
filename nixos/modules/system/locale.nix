{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.locale;
in {
  options.zenyte.system.locale = {
    timeZone = mkOpt types.str none "The time zone used for system. (https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)";
  };

  config = {
    time.timeZone = cfg.timeZone;

    i18n = let
      cs = "cs_CZ.UTF-8";
    in {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = cs;
        LC_IDENTIFICATION = cs;
        LC_MEASUREMENT = cs;
        LC_MONETARY = cs;
        LC_NAME = cs;
        LC_NUMERIC = cs;
        LC_PAPER = cs;
        LC_TELEPHONE = cs;
        LC_TIME = cs;
      };
    };
  };
}
