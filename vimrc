"use pathogen
execute pathogen#infect()

"use sensible, but override some settings
runtime! plugin/sensible.vim

"plugin configuration
let g:ctrlp_map = '<c-o>'

"vim configuration (overriding sensible)
set nocompatible
set number
set ruler
set noerrorbells
set nowrap
set noexpandtab
set ignorecase
set smartcase
set hlsearch
set showcmd

"this is a bit ugly..
set shiftwidth=4
set softtabstop=4
set tabstop=4

set backup
set backupdir=~/.vim/backup/

map <S-h> gT
map <S-l> gt

if has("gui_running")
	" See ~/.gvimrc
   set guifont=Monospace\ 10  " use this font
   set lines=50       " height = 50 lines
   set columns=100        " width = 100 columns
   set background=light   " adapt colors for background
   set selectmode=mouse,key,cmd
   set keymodel=
else
        colorscheme elflord    " use this color scheme
"       colorscheme delek    " use this color scheme
        set background=dark        " adapt colors for background
"       set background=light        " adapt colors for background
endif


autocmd FileType c,cpp,java,php set cindent
autocmd FileType c,cpp,java set expandtab

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

"include neocomplcache.conf
source ~/.vim/neocomplcache.conf
