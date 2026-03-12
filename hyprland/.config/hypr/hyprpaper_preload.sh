preload_wallpaper() {

    monitor="eDP-1"

    wallpaper_dir="$HOME/.config/hypr/wallpapers/current"

    wallpapers=$(find "$wallpaper_dir" -type f | sort -R )

    for wallpaper in $wallpapers; do
        preload_string+="preload = "$wallpaper"\n"
    done

    echo -en "$preload_string" > ~/.config/hypr/hyprpaper.conf

}

preload_wallpaper
