{
  config,
  pkgs,
  lib,
  inputs,
  default,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.cli.zsh;
in
{
  options.zenyte.cli.zsh = with types; {
    enable = mkBoolOpt false "Whether to enable zsh.";
  };
  config = mkIf (cfg.enable || config.zenyte.system.defaultShell == pkgs.zsh) {
    programs.zsh.enable = true;

    zenyte.home.programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        switch-theme = "~/.config/hypr/scripts/switch-theme.sh";
        switch-mode = "~/.config/hypr/scripts/switch-mode.sh";
        edit-dots = "codium /home/${default.username}/dev/dotfiles/";
      };
      # enableCompletion = true;
      syntaxHighlighting = enabled;
      dotDir = "/home/${default.username}/.config/zsh2";
      autosuggestion.enable = true;
      initContent = ''
        # Source a local zshrc so it's easier to edit
        [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
      '';
    };
  };
}
