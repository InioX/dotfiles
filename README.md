<div align="center">
    <img src="https://user-images.githubusercontent.com/81521595/210214249-49b5024d-fd61-4c0b-97c8-2b74bb1ee7b8.png" alt="logo" width=400>
</div>

<div align="center">
    <h1>P-CHY DOTFILES</h1>
</div>

These dotfiles are a part of CAT-CHY OS.

## Showcase
> **⚠️ NOTE:** The showcase may be outdated and look differently.


<details><summary>Expand to show</summary>
<p>

https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4

</p>
</details>

## Contents
- [Vencord](.config/Vencord)
- [Dunst](.config/dunst)
- [Starship](.config/starship.toml)
- [Custom GTK theme]()
- [Hyprland](.config/hypr)
- [Kitty](.config/kitty)
- [Neofetch](.config/neofetch)
- [Neovim](.config/nvim)
- [Zsh (using fish instead)](home/)
- [Fish](.config/fish)

## Installation

### Using the installer

Assuming you use an arch based distro:

```shell
bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles-hyprland/master/install.sh)
```

### Manually

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

## P-CHY Config
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

## Basic keybindings

> **⚠️ NOTE:** Left mouse click is mouse:272, right click is mouse:273, and Super the Windows key.

|  Keybind | Action |
| - | - |
| <kbd>⊞ Super</kbd> <kbd>⏎ Enter</kbd> | Terminal (kitty) |
| <kbd>⊞ Super</kbd> <kbd>W</kbd> | Rofi |
| <kbd>⊞ Super</kbd> <kbd>⇧ Shift</kbd> <kbd>⏎ Enter</kbd> | File manager (pcmanfm) |
| <kbd>⊞ Super</kbd> <kbd>[0,9]</kbd> | Change workspace |
| <kbd>⊞ Super</kbd> <kbd>⇧ Shift</kbd> <kbd>[0,9]</kbd> | Move window to a workspace |
| <kbd>⊞ Super</kbd> <kbd>Q</kbd> | Kill a window |
|  <kbd>⊞ Super</kbd> <kbd>mouse:272</kbd> | Move a window |
| <kbd>⊞ Super</kbd> <kbd>mouse:273</kbd> | Resize a window |
