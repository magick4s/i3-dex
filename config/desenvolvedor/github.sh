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

echo "== > Olá "$USER"!"

echo "== > Verificando"
    cd $HOME/GitHub/i3-dex
    git pull
    cd config

echo "== > Medidas de segurança"
    sudo rm -dR {.vimrc,instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,termite,wallpaper}

echo "== > Copiando arquivos"
	cp $HOME/.vimrc $HOME/GitHub/i3-dex/config
    cp -r $HOME/.config/{instalador.sh,compton,desenvolvedor,dunst,i3,polybar,ranger,rofi,scripts,termite,wallpaper} $HOME/GitHub/i3-dex/config
    notify-send "Cópia concluída"

if pergunta "== > Deseja fazer upload para o GitHub?" S; then
    cd $HOME/GitHub/i3-dex
    git add --all
    git commit
    git push -u origin master
    notify-send "Arquivos upados"
fi
