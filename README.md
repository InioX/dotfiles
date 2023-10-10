<div align="center">
    <img src="https://nixos.org/logo/nixos-logo-only-hires.png" alt="logo" width=150>
    <h1>NIXOS DOTFILES</h1>
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-23.05-5176c1?style=for-the-badge&logo=NixOS&logoColor=white" alt="NixOS - 23.05"></a>
   <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/InioX/dotfiles/check.yml?color=5176c1&logo=github&style=for-the-badge"><br>
   <a href="#package-installation">Installation</a>
    ·
  <a href="#%EF%B8%8F-usage">Usage</a>
    ·
  <a href="#-showcase">Showcase</a>
</div>

<div align="center">
    <sub>My nixos dotfiles with  <a href="https://github.com/nix-community/home-manager">Home Manager</a>
</div>

## 📷 Showcase
<details><summary>Changes</summary>
<h2>
    Waybar <sup><a href="https://github.com/InioX/dotfiles/commit/fe65d8b40df74ed81d642d476181c75a6ae46f19">(fe65d8b) - 29/08/2023</a></sup>
    <br><br>
    <img src="https://media.discordapp.net/attachments/1134177615964545024/1146100066860404736/image.png?width=60&height=684">
</h2>

<h2>
    Rofi <sup><a href="https://github.com/InioX/dotfiles/commit/3b4f381ae02b036f2960e76d4507e7c64c05b475">(3b4f381) - 29/08/2023</a></sup>
    <br><br>
    <img src="https://cdn.discordapp.com/attachments/1134177615964545024/1146100166668071054/image.png">
</h2>
</details>

> **Warning**
> The showcase may be outdated and look differently.

<details><summary>Click to show</summary>
<p>

<img src="https://user-images.githubusercontent.com/81521595/236634805-15e68f9b-44a5-4efc-b275-0eb1f6a28bd9.gif" width="320" height="180"/>

[![video showcase](https://markdown-videos.deta.dev/youtube/lBlEEiwQzYA)](https://youtu.be/lBlEEiwQzYA)

</p>
</details>

## ℹ️ Description
Welcome to my dotfiles! My main goal was to have dynamic colors based on the wallpaper. However, i couldnt figure of a good way to make this work with [Home Manager](https://github.com/nix-community/home-manager) without having to rebuild everytime... The folder structure is pretty messy but i did try my best to explain it below.

<details><summary>Click to show</summary>
    
```ini
📂 dotfiles/
├── ❄️ flake.nix
├── 📂 dotfiles/ # All dotfiles for programs, in a folder for compability with arch
│    ├── 📁 config/ # My dotfiles except for those generated from templates
│    ├── 📁 templates/ # Additional stuff generated with matugen
│    └── 📁 wallpapers/ # All my wallpapers are stored here
├── 📂 modules/ # All the modules
│   ├── 📁 apps/ # GUI apps/tools
│   ├── 📁 cli/ # CLI apps/tools
│   ├── 📁 system/ # Main system configuration
│   ├── 📁 home/ # Home Manager configuration
│   └── 📁 desktop/ # DE/WM configurations
│        └── 📁 addons/ # Additional stuff for desktop
└── 📂 hosts/ # Host specific configurations
    └── 📂 <hostName>/
        ├── 📄 default.nix
        └── 📄 hardware.nix
```

</details>

## :package: Installation
First, clone the repository
```shell
git clone https://github.com/InioX/dotfiles
cd dotfiles
```

Put this file in hosts/<hostname>/hardware.nix
```shell
nixos-generate-config
```

Install the system 
```shell
sudo nixos-install --flake .#<hostname>
```

Generate templates from the dotfiles/templates/ folder
```shell
switch-theme /path/to/light/wallpaper /path/to/dark/wallpaper
```

To switch between light/dark modes
```shell
switch-mode
```

Or if you want to, ignore the two steps above and run matugen directly
```shell
matugen image /path/to/wallpaper/ -v <other-options>
```

> **Note**
> Read matugen documentation [here](https://github.com/InioX/matugen#usage).

## 🛠️ Usage

### Adding new hosts
<details><summary>Click to show</summary>
    
The name of the folder should be your hostname and it should be located in `hosts/<hostName>`. Every host folder should contain a `default.nix` file and `hardware.nix`.

To get a `hardware.nix` file:
```sh
nixos-generate-config
```

To get a `default.nix` file, you can modify this template:

```nix

# default.nix
{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./hardware.nix ../../modules];

  # Configure the bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Anything else here... You can also use `zenyte.<category>` to configure stuff.
}
```

Finally, add the folder name as the hostname into `flake.nix`

```nix
# flake.nix
{
  outputs = { nixpkgs, ... } @inputs:
  let
  # ...
in {
    nixosConfigurations = {
        # USAGE: addNewHost <hostname>
        laptop = addNewHost  "laptop";
    };
  };
  inputs = {
    # ...
  };
}
```

</details>

## ⚠️ Issues

### Broken bootloader after dual booting Windows

<details><summary>Click to show</summary>

1. Boot the live usb and mount partitions
    > **Warning**
    > The partition and drive names will not be the same for everyone

    ```sh
    sudo mount /dev/nvme0n1p2 /mnt
    sudo mount /dev/nvme0n1p1 /mnt/boot
    ```

2. Move `/mnt/boot/EFI/Microsoft` to `/mnt/boot/EFI/Microsoft.bak`

    ```sh
    sudo mv /mnt/boot/EFI/Microsoft /mnt/boot/EFI/Microsoft.bak
    ```

3. Reboot

4. Everything should work now, except you can't choose Windows from the Bootloader

5. Repeat step `1.`

6. Move `/mnt/boot/EFI/Microsoft.bak` back to the original position of `/mnt/boot/EFI/Microsoft`

   ```sh
    sudo mv /mnt/boot/EFI/Microsoft /mnt/boot/EFI/Microsoft.bak
    ```

7. Reboot

8. Everything should work again as intended

</details>

## ✨ Acknowledgment

First, special thanks to [jakehamilton](https://github.com/jakehamilton), my config is **heavily** inspired by [him](https://github.com/jakehamilton/config).

I also want to thank all the people mentioned below, they either helped me solve issues or i copied from them.

[sioodmy](https://github.com/sioodmy/dotfiles)
•
[NobbZ](https://github.com/NobbZ)
•
[gingkapls](https://github.com/gingkapls)
