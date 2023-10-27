{
  config,
  pkgs,
  lib,
  zenyte-lib,
  inputs,
  default,
  ...
}:
with lib;
with zenyte-lib; let
  cfg = config.zenyte.cli.zsh;
in {
  options.zenyte.cli.zsh = with types; {
    enable = mkBoolOpt false "Whether to set zsh as the default shell.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      thefuck
    ];

    zenyte.home.programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake .#";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "thefuck"];
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };

    users.users.${default.username} = {
      shell = pkgs.zsh;
    };
  };
}
