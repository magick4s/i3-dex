#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

controle=$(echo "-Sair;-Reiniciar;-Desligar" | rofi -sep ";" -dmenu -p "Controle do sistema" -bw 4 -separator-style none -location 0 -width 30 -lines 3 -padding 40)
if [ ! -z $controle ]; then
  case $controle in
    -Sair)
      i3-msg exit
    ;;
    -Reiniciar)
      systemctl reboot
    ;;
    -Desligar)
      systemctl poweroff
    ;;
  esac
fi
