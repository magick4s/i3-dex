#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

################ Aplicando wallpaper de acordo com a hora
HORA=$(date "+%k")
    if ((HORA >= 20 )); then
        feh --bg-scale $HOME/.config/wallpaper/noite.png ;
    elif ((HORA >= 6 )); then
        feh --bg-scale $HOME/.config/wallpaper/dia.png ;
    else
        feh --bg-scale $HOME/.config/wallpaper/noite.png ;
fi

sleep 60m ;

done