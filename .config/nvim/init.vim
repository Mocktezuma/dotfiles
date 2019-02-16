call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install'}
Plug 'KabbAmine/vCoolor.vim'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'


" Aesthetics - Main
Plug 'dracula/vim', { 'commit': '147f389f4275cec4ef43ebc25e2011c57b45cc00' }
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-journal'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nightsense/forgotten'
Plug 'zaki/zazen'

" Aethetics - Additional
Plug 'nightsense/nemo'
Plug 'yuttie/hydrangea-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'rhysd/vim-color-spring-night'


call plug#end()

""" Coloring
syntax on
color gruvbox
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:airline_theme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'

""key remap
inoremap §§ <Esc>/<++><Enter>"_c4l
inoremap ;§ <Esc>/<§§><Enter>"_c4l

"Autocommand
autocmd BufWritePost /home/adri/src/st/config.h,/home/adri/src/st/config.def.h,/home/adri/src/dwm/config.h,/home/adri/src/dwm/config.def.h !sudo make install

"""Latex

let g:tex_flavor = "latex"

autocmd FileType tex inoremap ;d \documenclass{article}<Enter>\usepackage[utf8]{inputenc}<Enter>\usepackage[acronym]{glossaries}<Enter>\author{Adrian}<Enter>\title{<++>}<Enter><Enter>\makeglossaries<Enter><--><Enter><Enter>\begin{document}<Enter>\begin{titlepage}<Enter>\maketitle<Enter>\end{titlepage}<Enter><++><Enter>\end{document}
autocmd FileType tex inoremap ;s \section{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;ss \subsection{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;sss \subsubsection{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;p \paragraph{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;pp \subparagraph{}<Space><++><Esc>F{a
autocmd FileType tex inoremap ;ng <§§><Esc>/<--><Enter>"_c4l\newglossaryentry{<++>}<Enter>{<Enter>name=<++>,<Enter>description={<++>}<Enter><Backspace>}<Enter><--><Esc>/<++><Enter>"_c4l
autocmd FileType tex inoremap ;na <§§><Esc>/<--><Enter>"_c4l\newacronym{<++>}{<++>}{<++>}<Enter><--><Esc>/<++><Enter>"_c4l


"Other configuration
set nocompatible
set number relativenumber
set title
set encoding=utf8
let g:airline_powerline_fonts = 1
filetype plugin on

""" Plugin configuration

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
autocmd VimEnter /home/adri/Documents/Project/* NERDTree 

" CoC
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
