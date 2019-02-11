#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

res=$(echo "-Sair;-Reiniciar;-Desligar" | rofi -sep ";" -dmenu -p "Controle do sistema" -separator-style none -location 0 -width 40 -lines 3 -padding 40)
if [ ! -z $res ]; then
  case $res in
     -Sair)
      i3-msg exit
    ;;
    -Reiniciar)
      systemctl reboot
    ;;
    -Desligar)
      systemctl poweroff
    ;;
  esac
fi
