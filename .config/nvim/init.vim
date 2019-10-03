syntax on


call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdTree'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'

call plug#end()

nmap <C-n> :NERDTreeToggle<CR>
let g:user_emmet_expandabbr_key = '<C-a>,'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

set autoindent
set smartindent
set number
set ruler relativenumber

filetype plugin on
