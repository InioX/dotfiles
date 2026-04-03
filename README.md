<div align="center">
  <!-- <img src="https://github.com/InioX/dotfiles/assets/81521595/39e2e902-7eac-4186-a960-bb136d2c3448" height="300"> -->
  <!-- <br> -->
  <img src="https://github.com/InioX/dotfiles/assets/81521595/b72e5821-5209-4474-a551-c71395236587" height=60% width=60%>
</div>

<br>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/NixOS-Unstable-39393B?style=for-the-badge&logo=NixOS&logoColor=081B3A&labelColor=B6C6EE" alt="NixOS - Unstable">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-39393B?style=for-the-badge&logo=Arch+Linux&logoColor=081B3A&labelColor=B6C6EE" alt="Arch - LATEST"></a><br>
<a href="https://github.com/InioX/dotfiles/tree/android"><img src="https://img.shields.io/badge/Android-13%20Tiramisu-39393B?style=for-the-badge&logo=Android&logoColor=081B3A&labelColor=B6C6EE" alt="Android - A13 Tiramisu"></a>
<a href="https://github.com/InioX/dotfiles/tree/windows"><img src="https://img.shields.io/badge/Windows-10%2022H2-39393B?style=for-the-badge&logo=Windows&logoColor=081B3A&labelColor=B6C6EE" alt="Windows - 10 22H2"></a><br>
  <div>
    <a href="#package-installation">Installation</a>
    ·
  <a href="#-showcase">Showcase</a>
    ·
  <a href="#keyboard-basic-keybindings">Keybindings</a>
  </div>
  <div align="center">
    <sub>My personal dotfiles for NixOS, Arch, Windows, and Android.</sub>
  </div>
</div>

<div align="center">
  <img src="https://github.com/InioX/dotfiles/assets/81521595/b9bf6b7b-12ef-494a-a614-c06ac419fe63">
</div>

<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/3b3dcf24-ceee-4577-b949-a268cc1eb896"
           height="25"
           width="25">
     </sub>
     Installation
</h2>

> [!CAUTION]
> The Arch branch may not be up to date, as i mainly use nixos now. I will still try update it from time to time if i can.

The Arch branch has an installer thats best used after a fresh install, though it can be used on an already set up system too.

<table>
  <tr>
    <th><img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" alt="logo" width=15> Arch</th>
    <td><code>bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/arch/install.sh)</code></td>
  </tr>
  <tr>
    <th><img src="https://nixos.wiki/images/thumb/2/20/Home-nixos-logo.png/207px-Home-nixos-logo.png" alt="logo" width=15> NixOS</th>
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

Every branch has its own showcase located at the top of their README.

#### Changing branches

<table>
  <tr>
    <td></sup>Trough Github UI</td>
    <td></sup>Clicking on README Buttons</td>
  </tr>
  <tr>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/2231c14b-d583-4ad6-a3ee-2fa80489cb44"></td>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/70d39d7a-4640-4a43-8d4e-3c027ff396ef" width=1500></td>
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

> [!IMPORTANT]
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
