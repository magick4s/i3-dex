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
	sudo pacman -S --needed --noconfirm alsa-utils compton ffmpeg git go hsetroot i3-gaps maim mpv networkmanager playerctl pulseaudio pulseaudio-alsa rofi termite ttf-dejavu ttf-fira-mono ttf-fira-sans vim w3m xorg-server xorg-xinit xorg-xrandr

	# Instalando yay
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si --noconfirm
	cd ..
	sudo rm -dR yay

	# Pacotes Instalados com yay
	yay -S --needed --noconfirm google-chrome polybar pqiv

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
	sudo rm -dR $HOME/{.vim,.vimrc} 1> /dev/null 2> /dev/null
    
	# Removendo arquivos da .config
	sudo rm -dR $HOME/.config/{instalador.sh,compton,dunst,gtk-3.0,i3,neofetch,polybar,ranger,rofi,scripts,termite,wallpaper} 1> /dev/null 2> /dev/null

	# Removendo os temas
	sudo rm -dR $HOME/.local/share/themes/I3\ Dex 1> /dev/null 2> /dev/null
	
	# Removendo arquivos de desenvolvedor
	sudo rm -dR $HOME/.config/scripts/desenvolvedor/dev.sh

echo -e "\e[33m\e[1m==> \e[39m\e[1mInstalando configuração\e[0m"
	# Configurando o vim
	mkdir $HOME/.vim 1> /dev/null 2> /dev/null
	cp .vimrc $HOME
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	vim -c 'PluginInstall' -c 'qa!'	

	# Configurando o Gerenciador de Login
	git clone --recurse-submodules https://github.com/cylgom/ly.git
	cd ly
	make
	sudo make install
	sudo systemctl enable ly.service
	sudo systemctl disable getty@tty2.service
	cd ..
	sudo rm -dR ly

	# Copiando fontes
	cp -r feather.ttf $HOME/.local/share/fonts/ 1> /dev/null 2> /dev/null

	# Copiando os arquivos de funcionamento
	cp -r {instalador.sh,compton,dunst,gtk-3.0,i3,neofetch,polybar,ranger,rofi,scripts,termite,wallpaper} $HOME/.config 1> /dev/null 2> /dev/null

	# Copiando o tema para o diretório
	cp -r themes/I3\ Dex $HOME/.local/share/themes 1> /dev/null 2> /dev/null

echo -e "\e[33m\e[1m==> \e[39m\e[1mDeseja instalar os pacotes extras?\e[0m"
if pergunta "S - Para sim || N - Para não ----" S; then
	# Instalando pacotes extras
fi

echo -e "\e[33m\e[1m==> \e[39m\e[1mFinalizando\e[0m"
	i3-msg restart
	notify-send "Instalação finalizada" -i $HOME/.config/dunst/icones/instalador.png
