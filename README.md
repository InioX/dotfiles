<div align="center">
    <img src="https://nixos.org/logo/nixos-logo-only-hires.png" alt="logo" width=150>
    <h1>NIXOS DOTFILES</h1>
</div>

<div align="center">
    <b>My nixos dotfiles with  <a href="https://github.com/nix-community/home-manager">Home Manager</a></b>
</div>

# ℹ️ Description
Welcome to my dotfiles! I'm only using one host currenly, it's a Lenovo laptop with a Ryzen APU.

>**Warning** These dotfiles are incomplete, I'm still in the process or porting over the config files from arch.
## 📊 Progress
- [x] Hyprland (without custom scripts)
- [ ] Rofi
- [ ] Dunst
- [ ] GTK theme
- [ ] Neofetch
- [ ] Neovim
- [ ] Fish
- [ ] Starship
- [ ] Vencord
- [ ] Waybar

## 📑 Contents
```ini
📂 dotfiles/
├── ❄️ flake.nix
├── 📂 modules/ # All the modules
│   ├── 📁 apps/ # GUI apps/tools
│   ├── 📁 cli/ # CLI apps/tools
│   ├── 📁 system/ # Main system configuration
│   ├── 📁 home/ # Home Manager configuration
│   └── 📁 desktop/ # DE/WM configurations
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
Special thanks to all the people mentioned below, they either helped me solve issues or i copied from them.

[jakehamilton](https://github.com/jakehamilton)
•
[sioodmy](https://github.com/sioodmy/dotfiles)
•
[NobbZ](https://github.com/NobbZ)
