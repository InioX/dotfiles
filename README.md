<div align="center">
    <img src="http://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png" alt="logo" width=150>
    <h1>ARCH DOTFILES</h1>
</div>

<div align="center">
  <a href="https://github.com/InioX/dotfiles/tree/arch/"><img src="https://img.shields.io/badge/Arch-LATEST-1793d1?style=for-the-badge&logo=Arch+Linux&logoColor=white" alt="Arch - LATEST"></a> 
  <a href="https://"><img src="https://img.shields.io/badge/MAINTAINED-KINDA-1793d1?style=for-the-badge" alt="MAINTAINED - SOMETIMES"></a><br>
   <a href="#------------------------------installation">Installation</a>
    ·
  <a href="#------------------------------usage">Usage</a>
    ·
  <a href="#------------------------------showcase">Showcase</a>
</div>

<div align="center">
    <sub>My Arch linux dotfiles with an <a href="https://github.com/InioX/dotfiles/tree/arch/install.sh">installer</a>
</div>

<h2 class="showcase">
     <sub>
          <img src="https://github.com/InioX/dotfiles/assets/81521595/eae80830-f035-4c03-8901-f481c858dcc5"
           height="25"
           width="25">     
     </sub>
     Showcase
</h2>

<table>
  <tr>
    <td></sup>Desktop</td>
    <td></sup>Discord</td>
  </tr>
  <tr>
    <td><video src="https://user-images.githubusercontent.com/81521595/202860841-1ebc1d34-9aee-41cc-b16e-d1028548deb1.mp4"></td>
    <td><img src="https://camo.githubusercontent.com/13e509c1c6441b14ab115c41beadf0f2724688d50cf6f0ae76d093c646f8a529/68747470733a2f2f6d656469612e646973636f72646170702e6e65742f6174746163686d656e74732f313133343137373631353936343534353032342f313133343230333638363734373338353837362f506963736172745f32332d30372d32375f32312d32302d31362d3233332e6a70673f77696474683d31313733266865696768743d363630" width=1500></td>
  </tr>
 </table>

> **Warning**
> The showcase may be outdated and look differently.

<h2 class="description">
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/aba782c2-f45a-4ee7-b511-45971ea751e6"
           height="25"
           width="25">
     </sub>
     Description
</h2>

Welcome to my dotfiles! These are my original dotfiles without dynamic color theming support, i might rework the config files to support them later. This branch is not really getting updated as i dont use Arch anymore.

#### Folder structure

- 📂 [dotfiles/](./)
  
    - 📄 [install.sh](./install.sh)
      
    - 📂 [.config/](./.config/) - Will get copied to ~/.config/
      
    - 📂 [home/](./home/) - Will get copied to ~/
      
    - 📂 [themes/](./themes/) - Will get copied to /usr/share/themes
                
<h2 class="installation">
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/37663833-5d34-492e-95ea-73528184a42b"
           height="25"
           width="25">
     </sub>
     Installation
</h2>

#### 1. Using the installer

The install script will automatically install paru if it does not find the package, and has a prompt with what dependencies to install or not.

```shell
bash <(curl -s https://raw.githubusercontent.com/InioX/dotfiles/arch/install.sh)
```

#### 2. Manually

<details><summary>Expand to show</summary>
<p>

#### Vencord
```shell
sudo npm i -g pnpm

git clone https://github.com/Vendicated/Vencord
cd Vencord

pnpm install --frozen-lockfile
pnpm build
sudo pnpm inject
```

#### Dunst
```shell
paru -S --needed pod2man core/dbus libxinerama libxrandr libxss glib pango libnotify xdg-utils

git clone -b progress-styling https://github.com/k-vernooy/dunst/
make && sudo make install
```

#### Fish
```shell
paru -S --needed fish lsd neofetch
chsh -s $(which fish)
```

#### Starship
```shell
paru -S --needed starship
```

#### Neovim
```shell
# First, back up the current config
sudo cp -r ~/.config/nvim ~/.config/nvim.bak && rm -rf ~/.config/nvim
sudo cp -r ~/.local/share/nvim ~/.local/share/nvim.bak && rm -rf ~/.local/share/nvim
cp -r ~/.local/state/nvim ~/.local/state/nvim.bak && rm -rf ~/.local/state/nvim
sudo cp -r ~/.cache/nvim ~/.cache/nvim.bak && rm -rf ~/.cache/nvim

git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

#### Main config
```shell
# First, back up the current config
sudo cp -a ~/.config/. ~/.config.bak/ && sudo rm -rf ~/.config/*

git clone https://github.com/InioX/dotfiles-hyprland
cd dotfiles-hyprland
cp .config/. -ar ~/.config/
cp home/. -a ~/
```

#### GTK Theme
```shell
sudo cp -a themes/adw-gtk3-dark/ /usr/share/themes

gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

</p>
</details>

<h2 class="acknowledgements">
     <sub>
          <img  src="https://github.com/InioX/dotfiles/assets/81521595/353caef1-d2bd-4a10-a709-c64b35465e65"
           height="25"
           width="25">
     </sub>
     Acknowledgements
</h2>

Special thanks to all the people mentioned below, they either helped me solve issues or i copied from them.

[Mathisbuilder](https://github.com/MathisP75)
•
[flick0](https://github.com/flick0/dotfiles)
