#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

################ Medida protetiva
playerctl status &> $HOME/.música-histórico

################ Exibição de  Artista - Título
if [ $? == 1 ]; then
  echo ""
elif [ "$(playerctl status)" == "Playing" ]; then
  artist=`exec playerctl metadata artist`
  title=`exec playerctl metadata title`
  echo " $artist - $title"
elif [ "$(playerctl status)" == "Paused" ]; then
  artist=`exec playerctl metadata artist`
  title=`exec playerctl metadata title`
  echo " $artist - $title"
else
  echo ""
fi
