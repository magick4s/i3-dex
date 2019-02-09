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

echo -e "\e[33m\e[1m==> \e[39m\e[1mOlá "$USER".\e[0m"

echo -e "\e[33m\e[1m==> \e[39m\e[1mInstalando pacotes essenciais\e[0m"
	# Básico para o funcionamento do sistema
	sudo pacman -S --needed --noconfirm alsa-utils breeze-icons compton ffmpeg firefox git go gvfs hsetroot i3-gaps maim mpv networkmanager pulseaudio pulseaudio-alsa rofi termite thunar thunar-volman ttf-dejavu ttf-fira-mono ttf-fira-sans vim w3m xorg-server xorg-xinit xorg-xrandr

	# Instalando yay
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	sudo rm -dR yay

	# Pacotes Instalados com yay
	yay -S --needed --noconfirm polybar pqiv ttf-font-awesome ttf-font-awesome-4 visual-studio-code-bin

echo -e "\e[33m\e[1m==> \e[39m\e[1mHabilitando serviços\e[0m"
	# Serviços
	sudo systemctl enable dhcpcd.service
	sudo systemctl start dhcpcd
	sudo systemctl enable NetworkManager.service
	sudo systemctl start NetworkManager

echo -e "\e[33m\e[1m==> \e[39m\e[1mCriando diretórios\e[0m"
	# Criando diretórios básico para o usuário
	mkdir $HOME/{Documentos,Downloads,GitHub,Imagens,Modelos,Música,Público,Vídeos,Área\ \de\ \trabalho} 1> /dev/null 2> /dev/null
	mkdir $HOME/Imagens/Screenshots 1> /dev/null 2> /dev/null
	mkdir $HOME/Vídeos/Screencasts 1> /dev/null 2> /dev/null
	mkdir $HOME/.local/share/fonts 1> /dev/null 2> /dev/null

echo -e "\e[33m\e[1m==> \e[39m\e[1mBaixando I3 Dex\e[0m"
	# Atualizando arquivos e configuração I3 Dex
	cd $HOME/GitHub
	sudo rm -dR i3-dex 1> /dev/null 2> /dev/null
	git clone https://github.com/jirrezdex/i3-dex.git | exit
	cd i3-dex/config

echo -e "\e[33m\e[1m==> \e[39m\e[1mFornecendo permissões\e[0m"
	# Permissões
	chmod +x *
	chmod +x scripts/*
	chmod +x scripts/desenvolvedor/*

echo -e "\e[33m\e[1m==> \e[39m\e[1mMedidas de segurança\e[0m"
	# Removendo arquivos da $HOME
	sudo rm -dR $HOME/{.vim,.vimrc,.xinitrc} 1> /dev/null 2> /dev/null
    
	# Removendo arquivos da .config
	sudo rm -dR $HOME/.config/{instalador.sh,compton,dunst,i3,neofetch,polybar,rofi,scripts,termite,wallpaper} 1> /dev/null 2> /dev/null

	# Removendo os temas
	sudo rm -dR $HOME/.local/share/themes/I3\ Dex

echo -e "\e[33m\e[1m==> \e[39m\e[1mInstalando configuração\e[0m"
	# Configurando o vim
	mkdir $HOME/.vim 1> /dev/null 2> /dev/null
	cp .vimrc $HOME
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	vim -c 'PluginInstall' -c 'qa!'	

	# Configurando o .xinitrc
	echo "exec i3" > $HOME/.xinitrc

	# Copiando fontes
	cp -r feather.ttf $HOME/.local/share/fonts/

	# Copiando os arquivos de funcionamento
	cp -r {instalador.sh,compton,dunst,i3,neofetch,polybar,rofi,scripts,termite,wallpaper} $HOME/.config

	# Copiando o tema para o diretório
	cp -r themes/I3\ Dex $HOME/.local/share/themes

echo -e "\e[33m\e[1m==> \e[39m\e[1mDeseja instalar os pacotes extras?\e[0m"
if pergunta "S - Para sim || N - Para não ----" S; then
	# Pacotes extras com o pacman
	sudo pacman -S --needed --noconfirm blender cmus frei0r-plugins gimp inkscape kdenlive krita libreoffice-fresh libreoffice-fresh-pt-br lxappearance rawtherapee thunderbird

	# Pacotes extras com o yay
	yay -S --needed --noconfirm discord telegram-desktop visual-studio-code-bin
fi

echo -e "\e[33m\e[1m==> \e[39m\e[1mRemover configuração do desenvolvedor? RECOMENDADO PARA TOTAL FUNCIONAMENTO!\e[0m"
if pergunta "S - Para sim || N - Para não ----" S; then
	# Remover arquivos do desenvolvedor
	sudo rm -dR .config/scripts/desenvolvedor
fi

echo -e "\e[33m\e[1m==> \e[39m\e[1mFinalizando\e[0m"
	notify-send "Instalação finalizada" -i $HOME/.config/dunst/icones/instalador.png
