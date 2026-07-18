TOGGLE=$HOME/.toggle_mode

light_wallpaper=$(realpath ~/.local/share/matugen/light)
dark_wallpaper=$(realpath ~/.local/share/matugen/dark)

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    matugen image $light_wallpaper -m "light" -v
else
    rm $TOGGLE
    matugen image $dark_wallpaper -v
fi