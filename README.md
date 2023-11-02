<div align="center">
  <img src="https://socialify.git.ci/iniox/dotfiles/image?description=1&language=1&name=1&owner=1&theme=Dark">
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-Unstable-ffffff?style=for-the-badge&logo=NixOS&logoColor=white" alt="NixOS - Unstable">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-ffffff?style=for-the-badge&logo=Arch+Linux&logoColor=white" alt="Arch - LATEST"></a><br>
<a href="https://github.com/InioX/dotfiles/tree/android"><img src="https://img.shields.io/badge/Android-13%20Tiramisu-ffffff?style=for-the-badge&logo=Android&logoColor=white" alt="Android - A13 Tiramisu"></a>
<a href="https://github.com/InioX/dotfiles/tree/windows"><img src="https://img.shields.io/badge/Windows-10%2022H2-ffffff?style=for-the-badge&logo=Windows&logoColor=white" alt="Windows - 10 22H2"></a><br>
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
    <td><code>bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/nixos/install.sh) &lthostname&gt</code></td>
  </tr>
 <tr>
    <th><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-plain.svg" alt="logo" width=15> Android</th>
    <td><code>bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/android/setup.sh) path/to/obtainium.json </code></td>
  </tr>
  </tr>
 <tr>
    <th><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/windows8/windows8-original.svg" alt="logo" width=15> Windows</th>
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

Every branch has its own showcase located at the top of the README.

#### Changing branches

<table>
  <tr>
    <td></sup>Trough Github UI</td>
    <td></sup>Clicking on README Buttons</td>
  </tr>
  <tr>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/2231c14b-d583-4ad6-a3ee-2fa80489cb44"></td>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/a77a85eb-1a32-4850-9b96-bde65a7122c6" width=1500></td>
  </tr>
 </table>

<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/79bffd6e-f4d8-4cbc-84e4-3d8b90124188"
           height="25"
           width="25">
     </sub>
     Basic keybindings (Arch and NixOS)
</h2>

> **Note**
> 🖱️ Left mouse click is <kbd>mouse:272</kbd>, 🖱️ right click is <kbd>mouse:273</kbd>, and <kbd>⌘ Command</kbd> the ⊞ Windows key.

 <table>
  <tr>
    <th>Apps</th>
    <th>Other</th>
  </tr>
  <tr>
    <td>
      <table>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>⏎ Enter</kbd></td>
          <td>Terminal <sup>(kitty)</sup></td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>W</kbd> </td>
          <td>App Launcher <sup>(Rofi)</sup></td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>⇧ Shift</kbd> <kbd>⏎ Enter</kbd></td>
          <td>File manager <sup>(Thunar)</sup></td>
        </tr>
        <tr>
          <td><kbd>F12</kbd></td>
          <td>Take a screenshot of region</td>
        </tr>
         <tr>
          <td><kbd>⇧ Shift</kbd> <kbd>F12</kbd></td>
          <td>Take a screenshot of screen</td>
        </tr>
      </table>
    </td>
    <td>
      <table>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>⇧ Shift</kbd> <kbd>[0,9]</kbd></td>
          <td>Move window to a workspace</td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>[0,9]</kbd></td>
          <td>Change workspace</td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>Q</kbd></td>
          <td>Kill a window</td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>mouse:272</kbd</td>
          <td>Move a window</td>
        </tr>
        <tr>
          <td><kbd>⌘ Command</kbd> <kbd>mouse:273</kbd></td>
          <td>Resize a window</td>
        </tr>
      </table>
    </td>
</table> 
