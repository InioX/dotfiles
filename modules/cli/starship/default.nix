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
  cfg = config.zenyte.cli.starship;
in {
  options.zenyte.cli.starship = with types; {
    enable = mkBoolOpt false "Whether to enable starship.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    #   starship
    # ];
    zenyte.home.programs.starship = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    zenyte.home.configFile."starship.toml".source = "${config.programs.matugen.theme.files}/.config/starship.toml";
  };
}
