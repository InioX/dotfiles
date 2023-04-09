<div align="center">
    <img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" alt="logo" width=150>
</div>

<div align="center">
    <h1>ARCH DOTFILES</h1>
</div>

<div align="center">
    <p>My Arch linux dotfiles with an <a href="https://github.com/InioX/dotfiles/tree/arch/install.sh">installer</a>.</p>
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-1793d1?style=for-the-badge&logo=Arch+Linux&logoColor=white" alt="Arch - LATEST"></a> 
  <a href="https://"><img src="https://img.shields.io/badge/MAINTAINED-KINDA-1793d1?style=for-the-badge" alt="MAINTAINED - SOMETIMES"></a>
</div>

# ℹ️ Description
## 📑 Contents
```ini
📂 dotfiles/
├── 📄 install.sh
├── 📂 .config/ # Will get copied to ~/.config/
│   ├── 📂 starship.toml
│   ├── 📁 Vencord/
│   ├── 📁 dunst/
│   ├── 📁 fish/
│   ├── 📁 gtk-3.0/
│   ├── 📁 gtk-4.0/
│   ├── 📂 hypr/
│   │   ├── 📁 waybar/
│   │   └── 📁 rofi/
│   ├── 📁 kitty/
│   ├── 📁 neofetch/
│   └── 📁 nvim/
├── 📂 home/ # Will get copied to ~/
│   ├── 📄 .p10k.zsh
│   └── 📄 .zshrc
└── 📂 themes/ # Will get copied to /usr/share/themes
    └── 📄 adw-gtk3-dark
```

# 🛠️ Installation

### ⚙️ Using the installer

>**Note** Assuming you use an arch based distro

```shell
bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/arch/install.sh)
```

### 🔧 Manually

<details><summary>Expand to show</summary>
<p>

## Vencord
```shell
sudo npm i -g pnpm

git clone https://github.com/Vendicated/Vencord
cd Vencord

pnpm install --frozen-lockfile
pnpm build
sudo pnpm inject
```

## Dunst
```shell
paru -S --needed pod2man core/dbus libxinerama libxrandr libxss glib pango libnotify xdg-utils

git clone -b progress-styling https://github.com/k-vernooy/dunst/
make && sudo make install
```

## Fish
```shell
paru -S --needed fish lsd neofetch
chsh -s $(which fish)
```

## Starship
```shell
paru -S --needed starship
```

## Neovim
```shell
# First, back up the current config
sudo cp -r ~/.config/nvim ~/.config/nvim.bak && rm -rf ~/.config/nvim
sudo cp -r ~/.local/share/nvim ~/.local/share/nvim.bak && rm -rf ~/.local/share/nvim
cp -r ~/.local/state/nvim ~/.local/state/nvim.bak && rm -rf ~/.local/state/nvim
sudo cp -r ~/.cache/nvim ~/.cache/nvim.bak && rm -rf ~/.cache/nvim

git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

## Main config
```shell
# First, back up the current config
sudo cp -a ~/.config/. ~/.config.bak/ && sudo rm -rf ~/.config/*

git clone https://github.com/InioX/dotfiles-hyprland
cd dotfiles-hyprland
cp .config/. -ar ~/.config/
cp home/. -a ~/
```

## GTK Theme
```shell
sudo cp -a themes/adw-gtk3-dark/ /usr/share/themes

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

</p>
</details>

# 📷 Showcase
>**Note** The showcase may be outdated and look differently.

<details><summary>Expand to show</summary>
<p>

https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4

</p>
</details>

# ✨ Acknowledgment
Special thanks to all the people mentioned below, they either helped me solve issues or i copied from them.

[Mathisbuilder](https://github.com/MathisP75)
•
[flick0](https://github.com/flick0/dotfiles)
