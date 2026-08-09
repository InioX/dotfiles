starship init fish | source

# function fish_greeting
#     fastfetch
# end

set fish_greeting

if status is-interactive
    alias lst="eza --icons=auto -T --short-nix"
    alias ls="eza --icons=auto --short-nix"
    alias flake-update="nix flake update --flake ~/dev/dotfiles/nixos"
    alias nix-update="nh os switch ~/dev/dotfiles/nixos"
    alias develop="nix develop -c fish"

    function nix-run
        nix run -- "nixpkgs#$argv[1]" $argv[2..-1]
    end
end
