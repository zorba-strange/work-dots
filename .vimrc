" SOME OF THIS WAS TAKEN FROM https://dougblack.io/words/a-good-vimrc.html 

set nocompatible                " be iMproved, required
filetype off                    " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ==== PLUGINS START ====
" Fuzzy path finder
Plugin 'kien/ctrlp.vim'

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" For easy commenting out lines
Plugin 'tpope/vim-commentary'

" For easy html set up
Plugin 'mattn/emmet-vim'

" Tpope
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'

" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" VimFiler
Plugin 'Shougo/vimfiler.vim'

" Syntax highlighting and indenting for JSX.
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Plugins config
" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='distinguished'

" mxw react syntax highlight for js files as well
let g:jsx_ext_required = 0

" ctrlp fuzzy file finder
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_by_filename = 1

" NERDTREE start automatically
autocmd vimenter * NERDTree     
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let g:NERDTreeShowHidden=1      " show hidden files
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" easy open Nerdtree
map <Leader>f :NERDTreeToggle<CR>


" "Plugins need to be above this call
call vundle#end()
filetype plugin indent on
" ==== PLUGINS END ====

" Colors
syntax enable                   " Displays syntax in different colors
colorscheme monochrome
" colorscheme mirodark

" Setting line numbers and making them relative
set nu
set rnu

set history=10000

" Map Leader
let mapleader = ";"
let g:mapleader = ";"

" Remapping Insert Mode
inoremap jj <Esc>
inoremap JJ <Esc> 
inoremap <c-u> <Esc>viwUea

" Smarter way to move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k

" Move between buffers in Normal Mode
nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>

set vb                          " Setting a visual bell

" This changes the values of a LOT of options, enabling features which
" are not Vi compatible but really really nice.
set nocp

" delete line and enter insert mode
:nnoremap <leader>c ddO

" opend and edit .vimrc file while working
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" ==== SEARCHING ====
nnoremap <c-space> ?
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches
set ignorecase                  " Ignore case when searching
set smartcase                   " When searching try to be smart about cases

"  search highlight
nnoremap <leader><space> :nohlsearch<CR>

" ==== FOLDING ====
" open and close folds
nnoremap <space> za             

set foldenable                  " enable folding
set foldlevelstart=10           " open most folds by default
set foldcolumn=1                " Add a bit extra margin to the left
set foldnestmax=10              " 10 nested fold max
set foldmethod=indent           " fold based on indent level

set spell                       " Turn spellcheck on
hi clear SpellBad
hi SpellBad cterm=underline

set ruler                       " Always show current position

set cmdheight=2                 " Height of the command bar


set showmatch                   " Show matching brackets when text indicator is over them
set mat=2                       " How many tenths of a second to blink when matching brackets

set noswapfile

set smarttab                    " Be smart when using tabs ;)
set shiftwidth=4
set tabstop=4                   " number of visual spaces per TAB
set softtabstop=2               " number of spaces in tab when editing
set expandtab                   " tabs are spaces

set lbr                         " Linebreak on 700 characters
set tw=700

filetype indent on              " load filetype-specific indent files
set ai                          " Auto indent
set si                          " Smart indent
set wrap                        " Wrap lines

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set laststatus=2               " Always show the status line
set textwidth=80
set showcmd                    " show command in bottom bar
set cursorline                 " highlight current line
set wildmenu                   " visual autocomplete for command menu

" ==== SURROUND WORDS IN QUOTES, BRACKETS, AND <>

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

nnoremap <leader>< viw<esc>a><esc>hbi<<esc>lel


" ==== FIX COMMON MISSPELLINGS ====

iabbrev lenght length


" ==== FUNCTIONS ====

" strips trailing whitespace at the end of files. this 
" is called on buffer write in the autogroup above.
" currently do not have an autogroups so this does nothing.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
