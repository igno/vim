"use pathogen
execute pathogen#infect()

"use sensible, but override some settings
runtime! plugin/sensible.vim

"plugin configuration
let g:ctrlp_map = '<c-o>'
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\v[\/](node_modules|build/|cache/cookbooks|dist|backup/)|(\.(swp|ico|git|svn|bundle|pyc))$'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

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
set hidden
set wildmode=longest,list,full
set wildmenu

"this is a bit ugly..
set shiftwidth=4
set softtabstop=4
set tabstop=4

set clipboard=unnamed

set backup
set backupdir=~/.vim/backup/

"switch between buffers with shift + h and l
map <S-h> :bp<CR>
map <S-l> :bn<CR>

"close buffer with ctrl + c
map <C-c> :bp<bar>sp<bar>bn<bar>bd<CR>

map <A-h> vertical resize +10<CR>
map <A-l> vertical resize -10<CR>
let g:miniBufExplMapWindowNavVim = 1

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
	"colorscheme delek    " use this color scheme
	set background=dark        " adapt colors for background
	"set background=light        " adapt colors for background
endif


autocmd FileType c,cpp,java,php set cindent
autocmd FileType c,cpp,java set expandtab

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

source ~/.vim/neocomplcache.conf

set t_ut=

if !empty(glob("~/.vim/local_overrides.conf"))
	source ~/.vim/local_overrides.conf
endif
