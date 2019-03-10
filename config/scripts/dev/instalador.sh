#!/usr/bin/env bash
# Jirrez Matheus
# jirrezdex@gmail.com

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

echo -e "==> Olá "$USER", a instalação do I3-Dex está sendo inciada!"

echo -e "==> Instalado pacotes essenciais"
	# Instalado pacotes com o "pacman"
		sudo pacman -S --needed --noconfirm alsa-utils git go i3-gaps pulseaudio pulseaudio-alsa termite ttf-dejavu vim xorg-server xorg-xinit xorg-xrandr powerline-fonts ttf-fira-mono ttf-fira-sans hsetroot compton dunst rofi ranger libnotify maim ffmpeg networkmanager

	# Instalando "YAY"
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm
		cd ..
		sudo rm -dR yay

	# Instalado pacotes com o "YAY"
		yay -S --needed --noconfirm google-chrome polybar nerd-fonts-source-code-pro

	# Instalando gerenciador de login "LY"
		git clone --recurse-submodules https://github.com/cylgom/ly.git
		cd ly
		make
		sudo make install
		cd ..
		sudo rm -dR ly

echo -e "==> Habilitando serviços"
	# Habilitando dhcpcd
		sudo systemctl enable dhcpcd.service
		sudo systemctl start dhcpcd
		
	# Habilitando NetworkManager
		sudo systemctl enable NetworkManager.service
		sudo systemctl start NetworkManager

	# Habilitando LY
		sudo systemctl enable ly.service
		sudo systemctl disable getty@tty2.service

echo -e "==> Criando diretórios básicos"
	# Diretórios $HOME/
		mkdir $HOME/{Documentos,Downloads,GitHub,Imagens,Modelos,Música,Público,Vídeos,Área\ \de\ \trabalho} 1> /dev/null 2> /dev/null

	# Diretório $HOME/Imagens/
		mkdir $HOME/Imagens/Screenshots 1> /dev/null 2> /dev/null

	# Diretório $HOME/Vídeos/
		mkdir $HOME/Vídeos/Screencasts 1> /dev/null 2> /dev/null

echo -e "==> Baixando I3-Dex"
	cd $HOME/GitHub
	sudo rm -dR i3-dex 1> /dev/null 2> /dev/null
	git clone https://github.com/jirrezdex/i3-dex.git | exit
	cd i3-dex/config

echo -e "==> Fornecendo permissões essenciais"
	# Permissões gerais
		chmod +x *

	# Permissões para os scripts
		chmod +x scripts/*

	# Permissões para os scripts de desenvolvedor
		chmod +x scripts/dev/*

echo -e "==> Medidas de segurança"
	# Removendo arquivos da $HOME
		sudo rm -dR $HOME/{.vim/.vimrc} 1> /dev/null 2> /dev/null

	# Removendo arquivos da $HOME/.config
		sudo rm -dR $HOME/.config/{instalador.sh,compton,dunst,gtk-3.0,i3,polybar,ranger,rofi,scripts,termite,wallpaper} 1> /dev/null 2> /dev/null

    # Removendo arquivos da $HOME/.local/share/themes
		sudo rm -dR $HOME/.local/share/themes 1> /dev/null 2> /dev/null

	# Removendo arquivos da $HOME/.config/scripts/dev
		sudo rm -dR $HOME/.config/scripts/dev

echo -e "==> Instalando configurações"
	# VIM
		mkdir $HOME/.vim 1> /dev/null 2> /dev/null
		cp .vimrc $HOME
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
		vim -c 'PluginInstall' -c 'qa!'

	# I3-Dex 
		cp -r {instalador.sh,compton,dunst,gtk-3.0,i3,polybar,ranger,rofi,scripts,termite,wallpaper} $HOME/.config 1> /dev/null 2> /dev/null

	# THEME
		cp -r themes $HOME/.local/share 1> /dev/null 2> /dev/null
		
echo -e "==> Finalizando instalação"
	i3-msg restart
	notify-send "Instalação finalizada" -i $HOME/.config/dunst/icones/instalador.png
