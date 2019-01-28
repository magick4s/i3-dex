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
            [Ss]*) return 0  ;;
            [Nn]*) return  1 ;;
        esac
    done
}

echo "== > Olá "$USER"."

echo "== > Instalando pacotes essenciais"
	sudo pacman -S --needed --noconfirm cmus w3m compton xorg-xinit xorg-server xorg-xrandr i3-gaps rofi termite ranger firefox vim git go maim ffmpeg pulseaudio pulseaudio-alsa alsa-utils xclip libnotify dunst ttf-dejavu ttf-fira-sans ttf-fira-mono feh terminus-font playerctl
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	sudo rm -dR yay
	yay -S --needed --noconfirm polybar nerd-fonts-source-code-pro

echo "== > Habilitando serviços"
	sudo systemctl enable dhcpcd.service
	sudo systemctl start dhcpcd
	sudo systemctl enable NetworkManager.service
	sudo systemctl start NetworkManager

echo "== > Criando diretórios"
	mkdir $HOME/{Documentos,Downloads,GitHub,Imagens,Modelos,Música,Público,Vídeos,Área\ \de\ \trabalho} 1> /dev/null 2> /dev/null
	mkdir $HOME/Imagens/Screenshots 1> /dev/null 2> /dev/null
	mkdir $HOME/Vídeos/Screencasts 1> /dev/null 2> /dev/null

echo "== > Baixando I3 Dex"
	cd $HOME/GitHub
	sudo rm -dR i3-dex
	git clone https://github.com/jirrezdex/i3-dex.git | exit
	cd i3-dex/config

echo "== > Fornecendo permissões"
	chmod +x *
	chmod +x desenvolvedor/*
	chmod +x scripts/*

echo "== > Medidas de segurança"
	rm -dR $HOME/{.vimrc,.xinitrc,.vim}
	rm -dR $HOME/.config/{instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,termite,wallpaper}

echo "== > Instalando configuração"
	mkdir $HOME/.vim 1> /dev/null 2> /dev/null
	cp .vimrc $HOME
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	echo "exec i3" > $HOME/.xinitrc
	mkdir $HOME/.local/share/fonts 1> /dev/null 2> /dev/null
	cp feather.ttf $HOME/.local/share/fonts 1> /dev/null 2> /dev/null
	cp -r {instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,termite,wallpaper} $HOME/.config

if pergunta "== > Deseja instalar os pacotes extras?" S; then
	sudo pacman --needed --noconfirm mpv libreoffice-fresh libreoffice-fresh-pt-br rawtherapee gimp blender inkscape thunderbird
    yay --needed --noconfirm visual-studio-code-bin pqiv spotify telegram-desktop
fi

if pergunta "== > Remover configuração do desenvolvedor? RECOMENDADO PARA TOTAL FUNCIONAMENTO!" S; then
	sudo rm -dR .config/desenvolvedor
fi

echo "== > Finalizando"
	notify-send "Instalação finalizada" -i $HOME/.config/dunst/icones/instalador.png