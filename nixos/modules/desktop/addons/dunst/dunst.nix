{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.addons.dunst;
in
{
  options.zenyte.desktop.addons.dunst = {
    enable = mkBoolOpt false "Whether to enable the k-vernooy dunst fork.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
      dunst
      pulseaudio
    ];

    zenyte.matugen.template = {
      dunst = {
        input = "dunstrc";
        output = "~/.config/dunst/dunstrc";
        post_hook = "pkill -SIGUSR2 dunst";
      };
    };
  };
}
