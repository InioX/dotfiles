{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.cli.tmux;
in {
  options.zenyte.cli.tmux = {
    enable = mkBoolOpt false "Whether to enable tmux.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tmux
    ];

    zenyte.home.configFile = {
      "tmux/" = "tmux/";
    };

    zenyte.matugen.template = {
      tmux = {
        input = "tmux/tmux-colors.conf";
        output = "~/.config/tmux/generated.conf";
        post_hook = "tmux source-file ~/.config/tmux/generated.conf";
      };
    };
  };
}
