if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    neofetch --ascii ~/.config/neofetch/ascii.txt
    alias ls 'lsd -F'
    alias la 'lsd -aF'
end

set -U fish_greeting
