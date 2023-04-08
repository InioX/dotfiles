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
  <img src="https://nixos.org/logo/nixos-logo-only-hires.png" alt="logo" width=20>
  <a href="https://github.com/InioX/dotfiles/tree/nixos">Nixos</a>
</p>

<p float="left">
  <img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" alt="logo" width=20>
  <a href="https://github.com/InioX/dotfiles/tree/arch">Arch</a>
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
