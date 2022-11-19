# P-chy dotfiles
These dotfiles are meant to be used with hyprland, for bspwm see [this](https://github.com/InioX/dotfiles-bspwm).
## Showcase
https://user-images.githubusercontent.com/81521595/202808805-1935cf52-c664-47e0-b9d7-b75858630a0a.mp4
## Installation
#### Dependencies:
Assuming you use an arch based distribution and your aur helper is paru:
```
paru -S rofi-lbonn-wayland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay grim slurp playerctl alsamixer bc neovim waybar-hyprland-git archlinux-logout-git
```
#### Dunst (patched version)
```
git clone https://github.com/k-vernooy/dunst ~/Documents/ 
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
git clone https://github.com/InioX/dotfiles-hyprland ~/Documents
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
