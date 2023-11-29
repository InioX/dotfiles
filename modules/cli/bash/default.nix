{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.cli.bash;
in {
  options.zenyte.cli.bash = with types; {
    enable = mkBoolOpt false "Whether to enable bash.";
  };
  config = mkIf (cfg.enable
    || config.zenyte.system.defaultShell
    == pkgs.bash) {
    zenyte.home.programs.bash = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild = ''sudo nixos-rebuild switch --flake .#laptop --log-format internal-json |& nom --json'';
        switch-theme = "~/.config/hypr/scripts/switch-theme.sh";
        switch-mode = "~/.config/hypr/scripts/switch-mode.sh";
        edit-dots = "codium /home/${default.username}/dev/dotfiles/";
      };
    };
  };
}
