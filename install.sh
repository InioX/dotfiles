#!/bin/bash

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
purple='\033[1;35m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;94m'
grey='\033[90m'
normal='\033[0m'
bold='\033[1m'

# Dependencies
dependencies="rofi-lbonn-wayland-only-git hyprland kitty pcmanfm-gtk3 swaybg lxsession wl-gammarelay-rs \
              grim slurp playerctl alsa-utils bc neovim waybar-hyprland-git wl-clipboard-rs"
dunst_dependencies="pod2man core/dbus libxinerama libxrandr libxss glib pango libnotify xdg-utils"
starship_dependencies="fish lsd neofetch"
paru_dependencies="cargo git"
fonts="ttf-nerd-fonts-symbols noto-fonts \
       noto-fonts-cjk noto-fonts-emoji noto-fonts-extra"
icons="sardi-icons"
optional_stuff="firefox github-cli pavucontrol"

print_header() {
  header=$1
  echo -e "${purple}==>${normal} ${bold}$header...${normal}"
  sleep 0.3
}

print_text() {
  echo -e "${blue}==>${normal} ${bold}$1...${normal}"
}

install() {
  paru -S --needed --noconfirm $1
}

# From https://github.com/LunarVim/LunarVim/blob/master/utils/installer/install.sh#L99
confirm() {
  while true; do
    echo -e "$1 ${green}[y]${normal}es or ${red}[n]${normal}o (default: ${green}yes${normal}):"
    read -p ":: " -r answer
    case "$answer" in
    y | Y | yes | YES | Yes | *[[:blank:]]* | "")
      return 0
      ;;
    n | N | no | NO | No)
      return 1
      ;;
    *)
      echo -e "${bold}${purple}  ->\033[0m${normal} Please answer ${green}[y]${normal}es or \
                ${red}[n]${normal}o.${normal}"
      ;;
    esac
  done
}

main() {

  echo -e "${bold}Help:  j / ↑ (up), k / ↓ (down)          Move up/down\n\
       q                                 Cancel the installation\n\
       ⎵ (Space)                         Select/Deselect item \n\
       ⏎ (Enter)                         Proceed to installation\n${normal}"

  echo -e "${bold}Select the features to install:${normal}"
  echo -e "${grey}[ x ]   Config files [Required]${normal}"
  echo -e "${grey}[ x ]   Dependencies [Required]${normal}"
  echo -e "${grey}[ x ]   Fonts [Required]${normal}"

  install_options=(
    "Icons [Recommended]"
    "AstroNvim [Install neovim]"
    "Vencord - [Installs discord]"
    "Starship - [Installs fish shell]"
    "Dunst"
    "Gtk theme"
    "Additional stuff [github-cli,firefox,pavucontrol]"
  )
  preselection=(
    "true"
    "true"
    "false"
    "false"
    "true"
    "true"
    "false"
  )
  multiselect results install_options preselection

  echo -e "-----------------------------------------------\n"

  print_header "Checking if paru is installed"
  if ! hash paru >/dev/null 2>&1; then
    print_text "Paru not found"
    if confirm "${bold}:: Do you want to install paru?${normal}"; then
      install_paru
      check_for_error
    else
      echo -e "  ${bold}${red}->${normal} Exiting...${normal}"
      exit 0
    fi
  fi

  # Dependencies
  print_header "Installing dependencies"
  install "${dependencies}"
  check_for_error

  # Fonts
  print_header "Installing fonts"
  install "${fonts}"
  check_for_error

  # Icons
  if [ "${results[0]}" == true ]; then
    print_header "Installing icons"
    install "${icons}"
    check_for_error
  fi

  # AstroNvim
  if [ "${results[1]}" == true ]; then
    print_header "Installing AstroNvim"
    install_nvim
    check_for_error
  fi

  # Vencord
  if [ "${results[2]}" == true ]; then
    print_header "Installing Vencord"
    install_vencord
    check_for_error
  fi

  if [ "${results[3]}" == true ]; then
    print_header "Installing starship"
    install_starship
    check_for_error
  fi

  # Dunst
  if [ "${results[4]}" == true ]; then
    print_header "Installing dunst"
    install_dunst
    check_for_error
  fi

  # GTK theme
  if [ "${results[5]}" == true ]; then
    print_header "Installing Gtk theme"
    install_gtk_theme
    check_for_error
  fi

  # Back up config
  if confirm "${bold}:: Backup the current config?${normal}"; then
    print_header "Backing up config"
    backup_config
    check_for_error
  fi

  # Install config
  print_header "Installing config"
  install_config
  check_for_error

  # Optional stuff
  if [ "${results[6]}" == true ]; then
    print_header "Installing optional stuff"
    install "$optional_stuff"
    check_for_error
  fi

  echo -e "\n-----------------------------------------------\n"
  echo -e "${bold}:: Thanks for using my dotfiles!${normal}"
  echo ':: Do not forget to run "nvim +PackerSync"'
  echo ':: If the GTK theme didnt apply, log out and run "gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark"'
}

