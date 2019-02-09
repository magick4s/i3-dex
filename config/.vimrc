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
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Plugins pessoais

" Finalização Vundle
call vundle#end()
filetype plugin indent on

" Configuração NERDTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "left"

" Configuração Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Markdown Preview
let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_github=1
