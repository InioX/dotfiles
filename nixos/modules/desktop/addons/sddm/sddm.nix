{
  config,
  pkgs,
  lib,
  default,
  inputs,
  ...
}:
with lib;
with lib.zenyte;
let
  cfg = config.zenyte.desktop.addons.sddm;
in
{
  options.zenyte.desktop.addons.sddm = {
    enable = mkBoolOpt false "Whether to enable sddm.";
  };

  imports = [ inputs.silentSDDM.nixosModules.default ];

  config = mkIf cfg.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        autoNumlock = true;
        settings.General.Numlock = "on";
      };
      # autoLogin = {
      # enable = true;
      # user = "${default.username}";
      # };
    };

    programs.silentSDDM = {
      enable = true;
      theme = "default";
      backgrounds = {
        black-bg = pkgs.fetchurl {
          url = "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-black-solid-color-background.jpg";
          hash = "sha256-A/yv0ZhZug3pesJQjph5o7v+nPsnMbNNvvjnrcWjVvk=";
        };
      };
      settings = {
        "LoginScreen" = {
          background = "1920x1080-black-solid-color-background.jpg";
        };
        "LockScreen" = {
          background = "1920x1080-black-solid-color-background.jpg";
        };
      };
    };

  };
}
