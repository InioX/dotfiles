{
  config,
  pkgs,
  lib,
  zenyte-lib,
  inputs,
  username,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.cli.bash;
in {
  options.zenyte.cli.bash = with types; {
    enable = mkBoolOpt false "Whether to set bash as the default shell.";
  };
  config = mkIf cfg.enable {
    zenyte.home.programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild = ''sudo nixos-rebuild switch --flake .#laptop --log-format internal-json |& nom --json'';
        switch-theme = "~/.config/hypr/scripts/switch-theme.sh";
        switch-mode = "~/.config/hypr/scripts/switch-mode.sh";
      };
    };

    users.users.${username} = {
      shell = pkgs.bash;
    };
  };
}
