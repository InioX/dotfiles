{
  config,
  pkgs,
  inputs,
  stateVersion,
  system,
  ...
}: {
  system = {inherit stateVersion;};

  programs.adb.enable = true;
  services.gvfs.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      htop
      usbutils

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
}
