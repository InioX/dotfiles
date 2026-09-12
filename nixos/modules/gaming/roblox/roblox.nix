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
  cfg = config.zenyte.gaming.roblox;
in {
  options.zenyte.gaming.roblox = {
    enable = mkBoolOpt false "Whether to enable roblox.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.mocktail.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    zenyte.home.configFile = {
      "mocktail/" = "mocktail/";
    };
  };
}
