<div align="center">
    <img src="https://nixos.org/logo/nixos-logo-only-hires.png" alt="logo" width=150>
    <h1>NIXOS DOTFILES</h1>
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-22.11-5176c1?style=for-the-badge&logo=NixOS&logoColor=white" alt="NixOS - 22.11"></a>
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

## ℹ️ Description
Welcome to my dotfiles! My main goal was to have dynamic colors based on the wallpaper. However, i couldnt figure of a good way to make this work with [Home Manager](https://github.com/nix-community/home-manager) without having to rebuild everytime... The folder structure is pretty messy but i did try my best to explain it below.

### 📑 Contents
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
## :package: Installation
```shell
# First, clone the repository
git clone https://github.com/InioX/dotfiles && cd dotfiles

# Rebuild the system 
sudo nixos-rebuild switch --flake .#<hostname>

# Generate templates from the config/templates/ folder
matugen image /path/to/wallpaper/ -v
```
>**Note** Read matugen documentation [here](https://github.com/InioX/matugen-rs#usage).

## 🛠️ Usage

### Adding new hosts
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

# 📷 Showcase
>**Warning** The showcase may be outdated and look differently.

<details><summary>Expand to show</summary>
<p>

[![](https://markdown-videos.deta.dev/youtube/lBlEEiwQzYA)](https://youtu.be/lBlEEiwQzYA)

</p>
</details>

# ✨ Acknowledgment

First, special thanks to [jakehamilton](https://github.com/jakehamilton), my config is **heavily** inspired by [him](https://github.com/jakehamilton/config).

I also want to thank all the people mentioned below, they either helped me solve issues or i copied from them.

[sioodmy](https://github.com/sioodmy/dotfiles)
•
[NobbZ](https://github.com/NobbZ)
•
[gingkapls](https://github.com/gingkapls)
•
[fufexan](https://github.com/fufexan)
