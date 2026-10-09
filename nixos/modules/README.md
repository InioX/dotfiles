> **Warning**
> Almost all modules use aliases or functions from `zenyte-lib`, do not copy the modules and expect them to work everywhere.

📂 [modules/](./modules/) - All the modules

- 📁 [apps/](./modules/apps/) - GUI apps, tools

- 📁 [cli/](./modules/cli/) - CLI apps, tools, shells

- 📁 [system/](./modules/system/) - Main system configuration

- 📁 [home/](./modules/home/) - Home Manager configuration

- 📁 [services/](./modules/services/) - Programs running as services

- 📁 [desktop/](./modules/desktop/) - DE/WM configurations

    - 📁 [addons/](./modules/desktop/addons/) - Additional apps that are required for DE/WM ([example](https://wiki.archlinux.org/title/Desktop_environment#Custom_environments))

 #### Basic module template
- `$1` - Module category *(example: apps, cli, desktop, addons)*
- `$2` - Module name *(example: firefox, vscodium, hyprland, waybar, rofi)*
 ```nix
{
    config,
    pkgs,
    lib,
    default.configFolder,
    ...
  }:
  with lib
  with lib.zenyte; let
    cfg = config.zenyte.$1.$2;
  in {
    options.zenyte.$1.$2 = {
      enable = mkBoolOpt false  "Whether to enable $2.";
    };

    config = mkIf cfg.enable {
      
    };
}
```
