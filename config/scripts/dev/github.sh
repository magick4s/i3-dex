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

echo -e "==> Olá "$USER", iniciando backup"
	
echo -e "==> Verificando atualizações"
	cd $HOME/GitHub/i3-dex
	git pull
	cd config

echo -e "==> Medidas de segurança"
	# Removendo arquivos
		sudo rm -dR {.vimrc,compton,dunst,gtk-3.0,i3,polybar,ranger,rofi,scripts,termite,themes,wallpaper}

	# Removendo cache
		sudo rm -dR $HOME/.config/ranger/plugins/__pycache__ 1> /dev/null 2> /dev/null

echo -e "==> Copiando arquivos"
	# Copiando arquivos da $HOME
		cp -r $HOME/.vimrc $HOME/GitHub/i3-dex/config

	# Copiando arquivos da $HOME/.config
		cp -r $HOME/.config/{compton,dunst,gtk-3.0,i3,polybar,ranger,rofi,scripts,termite,wallpaper} $HOME/GitHub/i3-dex/config

	# Copiando arquivos da $HOME/.local/share
		cp -r $HOME/.local/share/themes $HOME/GitHub/i3-dex/config

echo -e "==> Deseja fazer upload para o GitHub?"
if pergunta "==> Para fazer upload pressione - S || Para cancelar upload pressione - N ----" S; then
	cd $HOME/GitHub/i3-dex
	git add --all
	git commit
	git push -u origin master
	notify-send "Arquivos upados" -i $HOME/.config/dunst/icones/github.png
fi
