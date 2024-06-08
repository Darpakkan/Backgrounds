#!/bin/bash
# script to set random background wallpapers on my GNOME desktop
# set base path
export wallpaper_path=~/Backgrounds
shopt -s nullglob

while true; do
    # store all the image file names in wallpapers array
    wallpapers=(
        "$wallpaper_path"/*.jpg
        "$wallpaper_path"/*.jpeg
        "$wallpaper_path"/*.png
        "$wallpaper_path"/*.bmp
        "$wallpaper_path"/*.svg
    )

    # shuffle the wallpapers array
    shuffled_wallpapers=($(shuf -e "${wallpapers[@]}"))

    # get array size
    wallpapers_size=${#shuffled_wallpapers[*]}

    # set wallpapers in incremental order
    index=0
    while [ $index -lt $wallpapers_size ]; do
        URI="${shuffled_wallpapers[${index}]}"
        echo "${URI}"
        gsettings set org.gnome.desktop.background picture-options 'centered'
        gsettings set org.gnome.desktop.background picture-uri-dark "${URI}"
        gsettings set org.gnome.desktop.background picture-uri "${URI}"
        # index is maxing out, so reset it
        if [ $(($index+1)) -eq $wallpapers_size ]; then
            index=0
        else
            index=$(($index + 1))
        fi
        # keep the wallpaper for the specified time
        echo "Sleeping...."
        sleep 10
    done
done
