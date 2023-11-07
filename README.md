<div align="center">
    <img src="https://source.android.com/static/docs/setup/images/Android_symbol_green_RGB.png" alt="logo" width=200>
    <h1>ANDROID DOTFILES</h1>
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/nixos"><img src="https://img.shields.io/badge/Android-13%20Tiramisu-3DDC84?style=for-the-badge&logo=Android&logoColor=white" alt="NixOS - Unstable"></a>
   <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/InioX/dotfiles/check.yml?color=3DDC84&logo=github&style=for-the-badge"><br>
   <a href="#-------------------------installation">Installation</a>
    ·
  <a href="#-------------------------apps">Apps</a>
    ·
  <a href="#-------------------------showcase">Showcase</a>
</div>

<div align="center">
    <sub>My Android dotfiles with an <a href="https://github.com/InioX/dotfiles/tree/android/setup.sh">installer</a>.
</div>

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
    <td></sup>Home Screen</td>
    <td>Settings</td>
    <td>Obtainium</td>
  </tr>
  <tr>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/2f2aa37e-4578-46ed-876d-e4efbeeb2118"></td>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/ea25d4d7-014c-45fd-9b84-f098dbe711bf"></td>
    <td><img src="https://github.com/InioX/dotfiles/assets/81521595/26cefac3-21fc-4299-9ddf-4f90e983c52a"></td>
  </tr>
 </table>

<h2 class="description">
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/aba782c2-f45a-4ee7-b511-45971ea751e6"
           height="25"
           width="25">
     </sub>
     Description
</h2>

Welcome to my Android dotfiles, my phone is [Realme 7](https://www.realme.com/global/realme-7) and im currently using [PBRP](https://pitchblackrecovery.com/) recovery with [RisingOS 1.1](https://github.com/RisingTechOSS/android), Android 13 Tiramisu.

These dotfiles provide an install script that installs all apps trough [Obtainium](https://github.com/ImranR98/Obtainium/releases) with an `obtainium-export.json` file, and then sets the system settings using adb shell.

<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/3b3dcf24-ceee-4577-b949-a268cc1eb896"
           height="25"
           width="25">
     </sub>
     Installation
</h2>

> **Note**
> Make sure your phone is connected to your pc trough adb and has USB Debugging enabled. It is also recommended to flash [orange_state_disabler_v0.3.zip](https://t.me/narzo30cloud/67) inside recovery to get rid of the "Bootloader Unlocked" warning. <br><br><img src="https://github.com/InioX/dotfiles/assets/81521595/b3ee05f7-e8d7-4bb1-bb20-6eda21c0e51a" width=300>


```sh
bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/android/setup.sh) /path/to/obtainium.json
```
<h2>
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/4819e2f9-fe85-42ed-94d6-8ed13659e671"
           height="25"
           width="25">
     </sub>
     Apps
</h2>

- [Discord](https://play.google.com/store/apps/details?id=com.discord)  <sup>(Play Store)</sup>
- [Netflix](https://play.google.com/store/apps/details?id=com.netflix.mediaclient) <sup>(Play Store)</sup>
- [Infinity for reddit fork](https://github.com/KhoalaS/Infinity-For-Reddit) <sup>(GitHub)</sup>
- [Bakaláři OnLine](https://play.google.com/store/apps/details?id=cz.bakalari.mobile) <sup>(Play Store)</sup>
- [Better schedule](https://play.google.com/store/apps/details?id=cz.vitskalicky.lepsirozvrh) <sup>(Play Store)</sup>
- [GitHub](https://play.google.com/store/apps/details?id=com.github.android) <sup>(Play Store)</sup>
- [KurobaEx](https://f-droid.org/en/packages/com.github.k1rakishou.chan.fdroid/) <sup>(Fdroid)</sup>
- [mpv](https://f-droid.org/en/packages/is.xyz.mpv/) <sup>(Fdroid)</sup>
- [Nekogram X](https://f-droid.org/packages/nekox.messenger/) <sup>(Fdroid)</sup>
- [Obsidian](https://play.google.com/store/apps/details?id=md.obsidian) <sup>(Play Store)</sup>
- [Obtainium](https://github.com/ImranR98/Obtainium/) <sup>(GitHub)</sup>
- [Syncthing](https://play.google.com/store/apps/details?id=com.nutomic.syncthingandroid) <sup>(Play Store)</sup>

<h2 class="acknowledgements">
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/353caef1-d2bd-4a10-a709-c64b35465e65"
           height="25"
           width="25">
     </sub>
     Acknowledgements
</h2>

- [Obtainium](https://github.com/ImranR98/Obtainium) - Used for installing and updating all packages from Apkpure, GitHub and Fdroid.

I also want to thank all the people mentioned below, they either helped me solve issues or i copied from them.

[imapotatook](https://github.com/imapotatook)
•
[21zz](https://github.com/21zz)
