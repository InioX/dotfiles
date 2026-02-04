{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.desktop.awesome;
in {
  options.zenyte.desktop.awesome = {
    enable = mkBoolOpt false "Whether to enable awesomewm.";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      overlays = [
        (final: prev: {
          awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        })
      ];
    };

    zenyte.desktop.addons = {
      sddm = enabled;
      gtk = enabled;
      alacritty = enabled;
    };

    services.xserver = {
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
      libinput = {
        enable = true;
        touchpad = {naturalScrolling = true;};
      };
    };
  };
}
