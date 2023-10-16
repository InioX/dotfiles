{
  config,
  pkgs,
  inputs,
  ...
}: {
  time.timeZone = "Europe/Prague";

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
}
