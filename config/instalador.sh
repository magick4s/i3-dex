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
	sudo pacman -S --needed --noconfirm xorg-xinit xorg-server xorg-xrandr i3-gaps rofi compton termite ranger firefox vim git go maim ffmpeg pulseaudio pulseaudio-alsa alsa-utils xclip libnotify dunst compton ttf-dejavu ttf-fira-sans ttf-fira-mono feh terminus-font playerctl
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ..
	sudo rm -dR yay
	yay -S --needed --noconfirm polybar pqiv nerd-fonts-source-code-pro

echo "== > Habilitando serviços"
	sudo systemctl enable dhcpcd.service
	sudo systemctl start dhcpcd
	sudo systemctl enable NetworkManager.service
	sudo systemctl start NetworkManager

echo "== > Criando diretórios"
	mkdir $HOME/{Documentos,Downloads,GitHub,Imagens,Modelos,Música,Público,Vídeos,Área\ \de\ \trabalho}
	mkdir $HOME/Imagens/Screenshots
	mkdir $HOME/Vídeos/Screencasts

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
	rm -dR $HOME/{.vimrc,.xinitrc}
	rm -dR $HOME/.config/{instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,wallpaper}
	sudo rm /ect/xdg/termite

echo "== > Instalando configuração"
    cp -r {instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,wallpaper} $HOME/.config
    sudo cp -r termite /etc/xdg
	mkdir $HOME/.local/share/fonts
    cp feather.ttf $HOME/.local/share/fonts
    mkdir $HOME/.vim
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	cp .vimrc $HOME
	echo "exec i3" > $HOME/.xinitrc

echo "== > Finalizando"
	notify-send "Instalação finalizada"
