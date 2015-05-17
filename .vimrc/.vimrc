let mapleader = ","
let maplocalleader = ","

execute pathogen#infect()

syntax on

set number
set numberwidth=5
set incsearch

filetyp plugin indent on
set shiftwidth=4
set expandtab
set autoindent
set showmatch
set hlsearch

"Highlight current line
set cursorline
set cmdheight=2

syntax enable
:set t_Co=256
set background=dark
colorscheme solarized
"colorscheme monokai

set foldmethod=syntax
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" map ctrl + c keys to autocomplete using emmet

imap <c-c> <c-y>,
vmap <c-w> <c-y>,

"Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

"Fuzzy search files with ctrl.p plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
" check it here https://github.com/kien/ctrlp.vim

"Never have to lift your fingers just to escape insert mode ':'"
imap jk <Esc>

set autoindent
set smartindent

let g:gitgutter_highlight_lines = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set a different background color on gutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight clear SignColumn 
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTI PURSOPSE TAB KEY
" Indent if we are at the begining of a line, else, do completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<Tab>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   RENAME CURRENT FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <c-r> :call RenameFile()<cr>
