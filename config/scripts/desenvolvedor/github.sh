#!/usr/bin/env bash
# jirrezdex@gmail.com
# Jirrez Matheus

pergunta() {
	local prompt default reply
	while true; do
		if [ "${2:-}" = "Y" ]; then
			prompt="S/N"
			default=S
		elif [ "${2:-}" = "N" ]; then
			prompt="S/N"
			default=N
		else
			prompt="S/N"
			default=
		fi
		echo -n "$1 [$prompt] "
		read reply </dev/tty
		if [ -z "$reply" ]; then
			reply=$default
		fi
		case "$reply" in
			[Ss]*) return 0 ;;
			[Nn]*) return 1 ;;
		esac
	done
}

echo -e "\e[33m\e[1m==> \e[39m\e[1mOlá "$USER"!\e[0m"

echo -e "\e[33m\e[1m==> \e[39m\e[1mVerificando\e[0m"
	cd $HOME/GitHub/i3-dex
	git pull
	cd config

echo -e "\e[33m\e[1m==> \e[39m\e[1mMedidas de segurança\e[0m"
	sudo rm -dR {.vimrc,instalador.sh,compton,dunst,i3,neofetch,polybar,rofi,scripts,termite,themes,wallpaper}
	mkdir themes

echo -e "\e[33m\e[1m==> \e[39m\e[1mCopiando arquivos\e[0m"
	cp -r $HOME/.vimrc $HOME/GitHub/i3-dex/config
	cp -r $HOME/.config/{instalador.sh,compton,dunst,i3,neofetch,polybar,rofi,scripts,termite,wallpaper} $HOME/GitHub/i3-dex/config
	cp -r $HOME/.local/share/themes/I3\ Dex $HOME/GitHub/i3-dex/config/themes
	notify-send "Cópia concluída"

echo -e "\e[33m\e[1m==> \e[39m\e[1mDeseja fazer upload para o GitHub?\e[0m"
if pergunta "S - Para sim || N - Para não ----" S; then
	cd $HOME/GitHub/i3-dex
	git add --all
	git commit
	git push -u origin master
	notify-send "Arquivos upados" -i $HOME/.config/dunst/icones/github.png
fi
