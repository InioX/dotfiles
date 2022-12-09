#!/bin/bash

purple='\033[1;35m'
red='\033[0;31m'
green='\033[0;32m'
nocolor='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

print_header () {
  header=$1
  echo -e "${purple}==>${nocolor} ${bold}$header...${normal}"
  sleep 0.5
}

print_text () {
  echo -e "${green}==>${nocolor} ${bold}$1...${normal}"
}

main () {
  
  # Dependencies
  print_header "Installing dependencies"
  install "rofi-lbonn-wayland-only-git hyprland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay-rs \
           grim slurp playerctl alsa-utils bc neovim waybar-hyprland-git wl-clipboard-rs discord"
  check_for_error
  
  # Fonts
  print_header "Installing fonts"
  install "ttf-nerd-fonts-symbols-1000-em-mono ttf-nerd-fonts-symbols-common noto-fonts \
           noto-fonts-cjk noto-fonts-emoji noto-fonts-extra"
  check_for_error

  # Icons
  print_header "Installing icons"
  install "sardi-icons"
  check_for_error

  # AstroNvim
  install_nvim
  check_for_error

  # Vencord
  print_header "Installing Vencord"
  if confirm "\n${bold}:: This will install npm, proceed?${normal}"; then
    install_vencord
    check_for_error
  fi

  # Dunst
  install_dunst
  check_for_error

  # GTK theme
  install_gtk_theme
  check_for_error

  # Config
  if confirm "\n${bold}:: Backup the current config?${normal}"; then
    print_header "Backing up config"
    backup_config
    check_for_error
  fi
  print_header "Installing config"
  install_config
  check_for_error
    
  # Optional stuff
  if confirm "\n${bold}:: Install other optional stuff?${normal}"; then
  print_header "Installing optional stuff"
  install "firefox"
  check_for_error
  fi

  echo -e "\n${purple}==>${nocolor} ${bold}Thanks for using my dotfiles!${normal}"
  echo ':: Do not forget to run "nvim +PackerSync"'
}

install () {
  paru -S --needed --noconfirm $1
}

install_vencord () {
  print_text "Installing npm"
  install "npm"
  sudo npm i -g pnpm
  git clone https://github.com/Vendicated/Vencord
  cd Vencord
  print_text "Installing Vencord dependencies"
  pnpm install --frozen-lockfile
  print_text "Building Vencord"
  pnpm build
  print_text "Injecting Vencord"
  sudo pnpm inject
}

install_dunst () {
  print_header "Installing dunst"
  git clone -b progress-styling https://github.com/k-vernooy/dunst/
  # cd dunst && make && sudo make install && cd ..
}

install_nvim () {
  print_header "Installing AstroNvim"
  print_text "Backing up ${HOME}/.config/nvim to ${HOME}/.config/nvim.bak"
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}

install_gtk_theme () {
  print_header "Installing GTK theme"
  cd dotfiles-hyprland
  print_text "Copying files in $(pwd)/themes to /usr/share/themes"
  sudo cp -a themes/adw-gtk3-dark/ /usr/share/themes
  cd ..
}

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
  cp -a ~/.test/. ~/.test.bak/ && rm -rf ~/.test/*
  print_text "Copying files from ${HOME}/.config to ${HOME}/.config.bak"
}

install_config () {
  git clone https://github.com/InioX/dotfiles-hyprland
  cd dotfiles-hyprland
  print_text "Copying files in $(pwd)/.config folder to ${HOME}/.config/"
  cp .config/. -ar ~/.test/
  print_text "Copying files in $(pwd)/home to ${HOME}/"
  cp -ar home/ ~/.test/home/
}

check_for_error () {
  if [ $? -ne 0 ]; then
    echo -e "${bold}${red}  ->\033[0m "${header}" failed.${normal}"
    exit 1
  else
    echo -e "${bold}${green}  ->\033[0m "${header}" succeeded.${normal}"
  fi
}

main "$@"
