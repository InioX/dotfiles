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
  cfg = config.zenyte.apps.nvim;
in
{
  options.zenyte.apps.nvim = {
    enable = mkBoolOpt false "Whether to enable nvim.";
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;

    environment.systemPackages = with pkgs; [
      cmake
      unzip
      ripgrep

      tree-sitter
      luaPackages.tree-sitter-cli
      gcc
    ];

    zenyte.home.configFile = {
      "nvim/" = "nvim/";
    };

    zenyte.matugen.template = {
      nvim = {
        input = "nvim/nvim-colors.json";
        output = "~/.config/matugen/themes/nvim-colors.json";
        post_hook = "pkill -SIGUSR1 nvim";
      };
    };
  };
}
