{
  config,
  pkgs,
  lib,
  inputs,
  configFolder,
  ...
}:
with lib; let
  cfg = config.zenyte.cli.starship;
in {
  options.zenyte.cli.starship = with types; {
    enable = mkEnableOption "Whether to enable starship.";
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
  };
}
