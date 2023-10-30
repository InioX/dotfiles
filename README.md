<div align="center">
  <img src="https://socialify.git.ci/iniox/dotfiles/image?description=1&language=1&name=1&owner=1&theme=Dark">
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-Unstable-ffffff?style=for-the-badge&logo=NixOS&logoColor=white" alt="NixOS - Unstable">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-ffffff?style=for-the-badge&logo=Arch+Linux&logoColor=white" alt="Arch - LATEST"></a><br>
<a href="https://github.com/InioX/dotfiles/tree/android"><img src="https://img.shields.io/badge/Android-13%20Tiramisu-ffffff?style=for-the-badge&logo=Android&logoColor=white" alt="Android - A13 Tiramisu"></a>
<a href="https://github.com/InioX/dotfiles/tree/android"><img src="https://img.shields.io/badge/Windows-10%2022H2-ffffff?style=for-the-badge&logo=Windows&logoColor=white" alt="Windows - 10 22H2"></a><br>
  <div>
    <a href="#package-installation">Installation</a>
    ·
  <a href="#-showcase">Showcase</a>
    ·
  <a href="#keyboard-basic-keybindings">Keybindings</a>
  </div>
  <div align="center">
    <sub>Every operating system's configuration is in it's own branch.</sub>
  </div>
</div>

<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/3b3dcf24-ceee-4577-b949-a268cc1eb896"
           height="25"
           width="25">
     </sub>
     Installation
</h2>

> **Warning**
> The Arch branch may not be up to date, as i mainly use nixos now. I will still try update it from time to time if i can.

The Arch branch has an installer thats best used after a fresh install, though it can be used on an already set up system too.

<table>
  <tr>
    <th><img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" alt="logo" width=15> Arch</th>
    <td><code>bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/arch/install.sh)</code></td>
  </tr>
  <tr>
    <th><img src="https://camo.githubusercontent.com/33a99d1ffcc8b23014fd5f6dd6bfad0f8923d44d61bdd2aad05f010ed8d14cb4/68747470733a2f2f6e69786f732e6f72672f6c6f676f2f6e69786f732d6c6f676f2d6f6e6c792d68697265732e706e67" alt="logo" width=15> NixOS</th>
    <td><code>nixos-install --flake .#hostname</code></td>
  </tr>
 <tr>
    <th><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-plain.svg" alt="logo" width=15>Android</th>
    <td>-</td>
  </tr>
  </tr>
 <tr>
    <th><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/windows8/windows8-original.svg" alt="logo" width=15>Windows</th>
    <td>-</td>
  </tr>
</table>
      
<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/718ef5e6-39d8-40fd-82c6-e7ac9f5327ff"
           height="25"
           width="25">
     </sub>
     Showcase
</h2>

<table>
  <tr>
    <td>Waybar <sup>(<img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" width=10> Arch)</sup></td>
    <td>Dunst <sup>(<img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" width=10> Arch + <img src="https://camo.githubusercontent.com/33a99d1ffcc8b23014fd5f6dd6bfad0f8923d44d61bdd2aad05f010ed8d14cb4/68747470733a2f2f6e69786f732e6f72672f6c6f676f2f6e69786f732d6c6f676f2d6f6e6c792d68697265732e706e67" width=12> NixOS)</sup></td>
    <td>Discord Theme <sup>(<img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" width=10> Arch)</sup></td>
  </tr>
  <tr>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134178054596464760/image-7.png?width=1438&height=32"></td>
    <td><img src="https://cdn.discordapp.com/attachments/1134177615964545024/1134186572493897869/image-103.png"></td>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134203686747385876/Picsart_23-07-27_21-20-16-233.jpg?width=1173&height=660"></td>
  </tr>
  <tr>
    <td>Hyprland <sup>(<img src="https://camo.githubusercontent.com/33a99d1ffcc8b23014fd5f6dd6bfad0f8923d44d61bdd2aad05f010ed8d14cb4/68747470733a2f2f6e69786f732e6f72672f6c6f676f2f6e69786f732d6c6f676f2d6f6e6c792d68697265732e706e67" width=12> NixOS)</sup></td>
    <td>Hyprland <sup>(<img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" width=10> Arch)</sup></td>
    <td>Waybar Privacy Indicators <sup>(<img src="https://camo.githubusercontent.com/33a99d1ffcc8b23014fd5f6dd6bfad0f8923d44d61bdd2aad05f010ed8d14cb4/68747470733a2f2f6e69786f732e6f72672f6c6f676f2f6e69786f732d6c6f676f2d6f6e6c792d68697265732e706e67" width=12> NixOS)</sup></td>
  </tr>
    <tr>
    <td><img src="https://user-images.githubusercontent.com/81521595/236634805-15e68f9b-44a5-4efc-b275-0eb1f6a28bd9.gif"></td>
    <td><video src="https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4"></td>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134178054835552306/image-9.png?width=1172&height=660"></td>
  </tr>
<tr>
    <td>Bspwm <sup>(Unavailable)</sup></td>
    <td>GNOME <sup>(Unavailable)</sup></td>
    <td>Hyprland - old <sup>(Unavailable)</sup></td>
  </tr>
    <tr>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134178054235770920/image.png?width=1173&height=660"></td>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134177915114885251/image-5.png?width=1172&height=660"></td>
    <td><img src="https://media.discordapp.net/attachments/1134177615964545024/1134177911885283389/4UbKh2z_1.png?width=1173&height=660"></td>
  </tr>
 </table>

<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/79bffd6e-f4d8-4cbc-84e4-3d8b90124188"
           height="25"
           width="25">
     </sub>
     Basic keybindings (Linux systems)
</h2>

> **Note**
> 🖱️ Left mouse click is `mouse:272`, 🖱️ right click is `mouse:273`, and `Super` the ⊞ Windows key.

#### Apps

| Keybind                                                  | Action                           |
| -------------------------------------------------------- | -------------------------------- |
| <kbd>⊞ Super</kbd> <kbd>⏎ Enter</kbd>                    | Terminal <sup>(kitty)</sup>      |
| <kbd>⊞ Super</kbd> <kbd>W</kbd>                          | App Launcher <sup>(Rofi)</sup>   |
| <kbd>⊞ Super</kbd> <kbd>⇧ Shift</kbd> <kbd>⏎ Enter</kbd> | File manager <sup>(Thunar)</sup> |

#### Other

| Keybind                                                | Action                     |
| ------------------------------------------------------ | -------------------------- |
| <kbd>⊞ Super</kbd> <kbd>[0,9]</kbd>                    | Change workspace           |
| <kbd>⊞ Super</kbd> <kbd>⇧ Shift</kbd> <kbd>[0,9]</kbd> | Move window to a workspace |
| <kbd>⊞ Super</kbd> <kbd>Q</kbd>                        | Kill a window              |
| <kbd>⊞ Super</kbd> <kbd>mouse:272</kbd>                | Move a window              |
| <kbd>⊞ Super</kbd> <kbd>mouse:273</kbd>                | Resize a window            |
