{
  inputs,
  config,
  lib,
  options,
  default,
  hostName,
  impurity,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.zenyte.matugen;
  wallpaper = config.zenyte.system.hosts.${hostName}.wallpaper or default.wallpaper;
in
{
  options.zenyte.matugen = with types; {
    template = mkOption {
      description = "Flattened declaration of matugen templates across modules.";
      default = { };
      type = attrsOf (
        coercedTo str
          (input: {
            inherit input;
            output = "~/.config/${input}";
          })
          (submodule {
            options = {
              input = mkOption {
                type = str;
                description = "Input template filename.";
              };
              output = mkOption {
                type = str;
                description = "Target output destination.";
              };
              post_hook = mkOption {
                type = nullOr str;
                default = null;
              };
            };
          })
      );
    };
  };

  config = {

    zenyte.home.configFile."matugen/config.toml".text =
      let
        templates = config.zenyte.matugen.template;
        generateTomlTemplates =
          attrs:
          concatStringsSep "\n" (
            mapAttrsToList (name: conf: ''
              [templates.${name}]
              input_path = "${default.templateFolder}/${conf.input}"
              output_path = "${conf.output}"${
                if conf.post_hook != null then "\npost_hook = '${conf.post_hook}'" else ""
              }
            '') attrs
          );
      in
      ''
        [config]

        [config.wallpaper]
        command = "awww img --transition-type center {{ image }}"

        ${generateTomlTemplates templates}
      '';

    system.activationScripts.run-matugen-once = ''
      set -e

      if [ ! -f /home/${default.username}/.local/share/matugen-ran-once ]; then
        su -u ini ${pkgs.vscode}/bin/code --install-extension HyprLuna.hyprluna-theme
        su -u ini ${pkgs.matugen}/bin/matugen image ${wallpaper}

        touch /home/${default.username}/.local/share/matugen-ran-once
      fi
    '';
  };
}
