{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.zenyte; {
  imports = [./hardware.nix];

  boot.supportedFilesystems = ["ntfs"];

  virtualisation.waydroid.enable = true;

  # To fix dual booting clock issue
  time.hardwareClockInLocalTime = true;

  # Additional packages to install
  environment.systemPackages = with pkgs; [
    gh
    pavucontrol
    mpv
    ffmpeg
  ];

  zenyte.home.extraOptions.programs.obs-studio.enable = true;

  zenyte.system.hosts.laptop = {
    variant = "dark";
    type = "scheme-neutral";
    wallpaper = let
      image = import ./wallpaper.nix;
    in
      zenyte.fetchImage image.url image.sha256;
  };

  zenyte.presets = {
    common = enabled;
    development = enabled;
    social = enabled;
    gaming = enabled;
  };

  zenyte.system.locale.timeZone = "Europe/Prague";
  zenyte.system.defaultShell = pkgs.zsh;

  zenyte.cli.git = {
    email = "justimnix@gmail.com";
    name = "InioX";
  };

  zenyte.services = {
    syncthing = disabled;
    tlp = {
      enable = false;
      # radeonDPM = true;
    };
    # auto-cpufreq = {
    #   enable = true;
    # };
    thermald.enable = true;
  };

  zenyte.desktop = {
    # xfce.enable = true;
    # awesome.enable = true;
    hyprland = enabled;
    kde = enabled;
  };

  zenyte.browsers = {
    brave = disabled;
    chromium = disabled;

    firefox = {
      enable = true;
      # Default extensions: `ublock-origin`, `plasma-integration`
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };
  };
}
