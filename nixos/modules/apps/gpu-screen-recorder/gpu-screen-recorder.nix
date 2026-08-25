{
  config,
  pkgs,
  lib,
  default,
  inputs,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.apps.gpu-screen-recorder;
in {
  options.zenyte.apps.gpu-screen-recorder = {
    enable = mkBoolOpt false "Whether to enable gpu-screen-recorder.";
  };

  config = mkIf cfg.enable {
    programs.gpu-screen-recorder = {
      enable = true;
      ui.enable = true;
    };

    zenyte.home.configFile = {
      "gpu-screen-recorder/" = "gpu-screen-recorder/";
    };
  };
}
