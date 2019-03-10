" jirrezdex@gmail.com
" Jirrez Matheus

" Configurações
set nu
set ruler
set ic
set ai
set tabstop=4
set shiftwidth=4
set title
syntax on
set background=light

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins necessários
Plugin 'VundleVim/Vundle.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Plugins pessoais

" Finalização Vundle
call vundle#end()
filetype plugin indent on

" Configuração Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Markdown Preview
let vim_markdown_preview_browser='google-chrome'
let vim_markdown_preview_github=1
