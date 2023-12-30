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
  cfg = config.zenyte.system;
  rebuild-script = pkgs.writeShellScriptBin "rebuild" ''
    [ "$UID" -eq 0 ] || { echo "Error: This script must be run as root."; exit 1;}

    sudo nixos-rebuild switch --flake .# $@ --log-format internal-json |& nom --json
  '';
in {
  options.zenyte.system = {
    diffScript = mkBoolOpt true "Enables showing what packages changes between generations on rebuild.";
    defaultShell = mkOpt (types.enum [pkgs.bash pkgs.zsh]) pkgs.bash "Which shell to set the default as.";
  };

  config = {
    users.users.${default.username} = {
      shell = cfg.defaultShell;
    };

    system.stateVersion = default.stateVersion;

    system.activationScripts.diff = mkIf cfg.diffScript ''
      if [[ -e /run/current-system ]]; then
        ${pkgs.nix}/bin/nix store diff-closures /run/current-system "$systemConfig" | grep -w "→" | grep -w "KiB" | column --table --separator " ,:" | ${pkgs.choose}/bin/choose 0:1 -4:-1 | ${pkgs.gawk}/bin/awk '{s=$0; gsub(/\033\[[ -?]*[@-~]/,"",s); print s "\t" $0}' | sort -k5,5gr | ${pkgs.choose}/bin/choose 6:-1 | column --table
      fi
    '';

    boot.plymouth = {
      enable = true;
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
      theme = "nixos-bgrt";
    };

    programs.adb.enable = true;
    services.gvfs.enable = true;

    services.gnome.gnome-keyring.enable = true;

    environment = {
      systemPackages = with pkgs; [
        # For more information when doing nixos-rebuild
        choose
        nix-output-monitor

        vim
        wget
        git
        htop
        usbutils

        inputs.matugen.packages.${system}.default

        rebuild-script
      ];

      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # To prevent firefox from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";
        XDG_DOCUMENTS_DIR = "$HOME/docs";

        NIXOS_OZONE_WL = "1";
      };
    };

    zenyte.home.extraOptions.xdg.userDirs = {
      createDirectories = true;
      enable = true;
      documents = "$HOME/docs";
      download = "$HOME/down";
      pictures = "$HOME/pics";
      videos = "$HOME/vids";
      desktop = "$HOME";
      music = "$HOME";
      templates = "$HOME";
      publicShare = "$HOME";
    };
  };
}
