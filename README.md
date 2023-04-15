<div align="center">
    <img src="https://nixos.org/logo/nixos-logo-only-hires.png" alt="logo" width=150>
    <h1>NIXOS DOTFILES</h1>
</div>

<div align="center">
    <p>My nixos dotfiles with  <a href="https://github.com/nix-community/home-manager">Home Manager</a></p>
</div>

<div align="center">
   <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-22.11-5176c1?style=for-the-badge&logo=NixOS&logoColor=white" alt="NixOS - 22.11"></a>
   <a href="https://"><img src="https://img.shields.io/badge/MAINTAINED-YES-5176c1?style=for-the-badge" alt="MAINTAINED - YES"></a>
</div>

# ℹ️ Description
Welcome to my dotfiles! I'm only using one host currenly, it's a Lenovo laptop with a Ryzen APU.

>**Warning** These dotfiles are incomplete, I'm still in the process or porting over the config files from arch.
## 📊 Progress
- [x] Hyprland (without custom scripts)
- [x] Rofi
- [x] Dunst
- [x] GTK theme
- [ ] Neofetch
- [ ] Neovim
- [ ] Fish
- [ ] Starship
- [ ] Vencord
- [x] Waybar

## 📑 Contents
```ini
📂 dotfiles/
├── ❄️ flake.nix
├── 📂 config/ # The dotfiles for all programs
├── 📂 modules/ # All the modules
│   ├── 📁 apps/ # GUI apps/tools
│   ├── 📁 cli/ # CLI apps/tools
│   ├── 📁 system/ # Main system configuration
│   ├── 📁 home/ # Home Manager configuration
│   └── 📁 desktop/ # DE/WM configurations
        └── 📁 addons/ # Additional stuff for desktop
└── 📂 hosts/ # Host specific configurations
    └── 📂 <hostName>/
        ├── 📄 default.nix
        └── 📄 hardware.nix
```
# 📷 Showcase
>**Note** The showcase may be outdated and look differently.

<details><summary>Expand to show</summary>
<p>

https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4

</p>
</details>

# ✨ Acknowledgment

First, special thanks to [jakehamilton](https://github.com/jakehamilton), my config is **heavily** inspired by [his](https://github.com/jakehamilton/config).

I also want to thank all the people mentioned below, they either helped me solve issues or i copied from them.

[sioodmy](https://github.com/sioodmy/dotfiles)
•
[NobbZ](https://github.com/NobbZ)