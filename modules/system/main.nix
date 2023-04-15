{
  config,
  pkgs,
  hostName,
  stateVersion,
  username,
  ...
}: {
  networking = { inherit hostName; };
  system = { inherit stateVersion; };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "power"
      "networkmanager"
      "nix"
    ];
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [
      "Iosevka"
      "JetBrainsMono"
    ];})
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    material-design-icons
    material-icons
    jetbrains-mono
  ];

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      htop
    ];

    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
      # To prevent firefox from creating ~/Desktop.
      XDG_DESKTOP_DIR = "$HOME";
    };
  };

  time.timeZone = "Europe/Prague";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "cs_CZ.UTF-8";
      LC_IDENTIFICATION = "cs_CZ.UTF-8";
      LC_MEASUREMENT = "cs_CZ.UTF-8";
      LC_MONETARY = "cs_CZ.UTF-8";
      LC_NAME = "cs_CZ.UTF-8";
      LC_NUMERIC = "cs_CZ.UTF-8";
      LC_PAPER = "cs_CZ.UTF-8";
      LC_TELEPHONE = "cs_CZ.UTF-8";
      LC_TIME = "cs_CZ.UTF-8";
    };
  };
}