Welcome to my dotfiles! They currently feature 2 linux distributions.

The arch branch has an installer thats best used after a fresh install, though it can be used on an already set up system too.

Just simply open your terminal and run
```
bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles-hyprland/arch/install.sh)
```
The nixos branch can easily be installed by running
```
nixos-install --flake .#hostname
```

## 📑 Contents

>**Warning** The arch branch may not be up to date, as i mainly use nixos now. I will still try update it from time to time if i can.

<p float="left">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-2ea44f?style=for-the-badge&logo=Arch+Linux&logoColor=blue" alt="Arch - LATEST"></a> 
  <a href="https://"><img src="https://img.shields.io/badge/MAINTAINED-SOMETIMES-yellow?style=for-the-badge" alt="MAINTAINED - SOMETIMES"></a>
</p>

<p float="left">
   <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-22.11-2ea44f?style=for-the-badge&logo=NixOS&logoColor=blue" alt="NixOS - 22.11"></a>
   <a href="https://"><img src="https://img.shields.io/badge/MAINTAINED-YES-2ea44f?style=for-the-badge" alt="MAINTAINED - YES"></a>
 </p>

## :keyboard: Basic keybindings

> **Note** Left mouse click is mouse:272, right click is mouse:273, and Super the Windows key.

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
