{
  config,
  pkgs,
  lib,
  zenyte-lib,
  configFolder,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.desktop.addons.dunst;
in {
  options.zenyte.desktop.addons.dunst = {
    enable = mkBoolOpt false "Whether to enable the k-vernooy dunst fork.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
      dunst
      pulseaudio
    ];

    # zenyte.home.configFile."dunst".source = configFolder + /dunst;

    # zenyte.home.extraOptions.services.dunst = {
    #   enable = true;
    #   # package = pkgs.dunst.overrideAttrs (oldAttrs: {
    #   #   src = pkgs.fetchFromGitHub {
    #   #     owner = "k-vernooy";
    #   #     repo = "dunst";
    #   #     rev = "c7358148edef23e883586cca37c0c7ee4b363ce8";
    #   #     sha256 = "eZoIeLERDbXIBBm/j9jgqvvul2h0YNjzedbnQGMxsiU=";
    #   #   };
    #   # });
    # };
  };
}
