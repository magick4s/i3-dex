#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

titulo="."
data=$(date +%Y-%m-%d--%H-%M-%S)
nome="Screenshot-Selecionada--${data}"
tipo="image/png"

if [ -f $HOME/.config/user-dirs.dirs ]; then
	source $HOME/.config/user-dirs.dirs
	dir="${XDG_PICTURES_DIR}/Screenshots/"
else
	dir="${HOME}/Imagens/Screenshots/"
fi

[ ! -d $dir ] && mkdir -p $dir

maim --select -d 1 --bordersize 2 --color=0.15,0.17,0.26,1 "$nome"

if [ ! -z $nome ]; then
	if [ $(pwd) != $dir ]; then
		mv $nome $dir
	fi
	xclip -selection c -t $tipo -i $dir$nome
fi

notify-send -i $titulo "Captura realizada" "$nome" -i $HOME/.config/dunst/icones/screenshot.png
exit 0