install_paru() {
  print_text "Installing paru"
  git clone https://aur.archlinux.org/paru.git

  print_text "Installing dependencies"
  install "${paru_dependencies}"

  print_text "Running makepkg -si"
  cd paru
  makepkg -si
}

install_starship() {
  print_text "Installing fish"
  install $starship_dependencies

  print_text "Changing default shell to fish"
  chsh -s $(which fish)

  print_text "Installing starship"
  install "starship"
}

install_vencord() {
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

install_dunst() {
  print_text "Installing dependencies to build dunst"
  install $dunst_dependencies

  git clone -b progress-styling https://github.com/k-vernooy/dunst/

  print_text "Running make and make install"
  cd dunst
  make && sudo make install
  cd ..
}

install_nvim() {
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

install_gtk_theme() {
  print_text "Copying files in $(pwd)/themes to /usr/share/themes"
  sudo cp -a themes/adw-gtk3-dark/ /usr/share/themes

  print_text "Setting GTK theme to adw-gtk3-dark"
  gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark

  print_text "Setting system color scheme to dark"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}

backup_config() {
  print_text "Copying files from ${HOME}/.config to ${HOME}/.config.bak"
  sudo cp -a ~/.config/. ~/.config.bak/ && sudo rm -rf ~/.config/*
}

install_config() {
  git clone -b arch https://github.com/InioX/dotfiles
  cd dotfiles

  print_text "Copying files in $(pwd)/.config folder to ${HOME}/.config/"
  cp .config/. -ar ~/.config/

  print_text "Copying files in $(pwd)/home to ${HOME}/"
  cp -ar home/ ~
}

check_for_error() {
  if [ $? -ne 0 ]; then
    echo -e "  ${bold}${red}->${normal} ${header} failed.${normal}"
    exit 1
  else
    echo -e "  ${green}->${normal} ${header} succeeded."
  fi
}

# From https://unix.stackexchange.com/a/673436
multiselect() {
  # little helpers for terminal print control and key input
  ESC=$(printf "\033")
  cursor_blink_on() { printf "$ESC[?25h"; }
  cursor_blink_off() { printf "$ESC[?25l"; }
  cursor_to() { printf "$ESC[$1;${2:-1}H"; }
  print_inactive() { printf "$2   $1 "; }
  print_active() { printf "$2   ${purple}$1${normal} "; }
  get_cursor_row() {
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo ${ROW#*[}
  }

  local return_value=$1
  local -n options=$2
  local -n defaults=$3

  local selected=()
  for ((i = 0; i < ${#options[@]}; i++)); do
    if [[ ${defaults[i]} = "true" ]]; then
      selected+=("true")
    else
      selected+=("false")
    fi
    printf "\n"
  done

  # determine current screen position for overwriting the options
  local lastrow=$(get_cursor_row)
  local startrow=$(($lastrow - ${#options[@]}))

  # ensure cursor and input echoing back on upon a ctrl+c during read -s
  trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
  cursor_blink_off

  key_input() {
    local key
    IFS= read -rsn1 key 2>/dev/null >&2
    if [[ $key = "" ]]; then echo enter; fi
    if [[ $key = $'\x20' ]]; then echo space; fi
    if [[ $key = "k" ]]; then echo up; fi
    if [[ $key = "j" ]]; then echo down; fi
    if [[ $key = "q" ]]; then echo q; fi
    if [[ $key = $'\x1b' ]]; then
      read -rsn2 key
      if [[ $key = [A || $key = k ]]; then echo up; fi
      if [[ $key = [B || $key = j ]]; then echo down; fi
    fi
  }

  toggle_option() {
    local option=$1
    if [[ ${selected[option]} == true ]]; then
      selected[option]=false
    else
      selected[option]=true
    fi
  }

  print_options() {
    # print options by overwriting the last lines
    local idx=0
    for option in "${options[@]}"; do
      local prefix="[   ]"
      if [[ ${selected[idx]} == true ]]; then
        prefix="[ ${green}x${normal} ]"
      fi

      cursor_to $(($startrow + $idx))
      if [ $idx -eq $1 ]; then
        print_active "$option" "$prefix"
      else
        print_inactive "$option" "$prefix"
      fi
      ((idx++))
    done
  }

  local active=0
  while true; do
    print_options $active

    # user key control
    case $(key_input) in
    q) exit 0 ;;
    space) toggle_option $active ;;
    enter)
      print_options -1
      break
      ;;
    up)
      ((active--))
      if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi
      ;;
    down)
      ((active++))
      if [ $active -ge ${#options[@]} ]; then active=0; fi
      ;;
    esac
  done

  # cursor position back to normal
  cursor_to $lastrow
  printf "\n"
  cursor_blink_on

  eval $return_value='("${selected[@]}")'
}
main "$@"
