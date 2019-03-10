#!/usr/bin/env bash
# Jirrez Matheus
# jirrezdex@gmail.com

# Exclusão ecriação do diretório GitHub
sudo rm -dR $HOME/GitHub 1> /dev/null 2> /dev/null
mkdir $HOME/GitHub 1> /dev/null 2> /dev/null
cd $HOME/GitHub 1> /dev/null 2> /dev/null

# Blogger
git clone https://github.com/jirrezdex/blogger

# Galeria
git clone https://github.com/jirrezdex/galeria

# Galeria-Privada
git clone https://github.com/jirrezdex/galeria-privada

# I3 DEX
git clone https://github.com/jirrezdex/i3-dex

# github.io
git clone https://github.com/locallinux/locallinux.github.io.git

# Widget Github
git clone https://github.com/jirrezdex/widget-github
