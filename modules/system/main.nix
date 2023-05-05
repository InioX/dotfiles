{
  config,
  pkgs,
  hostName,
  stateVersion,
  username,
  system,
  inputs,
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

      inputs.matugen.packages.${system}.default
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