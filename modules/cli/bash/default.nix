{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}:
with lib; let
  cfg = config.zenyte.cli.bash;
in {
  options.zenyte.cli.bash = with types; {
    enable = mkEnableOption "Whether to set bash as the default shell.";
  };
  config = mkIf cfg.enable {
    zenyte.home.programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake .#";
        switch-theme = "~/.config/hypr/scripts/switch-theme.sh";
        switch-mode = "~/.config/hypr/scripts/switch-mode.sh";
      };
    };

    users.users.${username} = {
      shell = pkgs.bash;
    };
  };
}
