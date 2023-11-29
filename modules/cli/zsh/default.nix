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
  cfg = config.zenyte.cli.zsh;
in {
  options.zenyte.cli.zsh = with types; {
    enable = mkBoolOpt false "Whether to enable zsh.";
  };
  config = mkIf (cfg.enable
    || config.zenyte.system.defaultShell
    == pkgs.zsh) {
    environment.systemPackages = with pkgs; [
      thefuck
    ];

    programs.zsh.enable = true;

    zenyte.home.programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild = ''sudo nixos-rebuild switch --flake .#laptop --log-format internal-json |& nom --json'';
        switch-theme = "~/.config/hypr/scripts/switch-theme.sh";
        switch-mode = "~/.config/hypr/scripts/switch-mode.sh";
        edit-dots = "codium /home/${default.username}/dev/dotfiles/";
      };
      enableCompletion = true;
      syntaxHighlighting = enabled;
      dotDir = ".config/zsh";
    };
  };
}
