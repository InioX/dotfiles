starship init fish | source

# function fish_greeting
#     fastfetch
# end

set fish_greeting

direnv hook fish | source

if status is-interactive
    alias lst="eza --icons=auto -T --short-nix"
    alias ls="eza --icons=auto --short-nix"
    alias cd="z"
    alias flake-update="nix flake update --flake ~/dev/dotfiles/nixos"
    alias nix-update="nh os switch ~/dev/dotfiles/nixos"
    alias develop="nix develop -c fish"
    alias reboot-windows="systemctl reboot --boot-loader-entry=auto-windows"

    function nix-run
        nix run -- "nixpkgs#$argv[1]" $argv[2..-1]
    end

    function start-live-server
        live-server --port 5500 -o $argv
    end

end
