TOGGLE=$HOME/.toggle_mode
light_wallpaper=$1
dark_wallpaper=$2

mkdir -p ~/.local/share/matugen

ln -sf $light_wallpaper ~/.local/share/matugen/light
ln -sf $dark_wallpaper ~/.local/share/matugen/dark

if [ ! -e $TOGGLE ]; then
    matugen image $dark_wallpaper
    touch $TOGGLE
else
    rm $TOGGLE
    matugen image $light_wallpaper -m "light"
fi