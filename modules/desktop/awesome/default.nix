{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.zenyte.desktop.awesome;
in {
  options.zenyte.desktop.awesome = {
    enable = mkEnableOption "Whether to enable awesomewm.";
  };

  config = mkIf cfg.enable {
    zenyte.home.extraOptions = {
      xsession.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
    };
  };
}
