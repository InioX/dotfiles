# P-chy dotfiles
These dotfiles are meant to be used with hyprland, for bspwm see [this](https://github.com/InioX/dotfiles-bspwm).
## Showcase
https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4
## Installation
#### Dependencies:
Assuming you use an arch based distribution and your aur helper is paru:
```
paru -S rofi-lbonn-wayland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay-rs grim slurp playerctl alsa-utils bc neovim waybar-hyprland-git wl-clipboard-rs
```
#### Dunst (patched version)
```
git clone -b progress-styling https://github.com/k-vernooy/dunst/ ~/Documents/dunst/
cd ~/Documents/dunst && make && sudo make install
```
#### AstroNvim
```
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync
```
#### Main config:
> **_NOTE:_** Please note that this does not back up any of your current config

```
git clone https://github.com/InioX/dotfiles-hyprland ~/Documents/dotfiles-hyprland
cd ~/Documents/dotfiles-hyprland && cp * ~/.config
cd ~/Documents/dotfiles-hyprland/home && cp * ~/
```
## Basic keybindings

> **_NOTE:_** Left mouse button is mouse:272 and right click is mouse:273

|  Shortcut |  Action |
| - | - |
| Terminal (kitty) | $main_mod, return |
| Rofi | $main_mod, W |
| File manager (pcmanfm) | SUPER_SHIFT, return |
| Change workspace | $main_mod, [0,9] |
| Move window to a workspace | SUPER_SHIFT, [0,9] |
| Kill a window | $main_mod, Q |
| Move a window| $main_mod, mouse:272 |
| Resize a window | $main_mod, mouse:273 |
