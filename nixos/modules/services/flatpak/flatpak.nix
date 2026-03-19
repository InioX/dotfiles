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
  cfg = config.zenyte.services.flatpak;
in {
  options.zenyte.services.flatpak = {
    enable = mkBoolOpt false "Whether to enable flatpak.";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
    };

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    services.flatpak.packages = [
      "org.vinegarhq.Sober"
      "org.gtk.Gtk3theme.adw-gtk3"
      "org.gtk.Gtk3theme.adw-gtk3-dark"
      "org.upscayl.Upscayl"
    ];
  };
}
