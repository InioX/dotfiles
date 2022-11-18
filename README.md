# P-chy dotfiles
These dotfiles are meant to be used with hyprland, for bspwm see [this](https://github.com/InioX/dotfiles-bspwm).
## Showcase
![showcase.mp4](./images/recording.mp4)
## Installation
#### Main config:
```
git clone https://github.com/InioX/dotfiles-hyprland
cd dotfiles-hyprland/.config && cp * ~/.config
cd dotfiles-hyprland/home && cp * ~/
```
#### Dependencies:
```
paru -S rofi-lbonn-wayland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay grim slurp playerctl alsamixer bc dunst neovim waybar-hyprland-git archlinux-logout-git
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
