"-----------------------------------------------------------------------------
" Vundle Setup
"-----------------------------------------------------------------------------

set nocompatible   " Disable vi-compatibility
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let $GIT_SSL_NO_VERIFY = 'true'

Bundle 'gmarik/Vundle.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'nelstrom/vim-markdown-folding'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'sjl/gundo.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/genutils'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'vim-scripts/git-time-lapse'
Bundle 'steffanc/cscopemaps.vim'
Bundle 'Lokaltog/powerline'
Bundle 'godlygeek/tabular'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'SirVer/ultisnips'
Bundle "myusuf3/numbers.vim"
Bundle 'honza/vim-snippets'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-dispatch'
Bundle 'neilagabriel/vim-perforce'
Bundle 'neilagabriel/vim-geeknote'

call vundle#end()
filetype plugin indent on 

"-----------------------------------------------------------------------------
" Powerline setup
"-----------------------------------------------------------------------------

set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"-----------------------------------------------------------------------------
" Backup/Persistance Settings
"-----------------------------------------------------------------------------

set undodir=~/.vim/tmp/undo//

set undofile
set history=100
set undolevels=100

nnoremap <F12> :GundoToggle<CR>

"-----------------------------------------------------------------------------
" Misc
"-----------------------------------------------------------------------------

syntax on

set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" disable all error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" highlight search results, <space> to clear
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Disable syntax highlighting in diff mode
if &diff
    syntax off
    set diffopt+=iwhite
endif

" Color-related settings.
set t_Co=256
set background=dark

colorscheme kolor

highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" Break bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"-----------------------------------------------------------------------------
" Android Setup
"-----------------------------------------------------------------------------

autocmd BufNewFile,BufRead */kernel/* set noexpandtab
autocmd BufNewFile,BufRead */kernel/* set tabstop=8

"-----------------------------------------------------------------------------
" Cucumbertables (requires tabular)
"
" https://gist.github.com/tpope/287147
"-----------------------------------------------------------------------------

"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"-----------------------------------------------------------------------------
" Cscope/Ctags Setup
"-----------------------------------------------------------------------------

" Show cscope results in quickfix window - enables cn[ext]/cp[rev]
set cscopequickfix=s-,c-,d-,i-,t-,e-
set tags=./tags,tags,$TOP/tags

"-----------------------------------------------------------------------------
" UltiSnips Configuration
"-----------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

"-----------------------------------------------------------------------------
" GeekNote Utilities
"-----------------------------------------------------------------------------

function! GeekNote()
  !geeknote create --title "`cat % | head -n1`" --content "`cat % | tail -n +2`"
endfunction
noremap <C-e> :call GeekNote()<cr>

