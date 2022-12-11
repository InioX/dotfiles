#!/bin/bash

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
purple='\033[1;35m'
red='\033[0;31m'
green='\033[0;32m'
nocolor='\033[0m'

# https://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
bold=$(tput bold)
normal=$(tput sgr0)

# Dependencies
dependencies="rofi-lbonn-wayland-only-git hyprland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay-rs \
              grim slurp playerctl alsa-utils bc neovim waybar-hyprland-git wl-clipboard-rs"
dunst_dependencies="paru -S pod2man core/dbus libxinerama libxrandr libxss glib pango libnotify xdg-utils"
fonts="ttf-nerd-fonts-symbols-1000-em-mono ttf-nerd-fonts-symbols-common noto-fonts \
       noto-fonts-cjk noto-fonts-emoji noto-fonts-extra"
optional_stuff="firefox github-cli"

print_header () {
  header=$1
  echo -e "${purple}==>${nocolor} ${bold}$header...${normal}"
  sleep 0.3
}

print_text () {
  echo -e "${green}==>${nocolor} ${bold}$1...${normal}"
}

install () {
  paru -S --needed --noconfirm $1
}

main () {
  
  # Dependencies
  print_header "Installing dependencies"
  install "${dependencies}" ; check_for_error
 
  # Fonts
  print_header "Installing fonts"
  install "${fonts}" ; check_for_error

  # Icons
  print_header "Installing icons"
  install "sardi-icons" ; check_for_error

  # AstroNvim
  install_nvim ; check_for_error

  # Vencord
  print_header "Installing Vencord"
  if confirm "${bold}:: This will install npm and discord, proceed?${normal}"; then
    install_vencord ; check_for_error
  fi

  print_header "Installing starship"
  if confirm "${bold}:: This will install fish shell, proceed?${normal}"; then
    install_starship ; check_for_error
  fi

  # Dunst
  install_dunst ; check_for_error
  
  # GTK theme
  install_gtk_theme ; check_for_error

  # Back up config
  if confirm "${bold}:: Backup the current config?${normal}"; then
    print_header "Backing up config" ; backup_config ; check_for_error
  fi

  # Install config
  print_header "Installing config" ; install_config ; check_for_error
    
  # Optional stuff
  if confirm "${bold}:: Install other optional stuff?${normal}"; then
    print_header "Installing optional stuff" ; install "$optional_stuff" ; check_for_error
  fi

  echo -e "\n${purple}==>${nocolor} ${bold}Thanks for using my dotfiles!${normal}"
  echo ':: Do not forget to run "nvim +PackerSync"'
  echo ':: If the GTK theme didnt apply, log out and run "gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark"'
}

install_starship () {
  print_text "Installing fish"
  install "fish"
  print_text "Changing default shell to fish"
  chsh -s $(which fish)
  print_text "Installing starship"
  install "starship"
}

install_vencord () {
  print_text "Installing npm"
  install "npm discord"
  sudo npm i -g pnpm
  
  git clone https://github.com/Vendicated/Vencord
  cd Vencord
  
  print_text "Installing Vencord dependencies"
  pnpm install --frozen-lockfile
  
  print_text "Building Vencord"
  pnpm build
  
  print_text "Injecting Vencord"
  sudo pnpm inject
  cd ..
}

install_dunst () {
  print_header "Installing dunst"
  
  print_text "Installing dependencies to build dunst"
  install $dunst_dependencies
  
  git clone -b progress-styling https://github.com/k-vernooy/dunst/
  
  print_text "Running make and make install"
  cd dunst && make && sudo make install && cd ..
}

install_nvim () {
  print_header "Installing AstroNvim"
  
  print_text "Backing up ${HOME}/.config/nvim to ${HOME}/.config/nvim.bak"
  sudo cp -r ~/.config/nvim ~/.config/nvim.bak && rm -rf ~/.config/nvim
  
  print_text "Backing up ${HOME}/.local/share/nvim to ${HOME}/.local/share/nvim.bak"
  sudo cp -r ~/.local/share/nvim ~/.local/share/nvim.bak && rm -rf ~/.local/share/nvim
  
  print_text "Backing up ${HOME}/.local/state/nvim to ${HOME}/.local/state/nvim.bak"
  cp -r ~/.local/state/nvim ~/.local/state/nvim.bak && rm -rf ~/.local/state/nvim
  
  print_text "Backing up ${HOME}/.cache/nvim to ${HOME}/.cache/nvim.bak"
  sudo cp -r ~/.cache/nvim ~/.cache/nvim.bak && rm -rf ~/.cache/nvim
  
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}

install_gtk_theme () {
  print_header "Installing GTK theme"
  
  print_text "Copying files in $(pwd)/themes to /usr/share/themes"
  sudo cp -a themes/adw-gtk3-dark/ /usr/share/themes

  print_text "Setting GTK theme"
  gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
  print_text "Setting system theme to dark"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}

# From https://github.com/LunarVim/LunarVim/blob/master/utils/installer/install.sh#L99
function confirm() {
  while true; do
    echo -e "$1 ${green}[y]${nocolor}es or ${red}[n]${nocolor}o (default: ${green}yes${nocolor}):"
    read -p ":: " -r answer
    case "$answer" in
      y | Y | yes | YES | Yes | *[[:blank:]]* | "" )
        return 0;;
      n | N | no | NO | No )
        return 1;;
      *)
        echo -e "${bold}${purple}  ->\033[0m${nocolor} Please answer ${green}[y]${nocolor}es or \
                ${red}[n]${nocolor}o.${normal}";;
    esac
  done
}

backup_config () {
  print_text "Copying files from ${HOME}/.config to ${HOME}/.config.bak"
  sudo cp -a ~/.config/. ~/.config.bak/ && sudo rm -rf ~/.config/*
}

install_config () {
  git clone https://github.com/InioX/dotfiles-hyprland
  cd dotfiles-hyprland
  
  print_text "Copying files in $(pwd)/.config folder to ${HOME}/.config/"
  cp .config/. -ar ~/.config/
  
  print_text "Copying files in $(pwd)/home to ${HOME}/"
  cp -ar home/ ~
}

check_for_error () {
  if [ $? -ne 0 ]; then
    echo -e "  ${bold}${red}->${nocolor} ${header} failed.${normal}"
    exit 1
  else
    echo -e "  ${purple}->${nocolor} ${header} succeeded."
  fi
}

main "$@"
