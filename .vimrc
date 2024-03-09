" Vimrc (danirod's fork: http://github.com/danirod/vimrc)
"
"   1) Generic settings
"   2) Vim-Plug plugins
"   3) File settings
"   4) Specific filetype settings
"   5) Colors and UI
"   6) Maps and functions

"---------------------"
" 1) Generic settings "
"---------------------"
set nocompatible    " disable vi compatibility mode
set history=10000   " increase history size


"---------------------"
" 2) Vim-Plug plugins "
"---------------------"

" Check if Vim-Plug is installed: https://github.com/junegunn/vim-plug/issues/225#issuecomment-891314455
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Init Vim-Plug
call plug#begin('~/.vim/plugged/')

"-----------------
" Plug-ins

" A tree explorer
Plug 'scrooloose/nerdtree'

" Source code browser
Plug 'majutsushi/tagbar'

" Show git diff in left column
Plug 'airblade/vim-gitgutter'

" Files and more finder
Plug 'ctrlpvim/ctrlp.vim'

" Buffers tabs
Plug 'ap/vim-buftabline'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Vim status bar
Plug 'vim-airline/vim-airline'

" Move lines and slections up/down
Plug 'matze/vim-move'

" Comments
Plug 'tomtom/tcomment_vim'

" SnipMate: snippets autocompletation
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Holy shit: https://github.com/Valloric/YouCompleteMe
"Plug 'Valloric/YouCompleteMe'

"-----------------
" Language support

" Add |end| in some structures like ifs in Ruby
Plug 'tpope/vim-endwise'

" Add closed tags
Plug 'alvan/vim-closetag'

" Rails support
Plug 'tpope/vim-rails'

" Rake support
Plug 'tpope/vim-rake'

"-----------------
" Colorschemes

" Default is fine
Plug 'tomasr/molokai'
Plug 'cschlueter/vim-wombat'

call plug#end()


"------------------"
" 3) File settings "
"------------------"
set noswapfile  " goodbye .swp
set nobackup

" Modify indenting settings
set autoindent      " autoindent always ON.
set expandtab       " expand tabs
set shiftwidth=4    " spaces for autoindenting
set softtabstop=4   " remove a full pseudo-TAB when i press <BS>

" Modify some other settings about files
set backspace=indent,eol,start  " backspace always works on insert mode
set hidden


"-------------------------------"
" 4) Specific filetype settings "
"-------------------------------"
autocmd FileType html,css,sass,scss,javascript setlocal sw=2 sts=2
autocmd FileType json setlocal sw=2 sts=2
autocmd FileType ruby,eruby setlocal sw=2 sts=2
autocmd FileType yaml setlocal sw=2 sts=2
autocmd FileType sh,zsh setlocal sw=2 sts=2

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.erb,*.xml.erb,*.xml"


"------------------"
" 5) Colors and UI "
"------------------"
" Are we supporting colors?
if &t_Co > 2 || has("gui_running")
    syntax on
    set colorcolumn=80
endif

" Extra fancyness if full pallete is supported.
if &t_Co >= 256 || has("gui_running")
    set cursorline
    silent! color molokai
    "silent! color wombat256
endif

" Trailing spaces
if &t_Co > 2 || has("gui_running")
    " Because we have color, colourize them
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
else
    " Fallback
    set listchars=trail:~
    set list
endif

set fillchars+=vert:\   " remove unpleasant pipes from vertical splits

set showmode        " always show which more are we in
set laststatus=2    " always show statusbar
set wildmenu        " enable visual wildmenu

set nowrap          " don't wrap long lines
set number          " show line numbers
set showmatch       " higlight matching parentheses and brackets
set hlsearch        " higlights searchs


"-----------------------"
" 6) Maps and functions "
"-----------------------"
let mapleader=","

" Make window navigation less painful
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" NERDTree: map ,nt for toggling NERDTree
nmap <Leader>nt :NERDTreeToggle<cr>
:let g:NERDTreeWinSize=20

" CtrlP: to CtrlT (CtrlP is for buffers)
let g:ctrlp_map = '<C-t>'

" Vim-move: set key bindings and arrow equivalents
" Shift + <HJKL>
let g:move_key_modifier = 'S'

" Shift + Arrows
nnoremap <S-Up> :m -2<CR>
nnoremap <S-Down> :m +1<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Vim-buftabline: work with buffer tabs
set hidden
map <C-N>  :bnext<CR>
map <C-P>  :bprev<CR>
imap <C-N> <Esc>:bnext<CR>a
imap <C-P> <Esc>:bprev<CR>a

" Relative numbering column
nmap <F5> :set invrelativenumber<CR>
imap <F5> <ESC>:set invrelativenumber<CR>a

" Tagbag: togle code browser
nmap <F8> :TagbarToggle<CR>

" CTags
set tags=./tags;

" Use Ack instead of grep
set grepprg=ack

" Grep jumps mapping
nmap <F3> :cprev<CR>
nmap <S-F3> :cpfile<CR>
nmap <C-F3> :colder<CR>
nmap <F4> :cnext<CR>
nmap <S-F4> :cnfile<CR>
nmap <C-F4> :cnewer<CR>

" Autostart plugins
" autocmd VimEnter * NERDTree
autocmd VimEnter * Tagbar

" Fix Legacy Parser Warning for snipMate
let g:snipMate = { 'snippet_version' : 1 }
